# 인텔리제이에서 플러터 환경 설정하기

1. Android SDK 설치
Setting > Android SDK > Edit
SDK Components 체크 > Next > Finish

2. Flutter 플러그인 설치
Setting > Plugins > Marketplace > Flutter 검색, 설치
Dart도 같이 설치하면 됨.

3. Flutter SDK 설치
https://flutter.dev/docs/get-started/install
!주의 : zip 압축 풀기시 Program Files 아래 위치하면 안됨.
Setting > Flutter > Flutter SDK 위치를 압축 푼 경로로 지정.

4. Flutter 프로젝트 생성
Project name은 소문자 언더바 구분으로 입력할 것.
test_flutter(o)

5. AVD(Android Virtual Device) 생성 및 실행
Tools > Android > AVD Manager 실행
Create Virtual Device 클릭
Phone > Pixel 2 선택하고 Next
API 30 Download > 완료 후 Next > Finish > Actions의 실행 버튼 클릭시 AVD가 구동 됨.

6. Pubspec.yaml 파일 열고 상단의 Pub get 클릭 > main.dart 열람 문제 해결됨.

# 시작 프로젝트 뜯어보기 + Widget 이란?

<img src="https://user-images.githubusercontent.com/84646738/204071743-c220afac-6e9f-47ba-bcdc-4779dedb9033.jpg"><br>
## 1. main() 함수
다트 앱 실행시 main()함수가 시작된다.<br>
runApp은 플러터 앱을 시작하는 역할을 한다.<br>
이 함수에 플러터 앱을 시작하면서 화면에 표시할 위젯을 전달한다.<br>

## 2. runApp() 함수
첫 화면을 띄우는 작업을 수 행하는 함수.<br>
매개변수로 Widget 객체를 넣어 우리가 구현한 화면을 보이도록 만들어준다.<br>

## 3. Widget
화면에 보이는 모든 것을 지칭하며 Flutter는 Widtet 기반 프레임워크라고 할 수 있다.<br>
우리가 구현한 Widget을 화면(UI)에 배열하는 방식으로 구성된다.
대표적인 예시로

* 하나의 기능을 담당 -> 예 : 버튼
* 스타일 적 요소 설정 -> 예 : 폰트, 컬러
* 하위 Widget의 나열 방식을 설정 -> 예: 수직, 수평 정렬
* 여백 및 간격 설정 -> 예: 패딩

등이 있다.
Widget은 Widget객체를 리턴하는 build() 메서드를 기본적으로 가지고 있다.
여기에 어떤 화면을 구성할 것인지에 대한 코드를 작성한다.
Widget은 변하지 않는 특성을 가지고 있어서 성능이 가볍다.

### StateFulWidget / StateLessWidget
Widget자체는 불변하지만 사용자의 행동에 따라 화면 갱신이 필요한 Widget도 있다. 이를 위해 Flutter에서는 아래의 두가지 위젯으로 구분하였다.

* StatelessWidget : 단 한 번만 build() 메서드를 실행한다. 그려진 화면은 계속 유지된다.
* StatefulWidget : state라는 상태 관리 값을 기본으로 가지고 있으며, setState() 메서드를 실행할 때마다, 다시 build()메서드를 실행해 Widget을 갱신한다.

build() 메서드 내에 사용된 Widget의 역할
* Appbar : 앱 내 상단의 Widget
* Center : 자식 Widget을 자기 자신 중앙에 배치하는 Widget
* Text : 화면에 문자열을 표시하는 Widget

## 4. MaterialApp
Flutter 기본 내장 Widget
앱의 테마 및 설명을 적을 수 있다.
Scaffold에서는 appbar, body 설정을 통해 상단 화면과 홈 화면을 설정할 수 있다.

## 5. Const
위젯을 Const로 선언하면 위젯이 상수로 인식되므로, 한번 그려지면 이전의 값을 계속 활용해 쓸데없는 build() 호출을 줄일 수 있다. 특히 StateFulWidget에서 큰 효과를 발휘한다.
따라서 위젯을 선언할 때는 되도록 Const를 적용하는 것이 좋다.

