# Flutter Local Search App

>> **지역 검색 & 장소별 리뷰 앱**
>> 네이버 검색 Open API + Firebase Forestore 연동
>> Flutter, Riverpod, Firebase 기반

----------------------------------------------------------------------------------------------

## 주요 기능

**장소 검색**
- 상단 검색창에서 지역명 검색 → 네이버 검색 API로 결과 조회
**장소 목록**
- 검색결과 리스트에 장소명, 카테고리, 도로명 주소 표시
**리뷰 등록/조회**
- 장소 항목 클릭 → 해당 장소의 리뷰 페이지 이동
- 리뷰 작성하면 Firestore에 저장, 실시간 목록 갱신

----------------------------------------------------------------------------------------------

## 실행 방법

1. **Firestore & 네이버 API 연동**
- Firebase 프로젝트/Firestore 활성화
- [네이버 개발자센터](https://developers.naver.com/main/)에서 Client ID/Secret 발급
- 'firebase_options.dart' 및 API 키 등록

2. **패키지 설치 & 앱 실행**
- '''bash
- flutter pub get
- flutter run

---------------------------------------------------------------------------------------------

## 폴더 구조
lib/
├─ main.dart               # 앱 진입점, 전역 초기화
├─ model/                  # 데이터 모델
│    ├─ location.dart
│    └─ review.dart
├─ repository/             # 네이버 API & Firestore 연동
│    ├─ location_repository.dart
│    └─ review_repository.dart
├─ view/                   # UI (홈, 리뷰)
│    ├─ home/
│    │    └─ home_page.dart
│    ├─ review/
│    │    └─ review_page.dart
│    ├─ widget/
│    │    └─ place_card.dart
└─ view_model/             # Riverpod Provider & 상태관리
     ├─ location_view_model.dart
     └─ review_view_model.dart

---------------------------------------------------------------------------------------------

## 주요 기술
- Flutter Version → 3.32.7
- Dart Version → 3.8.1
- Firebase_Core / Cloud_Firestore
- Dio
- Flutter_Riverpod

---------------------------------------------------------------------------------------------

## 주요 화면
| 검색/리스트 화면 | 리뷰 화면 |
|:---:|:---:|
| ![](docs/Simulator 1.png) | ![](docs/Simulator 2.png) | ![](docs/Simulator 3.png) | | ![](docs/Simulator 4.png) | ![](docs/Simulator 5.png) | ![](docs/Simulator 6.png) |

---------------------------------------------------------------------------------------------