# 레시피 데이터 정비 진행 상황

작업 목적: `assets/raw_images/`의 교재 원본 사진을 기준으로 `assets/json/recipes/*.json`의
공정 텍스트를 바로잡고, 단계별 사진(`assets/images/recipes/<id>/<stepNo>.png`)을 원본에서
크롭해 채워 넣는 작업. **원칙: 교재가 항상 옳음.** 기존 JSON과 다르면 교재 쪽으로 고친다.

마지막 갱신: 보류 2건(비상식빵·스위트롤) 사진 확보 및 크롭 완료 직후 (Opus 5 세션).
**레시피 40개 전량 텍스트+사진 작업 완료. 보류 항목 없음.**

## 전체 현황

- 레시피 총 40개 (제빵 20 / 제과 20 — `assets/json/recipe_list.json`의 `examType` 기준)
- **완료 40/40** — 텍스트·사진 모두 정상, 검증 통과
- 검증: `dart run tool/verify_assets.dart` 로 이미지 참조 누락 집계
- 방금 확인된 수치: 이미지 참조 583건 중 **누락 0건 / 미완성 레시피 0개**

### ⚠️ 주의 — examType 기준으로 세어야 함
레시피 상세 JSON의 `category` 필드(`bread/pastry/hard/cake/cookie/specialty`)는 제빵/제과
구분과 무관하다 (예: 슈·타르트는 `pastry`이지만 제과 품목). 진행률은 반드시
`recipe_list.json`의 `examType`(`baking`/`confectionery`)으로 집계할 것.

## 제빵 (baking) — 20/20 완료 ✅

| 상태 | id | 이름 | 비고 |
|---|---|---|---|
| ✅ | bagel | 베이글 | 9→18단계, 재촬영본으로 4단계(01·05·09·13) 사진 보강 완료(08-31) |
| ✅ | grissini | 그리시니 | 8→8단계 (파일럿) |
| ✅ | butter_roll | 버터롤 | 10→14단계 |
| ✅ | red_bean_bread | 단팥빵 | 10→13단계 |
| ✅ | cream_bread | 크림빵 | 10→15단계 |
| ✅ | soboro_bread | 소보로빵 | 10→15단계 |
| ✅ | mocha_bread | 모카빵 | 10→15단계 |
| ✅ | whole_wheat_bread | 통밀빵 | 10→14단계 |
| ✅ | sausage_bread | 소시지빵 | 9→15단계 |
| ✅ | bread_donut | 빵도넛 | 9→14단계, 재촬영본으로 09단계 사진 보강 완료(08-31) |
| ✅ | pastry_twist | 단과자 트위스트 | 11→13단계 |
| ✅ | rice_bread | 쌀식빵 | 13→14단계 |
| ✅ | chestnut_bread | 밤식빵 | 14→19단계, 배합량 오류 수정(밤 400→420g) |
| ✅ | butter_top | 버터톱 식빵 | 15→15단계(내용 대폭 수정) |
| ✅ | rye_bread | 호밀빵 | 11→10단계, 굽기 2단계 온도로 수정, 재촬영본으로 05단계 사진 보강 완료(08-31) |
| ✅ | corn_bread | 옥수수식빵 | 12→11단계 |
| ✅ | pullman_bread | 풀만식빵 | 15→15단계(내용 대폭 수정) |
| ✅ | milk_bread | 우유식빵 | 이전 세션에서 이미 완료 상태였음(정본 기준) |
| ✅ | emergency_white_bread | 식빵(비상스트레이트법) | 08-31에 사용자가 원본 교재 페이지를 재촬영 제공, 배합표·요구사항·14단계 전량 확보. 기존 JSON 텍스트가 이미 원본과 거의 일치(2차 발효 "30~40분"→"30분 전후"만 수정) — 사진 14장 정상 크롭. |
| ✅ | sweet_roll | 스위트롤 | 08-31에 사용자가 `assets/raw_images/스위트롤/` 원본을 신규 촬영 제공, 배합표·요구사항·14단계 전량 확보. 기존 JSON 텍스트가 이미 원본과 완전히 일치 — 사진 14장 정상 크롭. |

## 제과 (confectionery) — 20/20 완료 ✅

| 상태 | id | 이름 | 비고 |
|---|---|---|---|
| ✅ | butter_cookie | 버터쿠키 | 10→10단계 |
| ✅ | shortbread_cookie | 쇼트브레드 쿠키 | 14→14단계 |
| ✅ | madeleine | 마드레느 | 14→14단계, 텍스트가 이미 원본과 정확히 일치(드문 사례) — tips/checklist/감점포인트만 보강, 사진 14장 정상 크롭 |
| ✅ | madera_cake | 마데라케이크 | 15→15단계, 텍스트가 이미 원본과 정확히 일치 — tips/checklist/감점포인트만 보강, 사진 15장 정상 크롭 |
| ✅ | dacquoise | 다쿠와즈 | 13→13단계, 텍스트가 이미 원본과 정확히 일치 — tips/checklist/감점포인트만 보강, 사진 13장 정상 크롭 |
| ✅ | fruit_cake | 과일케이크 | 15→15단계, 텍스트가 이미 원본과 정확히 일치 — tips/checklist/감점포인트만 보강, 사진 15장 정상 크롭 |
| ✅ | butter_sponge_cake_gongrip | 버터스펀지케이크(공립법) | 11→11단계, 텍스트가 이미 원본과 정확히 일치 — tips/checklist만 보강, 사진 11장 정상 크롭 |
| ✅ | butter_sponge_cake_separated | 버터스펀지케이크(별립법) | 12→12단계, 텍스트가 이미 원본과 정확히 일치 — tips/checklist만 보강, 사진 12장 정상 크롭 |
| ✅ | brownie | 브라우니 | 10→10단계, 텍스트가 이미 원본과 정확히 일치 — tips/checklist만 보강, 사진 10장 정상 크롭 |
| ✅ | soft_roll_cake | 소프트롤케이크 | 15→15단계, 텍스트가 이미 원본과 정확히 일치(누락 tips 2건만 보강) — 재촬영본으로 2단계(09·13) 사진 보강 완료(08-31) |
| ✅ | choux | 슈 | 14→14단계, 텍스트가 이미 원본과 정확히 일치 — tips/checklist만 보강, 재촬영본으로 13단계 사진 보강 완료(08-31) |
| ✅ | chiffon_cake | 시퐁케이크 | 13→13단계, 텍스트가 이미 원본과 정확히 일치 — tips/checklist만 보강, 사진 13장 정상 크롭 |
| ✅ | jelly_roll_cake | 젤리롤케이크 | 14→14단계, tips 4건 누락분 보강(중탕온도 주의, 캐러멜 무늬 방향, 면포 준비, 말기 힘조절), 사진 14장 정상 크롭 |
| ✅ | choco_roll_cake | 초코롤케이크 | 13→13단계, tips 5건 누락분 보강(중탕온도, 오버베이킹, 생크림온도, 가나슈 농도조절, 면포준비) + 감점포인트(반대방향 말기), 사진 13장 정상 크롭 |
| ✅ | choco_muffin | 초코머핀 | 11→11단계, 텍스트가 이미 원본과 정확히 일치 — tips/checklist만 보강, 사진 11장 정상 크롭 |
| ✅ | cheesecake | 치즈케이크 | 14→14단계, 텍스트가 이미 원본과 정확히 일치 — tips/checklist만 보강, 사진 14장 정상 크롭 |
| ✅ | tart | 타르트 | 15→15단계, 냉장휴지 시간(20~30분) 명시 보강, 사진 15장 정상 크롭 |
| ✅ | pound_cake | 파운드 케이크 | 11→11단계, 텍스트가 이미 원본과 정확히 일치(2단계 굽기 구조 정확) — tips/checklist만 보강, 사진 11장 정상 크롭 |
| ✅ | walnut_pie | 호두파이 | 15→15단계, 냉장휴지 타이머(30분) 보강, 사진 15장 정상 크롭 |
| ✅ | black_rice_roll_cake | 흑미롤케이크 | 14→14단계, tips 8건 누락분 보강(중탕온도 2건, 가루섞기, 냉각시 수축주의, 생크림 얼음중탕, 면포준비, 이음새크림, 말기요령), 사진 14장 정상 크롭 |

**관찰**: 제과 20개 중 15개는 텍스트가 이미 교재와 정확히 일치했고(제빵과 뚜렷이 다른 패턴),
나머지 5개(젤리롤케이크·초코롤케이크·흑미롤케이크·타르트·호두파이)도 큰 구조는 맞고 `tips`
문구 일부·타이머 누락 정도의 경미한 보강만 필요했다. 제빵에서 흔했던 "공정 단계 통째 누락"
같은 심각한 오류는 제과에서 전혀 없었다.

## 표준 작업 절차 (품목 1개당)/

1. **원본 페이지 추출**: `dart run tool/export_pages.dart <한글폴더명>` → `build/pages/<한글폴더명>/`에
   EXIF 방향 보정된 PNG 저장. Read 툴로 각 페이지를 읽어 배합표/요구사항/공정/결과물평가 확인.
2. **현재 JSON 확인**: `node -e "..."` 로 `assets/json/recipes/<id>.json`의 현재
   `steps`, `summary`, `ingredients` 덤프해서 원본과 대조.
3. **차이점 파악** 후 `tool/tmp/patch_<id>.js` 스크립트 작성 (steplib.js 헬퍼 사용) →
   `node tool/tmp/patch_<id>.js` 실행해 JSON 덮어쓰기.
4. **크롭 스펙 작성**: `tool/crop_spec.json`의 `recipes.<id>`에 페이지별 셀 좌표(0~1 정규화) 추가.
   `book2x4` 그리드 프리셋(2열×4행) 사용 가능하나 실제로는 대부분 `cells` 직접 지정 방식을 씀
   (페이지 잘림·불균등 배치가 많아서). `dart run tool/crop.dart --preview <id>` 로 빨간 테두리
   오버레이 확인 후 좌표 조정 → 확정되면 `dart run tool/crop.dart <id>` 로 실제 크롭.
5. **원본 사진이 페이지 상단 잘림으로 일부 단계 사용 불가한 경우**: 해당 스텝의 `imageUrl`을
   빈 문자열로 설정(플레이스홀더 표시됨). `verify_assets.dart`가 `OK(-N)`으로 구분 표시.
6. **검증**: `dart run tool/verify_assets.dart` (이미지 누락) + `dart run tool/verify_enums.dart`
   (열거형 값 오타, 예: `resting` vs `rest`).

## 도구 (tool/ 디렉터리, 새로 작성됨 — 커밋 안 된 상태일 수 있음)

- `tool/crop.dart` — 원본 사진 크롭. `--preview`로 격자 확인, `--all`로 전체 실행 가능.
- `tool/crop_spec.json` — 레시피별 크롭 좌표 정의. **매 품목 작업 후 계속 누적됨.**
- `tool/export_pages.dart` — 원본을 EXIF 방향대로 편 뒤 리사이즈해서 `build/pages/`에 저장 (읽기 검증용).
- `tool/normalize_image_refs.dart` — JSON의 이미지 경로를 `<id>/<stepNo>.png`, `<id>/main.png`
  규칙으로 일괄 정규화. (이미 1회 실행 완료 — 40개 파일 516건 변경됨)
- `tool/verify_assets.dart` — 이미지 참조 누락 검사. `-v`로 상세 출력.
- `tool/verify_enums.dart` — JSON의 열거형 문자열이 Dart enum의 `@JsonValue`와 일치하는지 검사.
- `tool/tmp/steplib.js` — Node 스크립트에서 쓰는 헬퍼(`load`, `maker`, `save`, `kp`, `weigh`, `weighExtra`).
- `tool/tmp/patch_<id>.js` — 품목별 1회성 패치 스크립트(임시 파일, 이미 실행됨 — 재실행 불필요하나
  코드 리뷰용으로 남아있음).
- `pubspec.yaml`에 `image: ^4.5.4` 를 dev_dependencies로 추가함 (크롭 작업용).

## 자주 나타난 오류 패턴 (남은 18개 작업 시 예상)

1. **성형/토핑 공정이 통째로 누락** — 가장 흔한 패턴. 예: 크림빵의 충전/반달형 분리 제조,
   소보로빵의 토핑 3단계, 모카빵의 비스킷 토핑 4단계.
2. **배합량 오타** — 밤식빵 밤다이스 400→420g처럼 교재와 다른 숫자.
3. **오븐 온도/시간 오류** — 호밀빵이 2단계 굽기인데 단일 온도로 잘못 기재된 사례.
4. **교재 내부 자체 모순** — 그리시니 굽기시간(주요공정 15~20분 vs 공정08 20분전후),
   크림빵 중량(요구사항 46g vs 공정캡션 45g). **이런 경우 더 구체적인 공정 단계 캡션 쪽을 채택.**
5. **원본 촬영 시 페이지 상단 잘림** — 05-25 촬영분에서 자주 발생, 해당 단계 이미지는 빈 값 처리.
6. **JSON이 원본보다 단계가 많은 역방향 오류**도 2건 있었음(옥수수식빵, 호밀빵) — 근거 없이
   추가된 단계였음.

## ✅ 사진 보강 완료 (08-31)

이전 세션에서 페이지 상단 잘림으로 비어 있던 5개 품목 9단계를, 사용자가 해당 페이지를
재촬영한 원본(`assets/raw_images/<폴더>/20260831_*.jpg`)으로 전량 보강 완료.

| id | 이름 | 보강 단계 |
|---|---|---|
| bagel | 베이글 | 01, 05, 09, 13 |
| bread_donut | 빵도넛 | 09 |
| rye_bread | 호밀빵 | 05 |
| soft_roll_cake | 소프트롤케이크 | 09, 13 |
| choux | 슈 | 13 |

재촬영본은 품목당 페이지 전체(재료~완성)를 새로 찍은 것이라, 기존에 정상이던 단계의
원본 파일도 함께 교체되었다(구 파일은 git에서 삭제됨). 이에 따라 `tool/crop_spec.json`의
해당 5개 품목 `pages`를 새 파일명 기준으로 전면 재작성하고(`book2x4` 그리드 + `map`/`cells`),
`dart run tool/crop.dart <id>`로 전체 단계를 재크롭했다 — 기존에 이미 정상이던 단계 이미지도
함께 다시 생성되었으나 내용은 동일 페이지의 동일 사진이라 문제 없음(육안 확인 완료).
JSON의 빈 `imageUrl` 9건은 `assets/images/recipes/<id>/<stepNo>.png` 규칙으로 채워 넣었다.

`dart run tool/verify_assets.dart` 재확인 결과: 40개 레시피 전량 `OK`(누락 0) —
**사진 누락 문제는 완전히 해소됨.**

## ✅ 보류 2건 해제 완료 (08-31)

`emergency_white_bread`(식빵-비상스트레이트법), `sweet_roll`(스위트롤) 모두 사용자가
`assets/raw_images/`에 원본 교재 페이지를 신규 촬영해 제공하면서 보류 해제.

- **emergency_white_bread**: 이전엔 `raw_images/비상식빵` 폴더가 정사각형으로 이미 크롭된
  PNG 16장 + AI 생성 이미지 1장뿐이라 배합표·요구사항·공정 사진 근거가 전혀 없었음.
  새 원본(`20260831_2039*.jpg` 4장)에 표지·배합표/요구사항·공정 1~8·공정 9~14 페이지가
  모두 담겨 있어 정식 절차로 처리. 기존 JSON은（이전 세션에 어떤 근거로 작성됐는지 불명확하나）
  이미 원본과 텍스트가 매우 근접했고, 2차 발효 표기("30~40분 전후" → "30분 전후",
  타이머 2400s→1800s, `summary.fermentation.second.timeSec` 2100→1800)만 교재 기준으로
  수정. 사진 14장 신규 크롭.
- **sweet_roll**: 이전엔 `assets/raw_images/`에 대응 폴더 자체가 없었음. 새 원본
  (`assets/raw_images/스위트롤/20260831_2039*.jpg` 4장)에 표지·배합표/요구사항·공정
  1~8·공정 9~14 페이지가 모두 담겨 있음. 기존 JSON 텍스트는 배합표·요구사항·14단계
  전부 원본과 완전히 일치해 수정 없이 사진 14장만 신규 크롭.

`tool/crop_spec.json`에 두 품목 `pages`를 신규 추가(`book2x4` 그리드 + `map`, 일부
칸은 `cells`로 직접 지정)하고 `--preview`로 격자 확인 후 `dart run tool/crop.dart`로
전체 단계 크롭. `dart run tool/verify_assets.dart` / `verify_enums.dart` 모두 통과.

## 다음 세션에서 할 일

**레시피 40개 전량(제빵 20 + 제과 20) 텍스트+사진 작업 완료. 보류 항목 없음.**
남은 일은 사용자 요청 시의 마무리 정리뿐이다.

- `tool/tmp/*.js` 임시 패치 스크립트 정리(삭제 또는 보관 결정) — 현재 30여 개 누적됨.
- `pubspec.yaml`의 asset 폴더 목록(40개 하드코딩됨)이 실제 폴더 구성과 일치하는지 재확인.
- `build/pages/`, `build/crop_preview/` 임시 산출물 정리 여부 확인.
- `tool/crop.dart`, `tool/crop_spec.json`, `tool/verify_assets.dart`, `tool/verify_enums.dart`,
  `tool/export_pages.dart`, `tool/normalize_image_refs.dart`는 재작업(신규 레시피 추가,
  사진 재촬영 반영) 시 계속 쓰이므로 보존.
- 지금까지의 변경사항(레시피 JSON 40개 + pubspec.yaml + tool/ 신규 파일들)이 커밋되지
  않았다면 커밋 여부를 사용자에게 확인.
