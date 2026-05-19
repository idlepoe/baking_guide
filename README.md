recipe detail의 ProgressBottomBar의 위치에는 '실기 시작' 버튼이 우선 표시되고,

해당 버튼을 누르면

ProgressSession

{
  "sessionId": "uuid",

  "recipeId": "chestnut_bread",

  "status": "in_progress",

  "startedAt": "2026-05-19T10:00:00Z",

  "updatedAt": "2026-05-19T10:30:00Z",

  "completedAt": null,

  "currentStepNo": 3,

  "completedSteps": [1, 2]
}

를 저장하는 것으로 하고 prefshared에 저장하는 것으로 해줘.

"status": "in_progress"

값:

ready
in_progress
completed
abandoned

저장 된 후엔 ProgressBottomBar 를 표시하는 것으로 해줘.

ProgressBottomBar의 next가 눌러질때마다 currentStepNo를 갱신해줘.

ProgressBottomBar의 마지막 '다음 단계' 버튼은 status 를 completed 로 변경하고 저장하고 화면을 나가는 것으로 해줘.

그리고 해당 저장 정보는 progressList에 표시하는 것으로 하고 recipe의 thumbnailUrl, name, 시작시간, 예상완료시간, 현재 단계를 표시해줘.