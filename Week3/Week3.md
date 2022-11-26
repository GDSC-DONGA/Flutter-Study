# Week 3
## 1. 플러터 개발환경 구축
### Flutter SDK 다운로드
-----
1. [링크](https://docs.flutter.dev/get-started/install/windows)에서 플러터 SDK 다운로드<br/>
![SDK Download](https://user-images.githubusercontent.com/111935711/204074861-f05b5d44-f593-4490-9df4-d3e27313b549.jpg)

2. 디렉터리 생성
- 접근 권한이 제한된 폴더 사용 지양(ex. C:\\Program Files)
- 디렉터리명을 영어로 설정

3. 환경변수 설정<br/>
![path](https://user-images.githubusercontent.com/111935711/204075180-e69649bf-ad1e-41fc-a7a8-e9006cc1091f.jpg)

4. 의존성 확인<br/>
![의존성 확인](https://user-images.githubusercontent.com/111935711/204075242-21d2c29a-49b9-4a98-baa9-a6597994c754.jpg)

### Android 설정
-----
1. [링크](https://developer.android.com/studio)에서 안드로이드 스튜디오 다운로드
2. Android Studio > Tools > Android > AVD Manager를 실행하고 Create Virtual Device를 선택

### 에디터 설정
-----
1. VS Code를 시작
2. View > Command Palette…를 호출
3. “install”를 입력하고, Extensions: Install Extensions를 선택
4. 확장 검색 필드에서 “flutter”를 입력하고, 리스트에서 Flutter를 선택한 뒤, Install을 클릭(이렇게하면 필수 Dart 플러그인도 함께 설치)<br/>
![extension](https://user-images.githubusercontent.com/111935711/204075578-d82a6e45-43f0-4730-9605-934daddb1ae1.jpg)
5. VS Code를 다시 로드하기 위해 Reload to Activate를 클릭
6. Reload to Activate을 눌러 VS Code를 다시 시작
7. 설정 확인<br/>
![test](https://user-images.githubusercontent.com/111935711/204075718-65d24e3e-4b59-4023-9ec3-4b2d4b514d0f.jpg)

## 2. 시작 프로그램 뜯어보기
### 프로젝트 생성
-----
```
# flutter create [Project Name]
flutter create first_app                            // 프로젝트명은 소문자와 _를 사용하는 스네이크 케이스(Snake case)를 사용
```
### 주요 폴더 및 파일
-----
1. pubspec.yaml
    - Flutter 프로젝트의 메타 데이터를 정의하고 관리하는 파일(Node의 package.json과 비슷한 역할)
    - 프로젝트의 버전을 관리하고, 서드파티 라이브러리나 디펜던시를 관리
2. iOS/Android/Web 폴더
    - 플랫폼과 관련된 프로젝트와 파일들이 iOS 폴더와 Android 폴더에 저장
    - Flutter로 앱을 개발할 때는 이 폴더안에 내용을 수정할 일이 없지만, 앱을 배포할 때는 이 폴더안에 내용들을 수정함
    - 최근에는 Flutter가 Web 플랫폼도 지원하게 되었으며, Web 플랫폼을 지원하기 위한 파일과 폴더들은 Web이라는 폴더에 저장
3. lib 폴더
    - Flutter 코드 베이스를 저장하는 폴더
    - 이 폴더안에 있는 main.dart 파일이 Flutter 프로젝트의 시작 파일(이 파일을 기준으로 앱을 빌드하고 실행)
4. test 폴더
    - lib 폴더에 Dart를 사용하여 작성한 Flutter 앱을 테스트하기 위한 코드를 저장하는 폴더


## 3. 위젯이란?
### 위젯이란?
-----
- 특정한 기능을 담당한 부품
- 앱에서 위젯은 클래스로 구현하고 이를 상속받는 다양한 위젯이 존재
- 대표적인 위젯
  - Text : 앱에 텍스트를 작성
  - Row, Column : flexible한 레이아웃을 만들어줌
  - Stack : stack 위젯을 사용하면 수직 또는 수평으로 linearly 하게 위젯을 쌓는게 아닌 페인트를 겹겹이 칠하는 것 처럼 위젯을 구현
  - Container : container 위젯은 직사각형의 visual 요소를 만들어 줌

### 위젯 구분
-----
- stateless 
  - 상태가 없는 위젯
  - 변화가 거의 없는 위젯은 이것으로 선언한다
- statefull
  - state라는 데이터 변화를 감지하고, state가 변할시 위젯을 rebuild 하는 위젯
  - setState라는 함수를 통해 state변화를 감지하여야 함
  - 계산기와 같이 숫자가 변화하는 뷰를 만들 경우 앱이 위젯의 상태를 보다가 위젯이 특정 상태가 될 때 알맞은 처리를 수행해야함. 즉 상태가 연결된 동적인 위젯을 statefull 위젯이라고 함
### 위젯 생명주기
-----
![widgetState](https://user-images.githubusercontent.com/111935711/204076593-8ea9e06b-d53f-4002-a66b-36b12d5227db.png)
1. 생성
    - createState() 실행 : statefull widget 객체를 생성할 시 가장 먼저 실행되는 함수.(반드시 존재해야하는 함수) State를 실질적으로 만드는 작업을 수행
    - buildContext를 할당 후 mounted값을 true로 바꿈 : 모든 위젯들은 mounted 속성 값을 가지고 있으며, buildContext가 정상적으로 할당되었을 경우 mounted 값은 true가 됨
    - initState() 실행 : widget이 만들어진 후 가장 처음에 호출되는 함수. 생명주기 단계에서 단 한번만 호출됨
    - didChangeDependencies() 실행 : initState()함수 다음에 실행되며, build() 함수가 실행되기 전 반드시 호출되는 함수. State 객체의 종속성이 바뀔 경우 실행
    - build() 실행 : 화면에 보여줄 widget 객체를 리턴
2. 수정
    - setState() 호출 : 데이터가 변경되었음을 알리며 buildContext에 연결된 widtet들을 새로 만듦
    - didUpdateWidget() 실행 : 부모 widget이 업데이트 되었거나, 다시 build() 함수를 실행시켰을 경우 호출. 런타임 상황에서 실행되는 initState()라 생각하면 이해가 쉬움
3. 해제
    - deactivate() : State객체가 widget 트리에서 제거되는 순간 호출됨
    - dispose() : 모든 작업이 끝난 후 함수를 호출하여 자원을 해제