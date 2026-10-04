#!/usr/bin/env bash
# Stop 훅: 스킬 관련 파일이 바뀌었으면 점검 → 목록 갱신 → 커밋 → 푸시. 세션을 막지 않는다(항상 exit 0).
# 비공개 저장소에서만 동작한다(.claude/autosave-visibility = private + GitHub API 확인). 공개 저장소에서는 아무것도 올리지 않는다.
cd "$(git rev-parse --show-toplevel 2>/dev/null)" || exit 0
PATHS=(.claude/skills library skills.json docs/skill-index.md docs/skill-ledger.md HANDOFF.md)
[ -n "$(git status --porcelain -- "${PATHS[@]}" 2>/dev/null)" ] || exit 0

BR="$(git rev-parse --abbrev-ref HEAD)"
case "$BR" in main|master|HEAD) echo "[autosave] $BR 브랜치라서 자동 저장을 건너뜁니다" >&2; exit 0 ;; esac

# 절대 규칙: 사용자의 스킬·기록은 비공개 저장소에만 자동 저장한다.
# 1) .claude/autosave-visibility 가 정확히 private 이어야 하고, 2) GitHub API가 공개(private=false)라고 답하면 설정과 무관하게 거부한다.
VIS="$(tr -d '[:space:]' < .claude/autosave-visibility 2>/dev/null)"
if [ "$VIS" != "private" ]; then
  echo "[autosave] 비공개 저장소 설정(private)이 없어 자동 저장하지 않았습니다. 사용자의 스킬은 공개 저장소에 올리지 않습니다." >&2; exit 0
fi
slug="$(git remote get-url origin 2>/dev/null | sed -E 's#\.git$##' | awk -F/ 'NF>=2{print $(NF-1)"/"$NF}')"
if command -v gh >/dev/null 2>&1 && [ -n "$slug" ]; then
  priv="$(gh api "repos/$slug" --jq .private 2>/dev/null)"
  if [ "$priv" = "false" ]; then
    echo "[autosave] $slug 는 공개 저장소입니다. 설정이 private 여도 올리지 않습니다." >&2; exit 0
  fi
fi
python3 scripts/skills.py index >/dev/null 2>&1
if ! python3 scripts/skills.py check --visibility private --changed-only >&2; then
  echo "[autosave] 점검에 걸려 커밋하지 않았습니다. 위 문제를 해결하면 다음 세션 종료 때 다시 시도합니다." >&2
  exit 0
fi

git add -- "${PATHS[@]}"
git diff --cached --quiet && exit 0
n="$(git diff --cached --name-only | wc -l | tr -d ' ')"
git commit -q -m "Auto-save skills and notes ($n files)

Co-Authored-By: Claude Sonnet 5.5 <noreply@anthropic.com>" || exit 0

for wait in 0 2 4 8 16; do
  sleep "$wait"
  git push -q -u origin "$BR" 2>/dev/null && { echo "[autosave] $n개 파일을 $BR 에 저장했습니다" >&2; exit 0; }
done
echo "[autosave] 푸시 실패: 커밋은 로컬에 남았습니다. 다음 종료 때 다시 시도합니다." >&2
exit 0
