# HANDOFF — 새 세션이 가장 먼저 읽는 요약
규칙: 40줄 이내 유지. 오래된 내용은 `docs/history/`로 옮긴다. 비밀키·토큰은 적지 않는다.

## 지금 상태 (2026-10-04)
- 진행 중 프로젝트: 없음. 직전 완료: 12초 모션그래픽 샘플(Liquid Chrome → Particle Light)
- 대기: PC 백업 저장소 `carena75/claude-skills-backup`(비공개) 푸시 확인 → 힉스필드 스킬을 `.claude/skills/`로 이전. **플레이리스트 계열은 구매품이라 제외**
- 사용자 목표: 힉스필드 스킬을 종목별 상품(상세페이지, UGC·쇼츠 광고, 웨딩 영상 등)으로 완성해 수익화. 완성 기준 = 아보카도에서 가장 싼 단계로 실제 테스트 통과
- PC의 Claude Code는 별개 환경(`~\Downloads\클로드코드\skills-backup`). 이 클라우드 세션은 PC 파일을 못 읽는다

## 최근 결과 (job_key로 재조회 가능: `abocado_get_job_status`, 재결제 불필요)
- 12초 영상(Seedance 1.5 T2V, 480p, 오디오 포함): `mcp_google_8856089c_20261003001240_59ne9e`
- 그리드 스토리보드(6패널 1장): `mcp_google_8856089c_20261003001242_c5rdu2`
- 화면·소리 직접 검수는 못 함(시각·청각 검수 미확인)

## 스킬 저장 구조 (결정 2026-10-04)
- 사용중 = `.claude/skills/<이름>/`(평평, 자동 로딩, description만 토큰), 보관 = `library/<출처>/<종류>/<이름>/`(토큰 0). 출처: higgsfield, hix-ai, third-party, own
- 목록·상태: `docs/skill-index.md`(자동 생성), 메타: `skills.json`, 관리: `python3 scripts/skills.py` + 스킬 `skill-library`
- 이 저장소(-AI-)는 **공개**: `public_ok=true`만 둔다. 힉스필드·HIX AI 본문은 **비공개 저장소**에 저장(아직 미연결)
- 확인 필요: `commercial-motion-prompt`는 남이 공유한 가이드에서 만든 듯해 공개 허락 미확인

## 비용 교훈
- 견적에 `generate_audio` 등 옵션을 넣어야 실차감과 맞는다(오디오 켜면 영상 약 2배)
- 스토리보드는 낱장 말고 그리드 1장. 컷별 영상 이어붙이기 대신 전체 길이 1회 생성
- 상세 가격·모델: `.claude/skills/video-production-pipeline/references/cost-and-models.md`

## 이 환경 제약
- `cdn.abocado.ai` 다운로드가 막혀 영상 파일 검사·병합 불가. 소리 검수 불가
- 이 저장소는 **공개**다. 제품 프리셋·구매품·키는 올리지 않는다
- 보관 기록: `docs/history/`
