#!/usr/bin/env bash
# Stop 훅: 스킬 관련 파일이 바뀌었으면 점검 → 목록 갱신 → 커밋 → 푸시. 세션을 막지 않는다(항상 exit 0).
# 공개 저장소(기본)에서는 public_ok=true 스킬과 비밀키 없는 변경만 올린다. 비공개 저장소는 .claude/autosave-visibility 에 private 를 적는다.
cd "$(git rev-parse --show-toplevel 2>/dev/null)" || exit 0
PATHS=(.claude/skills library skills.json docs/skill-index.md docs/skill-ledger.md HANDOFF.md)
[ -n "$(git status --porcelain -- "${PATHS[@]}" 2>/dev/null)" ] || exit 0

BR="$(git rev-parse --abbrev-ref HEAD)"
case "$BR" in main|master|HEAD) echo "[autosave] $BR 브랜치라서 자동 저장을 건너뜁니다" >&2; exit 0 ;; esac

VIS="$(tr -d '[:space:]' < .claude/autosave-visibility 2>/dev/null)"; VIS="${VIS:-public}"
python3 scripts/skills.py index >/dev/null 2>&1
if ! python3 scripts/skills.py check --visibility "$VIS" --changed-only >&2; then
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
