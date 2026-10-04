# library — 보관 중인 스킬 (자동 로딩 안 됨, 토큰 0)

구조: `library/<출처>/<종류>/<스킬이름>/SKILL.md (+ references/)`
- 출처: `higgsfield`, `hix-ai`, `third-party`(외부 공개 스킬), `own`(직접 만든 것)
- 종류: `video` 영상제작 · `image-design` 이미지·디자인 · `planning-marketing-writing` 기획·마케팅·글 · `web-docs` 웹·문서 · `coding-etc` 코딩·기타 · `writing` 글쓰기 · `other`
- 쓰는 스킬만 `.claude/skills/`(평평한 한 폴더)로 올린다: `python3 scripts/skills.py activate <이름>`. 안 쓰면 `archive`.
- 전체 목록·상태·공개 가능 여부: `docs/skill-index.md` (자동 생성), 메타데이터: `skills.json`

## 왜 이렇게
- Claude Code는 `.claude/skills/<이름>/SKILL.md` 한 단계 깊이만 자동으로 찾는다. 종류별 폴더 안에 넣으면 자동 로딩이 안 된다.
- 자동 로딩되는 스킬은 description이 매 세션 컨텍스트에 올라간다. 많이 켤수록 토큰이 는다. 그래서 보관과 사용을 나눈다.
- 이 저장소(`-AI-`)는 공개다. `public_ok`가 `true`가 아닌 스킬(타인 지침서, 구매품 파생, 미확인)은 여기에 두지 않고 비공개 저장소에 둔다.

## 자동 저장
`.claude/settings.json`의 Stop 훅이 `scripts/auto-save.sh`를 실행한다. 스킬 관련 파일(`.claude/skills`, `library`, `skills.json`, `HANDOFF.md` 등)이 바뀌었으면 점검 → 목록 갱신 → 커밋 → 푸시. 공개 저장소에서는 `public_ok=true`와 비밀키 없는 변경만 올라가고, `main` 브랜치는 건너뛴다. 비공개 저장소는 `.claude/autosave-visibility`에 `private`을 적는다.
