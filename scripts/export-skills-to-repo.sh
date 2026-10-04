#!/usr/bin/env bash
# PC의 ~/.claude 스킬을 이 저장소의 .claude/ 로 복사하고 깃허브에 올린다.
# 사용 (이 저장소를 클론한 PC, Git Bash/macOS/Linux):
#   git clone https://github.com/carena75/-AI-.git && cd -AI-
#   git checkout ccr-8fda732d-6wnvpg
#   bash scripts/export-skills-to-repo.sh
# 옵션 환경변수: SRC=스킬폴더  CLAUDE_HOME=~/.claude  NO_PUSH=1(복사·검사만, 커밋/푸시 안 함)
set -euo pipefail

CLAUDE_HOME="${CLAUDE_HOME:-$HOME/.claude}"
SRC="${SRC:-$CLAUDE_HOME/skills}"
REPO="$(cd "$(dirname "$0")/.." && pwd)"
DEST="$REPO/.claude/skills"

# 제외: 계정 동기화 폴더, 플레이리스트 메이커, Anthropic 기본 스킬(저장소에 넣을 필요 없음)
is_excluded() {
  case "$1" in
    synced|.bucket-*|playlist*|Playlist*|plugins) return 0 ;;
    docx|xlsx|pdf|pptx|docs|google-workspace|import-memory|morning|skill-creator|session-start-hook) return 0 ;;
  esac
  return 1
}

[ -d "$SRC" ] || { echo "스킬 폴더가 없습니다: $SRC"; exit 1; }
mkdir -p "$DEST"

copied=0; skipped=()
for d in "$SRC"/*/; do
  name="$(basename "$d")"
  if is_excluded "$name"; then skipped+=("$name"); continue; fi
  rm -rf "$DEST/$name"
  cp -R "$d" "$DEST/$name"
  copied=$((copied+1))
done
echo "복사한 스킬 폴더: $copied 개"
echo "제외한 폴더: ${skipped[*]:-없음}"

# 훅과 전역 CLAUDE.md (라우팅 표)는 별도 위치에 복사 — 자동 연결은 검토 후에 한다
if [ -f "$CLAUDE_HOME/hooks/route-production.js" ]; then
  mkdir -p "$REPO/.claude/hooks"
  cp "$CLAUDE_HOME/hooks/route-production.js" "$REPO/.claude/hooks/route-production.js"
  if [ ! -f "$REPO/.claude/settings.json" ]; then
    cat > "$REPO/.claude/settings.json" <<'JSON'
{
  "hooks": {
    "UserPromptSubmit": [
      { "hooks": [ { "type": "command", "command": "node \"$CLAUDE_PROJECT_DIR/.claude/hooks/route-production.js\"" } ] }
    ]
  }
}
JSON
  fi
  echo "훅 복사: .claude/hooks/route-production.js (+ .claude/settings.json 등록)"
fi
[ -f "$CLAUDE_HOME/CLAUDE.md" ] && cp "$CLAUDE_HOME/CLAUDE.md" "$REPO/.claude/global-CLAUDE.md" && echo "전역 CLAUDE.md → .claude/global-CLAUDE.md"

# 비밀키 검사: 걸리면 중단 (커밋하지 않음)
hits="$(grep -rIlE '(sk-[A-Za-z0-9_-]{20,}|AKIA[0-9A-Z]{16}|ghp_[A-Za-z0-9]{30,}|github_pat_[A-Za-z0-9_]{30,}|xox[baprs]-[A-Za-z0-9-]{10,}|(api[_-]?key|secret|token|password)["'"'"' :=]+[A-Za-z0-9_./+-]{20,})' "$REPO/.claude" 2>/dev/null || true)"
if [ -n "$hits" ]; then
  echo "중단: 비밀키로 의심되는 문자열이 있는 파일이 있습니다. 확인 후 지우고 다시 실행하세요:"
  echo "$hits"
  exit 2
fi
echo "비밀키 검사 통과"
echo "파일 수: $(find "$REPO/.claude" -type f | wc -l)"

if [ "${NO_PUSH:-0}" = "1" ]; then echo "NO_PUSH=1 → 커밋/푸시 생략"; exit 0; fi
cd "$REPO"
git add .claude
if git diff --cached --quiet; then echo "변경 없음"; exit 0; fi
git commit -m "Add Higgsfield production skills, hook and routing notes from local ~/.claude"
git push -u origin HEAD
echo "완료: 다음 클라우드 세션부터 .claude/skills 가 자동 로딩됩니다."
