---
name: skill-library
description: 스킬을 저장·추가·정리하거나 목록을 확인하고 백업할 때 사용한다. "스킬 목록", "스킬 추가", "스킬 저장", "hix ai 스킬", "힉스필드 지침서 저장", "백업해줘", "활성화/보관" 같은 요청.
---

# 스킬 저장소 관리

구조와 이유는 `library/README.md`. 목록은 `docs/skill-index.md`(자동 생성)만 읽는다. 스킬 본문은 사용자가 요청할 때만 연다.

## 새 스킬·지침서를 받았을 때
1. 폴더로 정리: `<이름>/SKILL.md`(frontmatter `name`, `description`≤300자) + 긴 내용은 `references/`로 분리.
2. **저장 전 제외 확인**: 구매품(플레이리스트 계열), 타인 브랜드·실존 얼굴·UUID 같은 제3자 자료, 비밀키. 걸리면 저장하지 않고 이유를 알린다.
3. 등록: `python3 scripts/skills.py add <폴더> --provider hix-ai|higgsfield|third-party|own --category <종류> --source "<출처>" --public-ok true|false|unverified`
   - 기본은 보관(토큰 0). 자주 쓰는 것만 `--active` 또는 `activate`.
4. `python3 scripts/skills.py check` 로 점검(비밀키, description 길이, 메타 누락).
5. 커밋·푸시. **`public-ok`가 true가 아닌 스킬은 공개 저장소(`-AI-`)에 커밋하지 않는다.** 비공개 백업 저장소가 이 세션에 연결돼 있지 않으면 저장하지 말고 사용자에게 알린다.

## 목록·상태 확인
`docs/skill-index.md`를 읽어 사용중/보관, 종류, 출처, 공개 가능 여부를 요약한다. 갱신은 `python3 scripts/skills.py index`.

## 토큰 원칙
사용중 스킬이 늘수록 매 세션 비용이 는다. 쓰지 않는 스킬은 `archive`하고, description은 짧게 유지한다.
