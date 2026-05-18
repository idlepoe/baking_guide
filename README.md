제빵가이드 - 제빵기능사 실기
개발 전달용 간략 설계

앱 개요
제빵기능사 실기를 위한 진행형 학습 앱.
핵심 기능:


단계별 실제 사진


실기 진행


체크리스트


감점 포인트


타이머 Overlay


계산기 Overlay


마스코트:


빵미



화면 구성
1. 레시피 화면
역할:


품목 목록 표시


실기 시작


진행중 이어하기


표시 요소:


품목명


대표 이미지


시험시간


난이도


진행 상태


예:


밤식빵


소보로빵


데니시페이스트리


동작:


품목 선택 → 진행 화면 이동


진행중이면 이어하기 가능



2. 진행 화면 (핵심)
역할:


단계별 실기 진행


구성:
상단


품목명


현재 단계


전체 진행률



중앙


실제 사진


단계 설명


상태 특징



하단


체크리스트


감점 포인트


이전/다음 단계 버튼



Floating Buttons
⏱ 타이머
Overlay BottomSheet
기능:


전체 시험 시간


현재 단계 타이머


발효 타이머



🧮 계산기
Overlay BottomSheet
기능:


반죽온도 계산


분할 계산


배합률 계산



3. 설정 화면
기능:


다크모드


화면 안꺼짐


알림


시험모드



데이터 구조
1. Recipe
{  "id": "chestnut_bread",  "name": "밤식빵",  "category": "bread",  "thumbnailUrl": "",  "difficulty": 3,  "totalTimeSec": 12600}

2. Step
{  "stepNo": 2,  "title": "반죽",  "estimatedTimeSec": 720,  "description": [    "유지를 제외한 재료 투입",    "저속 믹싱",    "클린업 후 유지 투입"  ],  "images": [],  "checklist": [],  "deductionPoints": [],  "timers": [],  "calculators": []}

3. StepImage
{  "type": "normal",  "title": "최종 단계",  "imageUrl": "",  "description": "얇고 투명한 글루텐막"}
type:


normal


fail


compare



4. Checklist
{  "id": "cleanup",  "text": "클린업 단계 확인"}

5. DeductionPoint
{  "severity": "high",  "text": "반죽 온도 초과 주의"}
severity:


low


medium


high



6. Timer
{  "type": "fermentation",  "label": "1차 발효",  "durationSec": 2400}

7. CalculatorType
{  "type": "dough_temp"}
종류:


dough_temp


division_weight


baker_percentage



8. ProgressSession
진행 저장용.
{  "sessionId": "",  "recipeId": "chestnut_bread",  "currentStep": 2,  "checkedItems": [    "cleanup"  ],  "startedAt": "",  "timers": []}

계산기 기능
1. 반죽온도 계산
입력:


실내온도


밀가루온도


마찰열


목표반죽온도


출력:


필요 물온도



2. 분할 계산
입력:


전체 반죽량


분할 개수


출력:


개당 무게



3. 배합률 계산
입력:


밀가루 중량


재료 중량


출력:


배합률 %



UI 방향


실제 사진 중심


실전 시험 도구 느낌


큰 버튼


최소한의 화면 전환


Overlay 적극 활용



기술 방향
Framework:


Flutter


Backend:


Firebase


권장 구조:


Recipe


ProgressSession


Step 기반 구조



핵심 UX
사용 흐름:
레시피 선택→ 실기 시작→ 단계 진행→ 타이머/계산기 Overlay 사용→ 완료

MVP 우선순위


레시피 화면


진행 화면


단계 데이터 구조


실제 사진 표시


타이머 Overlay


계산기 Overlay


진행 저장



브랜딩
앱 이름:


제빵가이드 - 제빵기능사 실기


마스코트:


빵미


스타일:


친근한 실기 도우미 캐릭터


감점 경고 / 팁 / 알림 등에 활용 가능

