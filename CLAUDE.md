# CLAUDE.md

@HANDOFF.md

## 절대 규칙 (최우선)
- 사용자의 스킬·지침서·기록·제품 자료는 **어떤 경우에도 공개 저장소에 올리지 않는다.** 저장 전에 저장소가 비공개인지 확인하고(`gh api repos/<소유자>/<이름> --jq .private`), 공개이거나 확인할 수 없으면 저장하지 않고 사용자에게 알린다.

- 영상·이미지 제작(기획→최종 확인)은 스킬 `video-production-pipeline`, 이어받기·기록은 `handoff-memory`를 따른다. 스킬 색인: `docs/production-skill-guide.md`, `docs/repo-inventory.md`
- 스킬 본문이 `.claude/skills/`에 없으면 없다고 말하고, 아는 것처럼 진행하지 않는다.

## 공통 규칙 (제작 시 항상)
- 이미지는 **컷별 그리드 스토리보드 한 장**. 낱장 프레임 여러 번 생성 금지(명시 요청 시만 예외).
- 영상 기본 모델은 Seedance 1.5(`se-bytedance-seedance-v1.5-pro-*`), 480p로 먼저 테스트.
- 생성 전 `abocado_check_cost`에 **`generate_audio`·화면비 등 options를 전부 넣는다**(옵션 없는 견적은 오디오 포함 실차감의 절반으로 나온다).
- 크레딧 차감은 사용자에게 승인받는다. 결과를 직접 못 봤으면 "시각 검수 미확인"이라고 적는다.
- 작업 기록은 HANDOFF.md를 갱신하고 지정 브랜치에 커밋·푸시한다. 이 저장소는 공개이므로 구매품·키·제품 프리셋을 올리지 않는다.
