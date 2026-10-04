# 깃허브 저장소 현황 (종류별 목록, 2026-10-04 확인)

저장소 `carena75/-AI-` 의 모든 브랜치를 직접 열어 확인한 결과. 스킬 본문 대부분(~583 md)은 사용자 PC `~/.claude/skills`에 있고 아직 올라오지 않았다 (`scripts/export-skills-to-repo.sh` 참고).

## 스킬 (SKILL.md) — 자동 로딩 대상
| 스킬 | 위치 | 설명 |
|---|---|---|
| video-production-pipeline | `.claude/skills/video-production-pipeline/` (SKILL.md + references/cost-and-models.md, templates.md) | 기획→그리드 스토리보드 1장→480p 무음 테스트→승인 후 최종(오디오는 마지막)까지 크레딧·토큰을 아끼는 5단계 파이프라인. 트리거: "영상 만들어줘", "기획부터 영상까지", "스토리보드", "시댄스 영상". 본문 28줄, 세부는 references에서 필요 시 로딩 |
| commercial-motion-prompt | `.claude/skills/commercial-motion-prompt/SKILL.md` (원본 브랜치 `claude/ai-motion-graphic-prompt-guide-cd1bld`, 2026-09-27) | AI 영상 모델(Sora, Veo, Runway, Kling 등)용 상업 모션그래픽·광고 영상 프롬프트 작성. 트리거: "광고 영상 프롬프트", "모션그래픽 프롬프트", "커머셜 영상 프롬프트". 본문 약 22KB, 길이·Creative Mode 결정 후 완성 프롬프트 1개 생성 |

## 데이터·참고 파일 (스킬 아님) — 브랜치에 그대로 남겨둠
| 파일 | 브랜치 | 종류 |
|---|---|---|
| `level_poster_analysis.json` | `claude/image-detail-analysis-lppc20` | 포스터 디테일 분석 JSON + GPT Image 2 프롬프트 |
| `style_profiles/fantasy_jewel_samurai.json` | 위와 동일 | 화풍 프로필 (홀로그램 보석 갑옷 사무라이 여전사) |
| `style_profiles/neon_cyberpunk_club_poster.json` | 위와 동일 | 화풍 프로필 (사이버펑크 네온 클럽 포스터) |
| `style_profiles/README.md` | 위와 동일 | 화풍 저장 폴더 사용법 (6분할 시트 → 선택 → 단일 컷 재생성) |
| `character-sheet-studio.html` | `claude/character-sheet-analysis-6itbk5` | 캐릭터 시트 웹앱 (스킬 아님) |

## 이 작업 브랜치(`ccr-8fda732d-6wnvpg`)의 문서
| 파일 | 내용 |
|---|---|
| `CLAUDE.md` | 제작 공통 규칙 (그리드 스토리보드, 견적에 options 포함 등) |
| `HANDOFF.md` | 세션 간 인수인계 기록 |
| `docs/production-skill-guide.md` | 스킬 사용 규칙·트리거 색인 (본문 없음) |
| `docs/skill-ledger.md` | 지침서 108건의 저장 위치·제외 내역 장부 |
| `docs/repo-inventory.md` | 이 문서 |
| `scripts/export-skills-to-repo.sh` | PC 스킬 → 저장소 복사·푸시 스크립트 |

## 아직 저장소에 없는 것
장부에 있는 독립 스킬 17개(마케팅 카피 전략 사업, 영상 대본 작가, 스토리보드 치트코드, 이미지영상 프롬프트 마스터 + 레퍼런스 38개 등)와 레퍼런스 파일 전부, 훅 `route-production.js`.
