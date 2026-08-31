# 레시피 데이터 정비 진행 상황

작업 목적: `assets/raw_images/`의 교재 원본 사진을 기준으로 `assets/json/recipes/*.json`의
공정 텍스트를 바로잡고, 단계별 사진(`assets/images/recipes/<id>/<stepNo>.png`)을 원본에서
크롭해 채워 넣는 작업. **원칙: 교재가 항상 옳음.** 기존 JSON과 다르면 교재 쪽으로 고친다.

마지막 갱신: 버터스펀지케이크(공립법) 완료 직후 (Sonnet 5 세션).

## 전체 현황

- 레시피 총 40개 (제빵 20 / 제과 20 — `assets/json/recipe_list.json`의 `examType` 기준)
- **완료 25개** (제빵 18 + 제과 7) / **미완료 15개** (제빵 2 보류 + 제과 13)
- 검증: `dart run tool/verify_assets.dart` 로 이미지 참조 누락 집계
- 방금 확인된 수치: 이미지 참조 577건 중 누락 199건, 미완성 15개

### ⚠️ 주의 — examType 기준으로 세어야 함
레시피 상세 JSON의 `category` 필드(`bread/pastry/hard/cake/cookie/specialty`)는 제빵/제과
구분과 무관하다 (예: 슈·타르트는 `pastry`이지만 제과 품목). 진행률은 반드시
`recipe_list.json`의 `examType`(`baking`/`confectionery`)으로 집계할 것.

## 제빵 (baking) — 18/20 완료

| 상태 | id | 이름 | 비고 |
|---|---|---|---|
| ✅ | bagel | 베이글 | 9→18단계, 사진 4개 확보 불가(원본 페이지 잘림) |
| ✅ | grissini | 그리시니 | 8→8단계 (파일럿) |
| ✅ | butter_roll | 버터롤 | 10→14단계 |
| ✅ | red_bean_bread | 단팥빵 | 10→13단계 |
| ✅ | cream_bread | 크림빵 | 10→15단계 |
| ✅ | soboro_bread | 소보로빵 | 10→15단계 |
| ✅ | mocha_bread | 모카빵 | 10→15단계 |
| ✅ | whole_wheat_bread | 통밀빵 | 10→14단계 |
| ✅ | sausage_bread | 소시지빵 | 9→15단계 |
| ✅ | bread_donut | 빵도넛 | 9→14단계, 사진 1개 확보 불가 |
| ✅ | pastry_twist | 단과자 트위스트 | 11→13단계 |
| ✅ | rice_bread | 쌀식빵 | 13→14단계 |
| ✅ | chestnut_bread | 밤식빵 | 14→19단계, 배합량 오류 수정(밤 400→420g) |
| ✅ | butter_top | 버터톱 식빵 | 15→15단계(내용 대폭 수정) |
| ✅ | rye_bread | 호밀빵 | 11→10단계, 굽기 2단계 온도로 수정, 사진 1개 확보 불가 |
| ✅ | corn_bread | 옥수수식빵 | 12→11단계 |
| ✅ | pullman_bread | 풀만식빵 | 15→15단계(내용 대폭 수정) |
| ✅ | milk_bread | 우유식빵 | 이전 세션에서 이미 완료 상태였음(정본 기준) |
| ⏸️ **보류** | emergency_white_bread | 식빵(비상스트레이트법) | **사용자 지시로 보류.** raw_images/비상식빵 폴더가 다른 37개와 이질적 — 교재 촬영본이 아니라 이미 정사각형 크롭된 PNG 16장(`1.png`,`1 (2).png`...`4 (4).png`) + AI 생성 이미지 1장. 배합표·시험시간·오븐온도·결과물평가 페이지가 없어 텍스트 검증 근거가 없음. 순서도 파일명만으로는 알 수 없음(`1 (2)`처럼 중복 번호). 재작업하려면 원본 교재 페이지 확보가 먼저 필요. |
| ⏸️ **보류** | sweet_roll | 스위트롤 | **사용자 지시로 보류.** `assets/raw_images/`에 대응 폴더 자체가 없음(38개 폴더 중 스위트롤·우유식빵만 없었음). 원본 사진을 사용자가 추가로 확보해야 진행 가능. |

## 제과 (confectionery) — 6/20 완료

| 상태 | id | 이름 | 비고 |
|---|---|---|---|
| ✅ | butter_cookie | 버터쿠키 | 10→10단계 |
| ✅ | shortbread_cookie | 쇼트브레드 쿠키 | 14→14단계 |
| ✅ | madeleine | 마드레느 | 14→14단계, 텍스트가 이미 원본과 정확히 일치(드문 사례) — tips/checklist/감점포인트만 보강, 사진 14장 정상 크롭 |
| ✅ | madera_cake | 마데라케이크 | 15→15단계, 텍스트가 이미 원본과 정확히 일치 — tips/checklist/감점포인트만 보강, 사진 15장 정상 크롭 |
| ✅ | dacquoise | 다쿠와즈 | 13→13단계, 텍스트가 이미 원본과 정확히 일치 — tips/checklist/감점포인트만 보강, 사진 13장 정상 크롭 |
| ✅ | fruit_cake | 과일케이크 | 15→15단계, 텍스트가 이미 원본과 정확히 일치 — tips/checklist/감점포인트만 보강, 사진 15장 정상 크롭 |
| ⬜ | butter_sponge_cake_gongrip | 버터스펀지케이크(공립법) | **다음 착수 대상** |
| ⬜ | butter_sponge_cake_separated | 버터스펀지케이크(별립법) |
| ⬜ | brownie | 브라우니 |
| ⬜ | soft_roll_cake | 소프트롤케이크 |
| ⬜ | choux | 슈 |
| ⬜ | chiffon_cake | 시퐁케이크 |
| ⬜ | jelly_roll_cake | 젤리롤케이크 |
| ⬜ | choco_roll_cake | 초코롤케이크 |
| ⬜ | choco_muffin | 초코머핀 |
| ⬜ | cheesecake | 치즈케이크 |
| ⬜ | tart | 타르트 |
| ⬜ | pound_cake | 파운드 케이크 |
| ⬜ | walnut_pie | 호두파이 |
| ⬜ | black_rice_roll_cake | 흑미롤케이크 |

raw_images 한글 폴더명 매핑(제과, 남은 것): 마드레느, 마데라케이크, 다쿠와즈, 과일케이크,
버터스펀지케이크(공립법), 버터스펀지케이크(별립법), 브라우니, 소프트롤케이크, 슈, 시퐁케이크,
젤리롤케이크, 초코롤케이크, 초코머핀, 치즈케이크, 타르트, 파운드 케이크, 호두파이, 흑미롤케이크.
전부 `assets/raw_images/<한글이름>/`에 원본 사진 4장씩 존재 확인됨 (제과는 페이지 잘림 없이
비교적 깨끗한 편이었음, 개별 확인 필요).

## 표준 작업 절차 (품목 1개당)

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

## 다음 세션에서 할 일

1. 버터스펀지케이크(공립법)부터 이어서 진행.
2. 남은 제과 14개에 대해 `export_pages.dart` 순차 실행 → 표준 절차 반복.
3. 제과는 발효 공정이 없어 `timers` 종류가 `baking`/`rest` 위주로 단순해질 것으로 예상.
   실제로 마드레느·마데라케이크·다쿠와즈·과일케이크 4개 연속으로 텍스트가 이미 교재와
   정확히 일치했음 — 제과는 제빵보다 기존 데이터 품질이 나은 편으로 보임. 다만 크롭 격자
   좌표(cells rect)는 품목마다 사진 배치가 미세하게 달라 매번 preview로 확인·조정 필요.
   그래도 매 품목 원본 텍스트 대조는 생략하지 말 것.
4. 전체 완료 후 `pubspec.yaml`의 asset 폴더 목록(40개 하드코딩됨, 상단 참고)이 여전히
   맞는지 재확인.
5. 비상식빵·스위트롤은 사용자가 원본을 추가로 확보하기 전까지 계속 보류.
6. 작업 마무리 단계에서 `tool/tmp/*.js` 임시 패치 스크립트들을 정리(삭제 또는 보관 결정)할 것 —
   현재는 다수 누적됨.
