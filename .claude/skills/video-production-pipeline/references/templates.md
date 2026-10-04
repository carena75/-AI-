# 양식

## 1. 기획 브리프 (0단계·1단계)
```
용도:        (예: 쇼릴 오프닝 / 제품 광고 / 유튜브 인트로)
길이·비율:   12초 · 16:9 · 480p(테스트) → 필요 시 720p
오디오:      (있음/없음, 분위기)
컨셉 한 줄:  
컷 구성:     컷1 0–4초 ... / 컷2 4–8초 ... / 컷3 8–12초 ...
톤·색:       
넣지 않을 것: (글자, 로고, 실존 인물 등 — AI 영상은 글자가 깨지기 쉬움)
예산 상한:   
```

## 2. 그리드 스토리보드 프롬프트 (이미지 1회, 1820×1024)
```
A single professional film storyboard sheet laid out as a clean {열}-column by {행}-row grid of
16:9 frames on a dark charcoal background, thin white borders, small caption label under each
panel. CUT 1 (0-4s): ... CUT 2 (4-8s): ... CUT 3 (8-12s): ... Consistent {색/톤}, cinematic,
high contrast, arrows between panels, no body text other than short labels.
```
패널 수 = 컷 수 + 전환 포인트. 패널 안 글자는 라벨만 허용(AI가 긴 글자를 깨뜨림).

## 3. 영상 프롬프트 (4단계, 전체 길이 1회)
시간 구간별로 나누고, 마지막에 소리를 한 줄로 쓴다.
```
{길이}-second cinematic {장르}, one continuous piece, {배경}. 0-4s: {장면+카메라}.
4-8s: {장면+카메라}. 8-12s: {장면+카메라}. No text, no logos.
Sound: {효과음, 앰비언트, 마지막 음}.
```
옵션: `{"aspect_ratio":"16:9","generate_audio":true|false,"camera_fixed":false}`, `duration`, `resolution` 은 견적 때와 동일하게.

## 4. 승인 카드 (각 유료 호출 직전, 한 번에)
```
이번 호출: {모델} · {길이/장수} · {해상도} · 오디오 {on/off}
견적: N크레딧 (잔액 M → M−N) · 예상 소요 {시간}
진행할까요? ① 그대로 ② 바꿀 항목만 말하기
```

## 5. 인수인계 기록 (5단계, HANDOFF.md에 추가)
```
## {날짜} {프로젝트명}
- 설정: 모델/길이/해상도/오디오
- 결과: 영상 URL, 스토리보드 URL
- 차감: 합계 N (견적과 달랐던 항목: ...)
- 검수: 화면 {직접 확인/미확인}, 소리 {확인 불가}
- 다음 할 일:
```
