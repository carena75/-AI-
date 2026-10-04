# 힉스필드 지침서 저장 장부 (2026-10-02, 세션 기록 전수 대조)

사용자가 붙여넣은 문서마다 어디에 저장했는지(또는 왜 저장하지 않았는지)를 **저장 위치별로 묶어** 정리한 것. 괄호 안 `#`은 원래 장부 번호.

- 집계: 전체 108 = 스킬 15 · 레퍼런스 50 · 병합 16 · 중복 20 · 제외 3 · 비스킬 4
- 원본 텍스트는 파일로 따로 저장하지 않았고 사용자 세션 기록에만 남아 있음. 붙여넣기 태그 없이 입력했거나 다른 세션에서 받은 문서는 빠졌을 수 있음
- **아래 경로의 실제 파일은 사용자 PC(`~/.claude/skills`)에 있으며 이 저장소에는 없음.** 이 문서는 위치 색인임. 스킬 사용 규칙은 `production-skill-guide.md` 참고

## 독립 스킬 (SKILL.md)

| 스킬 | 출처 # | 비고 |
|---|---|---|
| 마케팅 카피 전략 사업 | 31 | persuasion-principles, platform-format-rules 포함. 레바논/시리아 브랜드 요소 제외 |
| 영상 대본 작가 | 37 (+130 확장) | 130에서 8형식으로 확장 |
| 스토리보드 치트코드 | 50 | |
| 얼굴없는 유튜브 채널 자동화 | 60 (+90 보강) | 니치는 예시로 일반화 |
| 굿즈 디자인 사업 | 68 | 티셔츠 디자인 생성기 기반 |
| 콘텐츠 커맨드센터 | 71 (+79 일부) | '브랜드 자산 팩 재사용' 개념 1개 반영 |
| 웨딩 초대장 영상 사업 | 127 | ArrowMedia 브랜드 제외 |
| 펠트 퍼펫 광고 스토리 | 133 | |
| 소설 공동집필 | 136 | |
| 브랜드 풀세트 제작 사업 | 138 | |
| 브랜드 DNA 바이럴 엔진 | 139 | |
| AI 인플루언서 콘텐츠 전략 | 143 | |
| 에피소드 스튜디오 | 144 | 서브 레퍼런스 파일은 원문에 없어 골격만 |
| AI 커머셜 프로덕션 | 146 | |
| 게임 스프라이트시트 생성 | 148 | |
| 바이럴 UGC 재현 광고 | 123(병합) | '모드 2 대량 변형 생산' 추가 |
| 홈페이지 사업 (본문) | 85(병합) | 짧게 추가, 플랫폼 종속 대부분 제외 |

## 레퍼런스 파일 (스킬별)

### 이미지영상 프롬프트 마스터 / references/
- storyboard-generation.md (32)
- gpt-image-2-director-playbook.md (33)
- video-to-video-vfx.md (35, 112 보강)
- script-to-scene-prompts.md (39)
- camera-angle-coverage.md (53)
- design-taste-and-critique.md (54, 84 병합)
- model-selection-guide.md (56, 75 병합: Recraft·오류복구표·배치 원칙)
- high-fashion-editorial-photography.md (57)
- multi-character-action-scenes.md (62, 93, 94)
- broll-shot-planner.md (63)
- soul-character-consistency-system.md (65, 125 일부)
- typographic-style-explorer.md (66)
- product-photography-brief.md (69)
- video-stitching-and-pipeline-integrity.md (70)
- premium-ad-poster-hardware-realism.md (73)
- brand-ad-production-discipline.md (74)
- photoreal-character-prompt-discipline.md (76)
- thumbnail-production-techniques.md (78)
- meme-shorts-6step-framework.md (80)
- music-video-director.md (81)
- video-bridging-and-stitching-techniques.md (92, 93, 94)
- image-edit-lane-discipline-and-formulas.md (95)
- architectural-visualization-director.md (98, 145 확장)
- seedance-omni-multi-reference-prompting.md (100)
- luxury-beauty-ad-film-director.md (101)
- short-form-ad-hooks-and-shotlists.md (107)
- video-shot-design.md (114, 131)
- carousel-slide-design-system.md (128)
- talking-head-monologue-production.md (129)
- veo-native-audio-prompting.md (134)
- cinematic-web-background-pipeline.md (137)
- garment-transfer-model-photoshoot.md (140)
- news-explainer-carousel-structure.md (141)
- authentic-phone-camera-slot-template.md (147)

### 마케팅 카피 전략 사업 / references/
- paid-ad-creative-specs.md (36, 96 보강 + 부정표현 규칙 양쪽 허용)
- content-strategy-planning.md (38)
- content-polish-and-social-formats.md (40, 신규 2가지만)
- content-editing-and-virality-audit.md (55, 가짜 정밀도 점수 제외)
- youtube-title-thumbnail-packaging.md (64, 채널명 일반화)
- service-rotation-cartoon-content.md (77)
- marketing-mental-models.md (106)
- hook-scoring-rubric.md (120)
- social-media-operating-philosophy.md (126)
- ab-test-design-and-ice-prioritization.md (135)

### 홈페이지 사업 / references/
- creative-concept-brief.md (58)
- visual-asset-audit.md (72)
- glass-morphism-and-motion-brief.md (91, 기존 규칙과 충돌하는 패럴랙스 등 제외)
- conversion-strategy-brief.md (121)
- page-information-architecture-spec.md (124, 특정 개인 브랜드 IP 제외, 6항목 형식만)

### 기타
- pitch-deck-master / references/theme-factory.md (59)
- 영상 대본 작가 / references/long-form-and-output-format-templates.md (130)
- AI 업무자동화 진단 사업 / references/source-tier-and-fact-check-discipline.md (108)
- 이미지 썸네일 사업 / references/quality-boundaries.md (125)
- 프로젝트 루트 `수노_뿌리프롬프트_생성기.md` §13·§14 (30, 스킬 아님)

## 저장하지 않은 것

- **제외 (타인 IP·얼굴·브랜드)**: #52 플래시 릴(다른 계정 실제 인물 얼굴 참조 하드코딩), #132 Zeynep(Güray Group 브랜드 전용), #142 Karwan Reel Studio(실제 스포츠클럽 브랜드 전용). #93/#118의 UUID 로스터도 타인 프로젝트 데이터라 제외
- **비스킬**: #22 플러그인 설치 현황, #28 ECC·Ponytail·Claude-Mem 설치+Obsidian 연결, #87 제미나이 영상 평가(프레임 검증, 2건 사실·1건 미확인), #150 커뮤니티 스킬 목록
- **중복 (이미 저장돼 변경 없음)**: 41, 51, 82, 83, 97, 99, 102–105, 109–111, 113, 115, 117, 118, 119, 122. 이 중 #116 Jarvis는 이 환경에 없는 서브스킬 라우팅이라 미저장(자막 굽기는 hyperframes embedded-captions로 대체), #99·#119는 기존 파일이 더 정교해 가져올 것 없음

## 붙여넣기 외 경로로 들어온 것
- 모션그래픽 88종: 외부 사이트 추출 → 스킬 모션그래픽, 모션그래픽 사업
- HyperFrames 공식 스킬 10종: `npx hyperframes skills update`로 설치
- `npx skills add`로 설치: video-thumbnail, logo-design, landing-page-design, slide-design-skill, 모션그래픽 계열 13종
- 힉스필드 MCP 공식 지침서 직접 조회: product-photoshoot, ugc-try-on-video 저장 (공식 나머지 15개는 조회만 가능, 미저장)
