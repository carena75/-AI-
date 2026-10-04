# (보관) 2026-10-02~04 작업 기록 원문 — 요약은 ../../HANDOFF.md

# HANDOFF

## 2026-10-02~03 모션그래픽 샘플 (Liquid Chrome → Particle Light)
- 컨셉: 은색 물방울 → 유리 파편이 크롬 토러스 매듭으로 조립 → 주황 입자와 빛의 조리개. 12초, 3컷(4초씩), 16:9, 480p
- 최종 영상(오디오 포함, Seedance V1.5 Pro T2V): https://cdn.abocado.ai/ai/video/google_8856089c/mcp_google_8856089c_20261003001240_59ne9e_0.mp4
- 그리드 스토리보드(6패널 한 장): https://cdn.abocado.ai/ai/image/google_8856089c/mcp_google_8856089c_20261003001242_c5rdu2_0.jpg
- 영상 소리와 화면은 직접 보지 못함 → **시각·청각 검수 미확인**
- 크레딧: 시작 20,185 → 18,956. 낭비분: 낱장 프레임 4+1장(255), 이어붙이기 컷 3개(462, 최종본으로 대체됨)

## 교훈
- 스토리보드는 낱장 말고 그리드 한 장. 견적은 options 포함. (CLAUDE.md 참고)
- 힉스필드 스킬 본문 40여 개는 이 저장소에 아직 없음(색인만 `docs/production-skill-guide.md`). 본문은 사용자 PC `~/.claude`에 있음.

## 스킬 이전 (2026-10-04)
- 스킬 본문(~583 md)은 사용자 PC `~/.claude/skills`에만 있음. 클라우드에서는 접근 불가.
- PC에서 `bash scripts/export-skills-to-repo.sh` 실행 → `.claude/skills`, `.claude/hooks`, `.claude/global-CLAUDE.md`로 복사 후 푸시 (playlist 계열·synced·Anthropic 기본 스킬 제외, 비밀키 검사 포함)
- 푸시 후 할 일: `.claude/global-CLAUDE.md`의 라우팅 표를 검토해 `CLAUDE.md`에 연결, 새 세션에서 스킬 자동 로딩 확인
