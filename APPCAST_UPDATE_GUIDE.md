# Appcast 업데이트 가이드

`upgrader` + `appcast.xml` 기반으로 Android APK 업데이트를 운영할 때 사용하는 절차입니다.

대상 파일:

- `web/appcast.xml`
- `web/download/latest.apk`

---

## 언제 업데이트해야 하나?

새 Android APK를 배포할 때마다 아래 2개를 **항상 함께** 업데이트합니다.

1. `web/download/latest.apk` 교체
2. `web/appcast.xml` 버전/날짜 갱신

둘 중 하나만 바꾸면 앱에서 업데이트 감지가 제대로 되지 않을 수 있습니다.

---

## 버전 규칙

`appcast.xml`에서 핵심은 다음 2개입니다.

- `sparkle:shortVersionString`: 사용자 표시 버전 (예: `1.0.2`)
- `sparkle:version`: 내부 빌드 번호 (예: `3`)

권장 규칙:

- `shortVersionString`은 `pubspec.yaml`의 `version` 앞부분과 동일하게 유지
- `sparkle:version`은 반드시 이전보다 증가

예:

- 기존: `1.0.0+1`
- 다음: `1.0.1+2`
  - `sparkle:shortVersionString="1.0.1"`
  - `sparkle:version="2"`

---

## 업데이트 절차 (수동)

### 1) 새 APK 빌드

```bash
flutter build apk --release
```

생성 파일:

- `build/app/outputs/flutter-apk/app-release.apk`

### 2) APK 교체

`app-release.apk`를 `web/download/latest.apk`로 복사/덮어쓰기 합니다.

### 3) appcast 수정

`web/appcast.xml`에서 아래 항목을 업데이트합니다.

- `<title>`: 권장 버전명으로 변경 (예: `1.0.1`)
- `<description>`: 변경 요약
- `<pubDate>`: 현재 시각으로 갱신
- `<enclosure ... sparkle:shortVersionString="..." sparkle:version="..." ... />`

예시:

```xml
<item>
  <title>1.0.1</title>
  <description>타이머 안정성 개선 및 이미지 줌 기능 추가</description>
  <pubDate>Tue, 02 Jun 2026 17:10:00 +0900</pubDate>
  <enclosure
    url="https://bbangsilgi.web.app/download/latest.apk"
    sparkle:version="2"
    sparkle:shortVersionString="1.0.1"
    length="0"
    type="application/vnd.android.package-archive" />
</item>
```

> 참고: `length`는 필수 검증값으로 쓰지 않는 경우 `0` 유지해도 됩니다.

### 4) Hosting 배포

```bash
firebase deploy --only hosting
```

### 5) 확인

- 브라우저에서 `https://bbangsilgi.web.app/appcast.xml` 열기
- 브라우저에서 `https://bbangsilgi.web.app/download/latest.apk` 다운로드 확인
- 설치된 구버전 앱 실행 시 `upgrader` 팝업 표시 여부 확인

---

## 체크리스트

- [ ] `latest.apk`가 실제 최신 파일로 교체됨
- [ ] `sparkle:version`이 이전보다 큼
- [ ] `sparkle:shortVersionString`이 릴리스 버전과 일치
- [ ] `pubDate` 갱신됨
- [ ] 배포 후 `appcast.xml` URL에서 새 내용 확인됨

---

## 자주 발생하는 문제

### 업데이트 팝업이 안 뜸

- 원인:
  - `sparkle:version`이 증가하지 않음
  - 앱 설치 버전과 appcast 버전이 동일
  - Hosting에 이전 파일이 남아있음(캐시/배포 누락)
- 조치:
  - 빌드 번호 증가 후 재배포
  - `appcast.xml` 실제 응답값 재확인

### APK 다운로드는 되는데 설치 안내가 안 뜸

- 원인:
  - Android 보안 정책(알 수 없는 앱 설치 차단)
- 조치:
  - 사용자에게 해당 권한 허용 안내

### iOS에서 동작 차이

- iOS는 appcast가 아니라 App Store 조회 경로를 사용합니다.
- Android appcast 운영과 별개로 App Store 등록 상태를 유지해야 합니다.

---

## 권장 운영 방식

- 릴리스 노트 작성 시 `appcast.xml`의 `<description>`과 동일하게 관리
- 배포 담당자가 바뀌어도 같은 방식으로 처리할 수 있도록
  이 문서를 릴리스 체크리스트에 포함

