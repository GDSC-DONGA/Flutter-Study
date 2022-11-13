## Intro

`Fluter`를 본격적으로 들어가기 시작하겠습니다.

우선 `Flutter 개발환경 구축` 이후 간단히 `시작 프로젝트 구조` 확인 및 `위젯`에 대해 정리하겠습니다.

<br>

## 1. 플러터 개발환경 구축

* 참고 URL : [플러터 설치(공문)](https://docs.flutter.dev/get-started/install), [설치 도움받은 사이트](https://brunch.co.kr/@mystoryg/114)
* 안드로이드 스튜디오는 이미 깔려있어서 생략
* 플러터는 리액트 네이티브처럼 `hot reload`가 가능합니다(변경사항 바로바로 적용)



### 설치 과정

* 사이트에서 플러터 SDK 다운

  * 경로는 로컬C에 설치 하였음

* SDK 설치 확인

  * flutter 경로의 터미널에서 `flutter doctor` 명령어로 확인
  * 만약 명령어 입력 에러라면 환경 변수 등록
    * `시스템 속성 -> 환경 변수 -> Path 편집 -> 경로 새로 설정`
    * 경로 예 : `C:\flutter\bin`

  <img src="..\images\2022-11-12-(flutter)Study_Week3\image-20221113143036206.png" alt="image-20221113143036206"  />



* 첫 번째 [v] Flutter 이부분 체크 되어있는지 여부로 SDK 설치 확인
* 두 번째 [!] Android toolchain은 라이선스 동의가 필요하기 때문에  
  `flutter doctor --android-licenses` 명령어 입력

<img src="..\images\2022-11-12-(flutter)Study_Week3\image-20221113143344397.png" alt="image-20221113143344397"  />



* 해당 Android sdkmanager에러 발생한 경우?

  * 안드로이드 스튜디오에서 `Android SDK Command-line Tools` 다운 받을것
  * `settings -> sdk검색 -> Android SDK 접근`해서 찾아서 다운
    * 이후 다시 라이선스 명령어 입력시 잘 동작
  
<img src="..\images\2022-11-12-(flutter)Study_Week3\image-20221113143838179.png" alt="image-20221113143838179"  />



### VS-Code로 실행

* flutter 검색해서 설치

  <img src="..\images\2022-11-12-(flutter)Study_Week3\image-20221113152525108.png" alt="image-20221113152525108"  />



### 테스트 앱 구현

* `View-> Command Palette -> flutter 입력 후 -> 하단에 Flutter: New Application Project 클릭`

  * `F1` 키 단축키 활용 추천

* `폴더 위치 지정 후 -> 프로젝트 명을 입력`

* `View-> Command Palette -> Emulator 입력 후 -> 하단에 Flutter: Launch Emulator 클릭`

  * AVD 설정

* `에뮬레이터를 선정 후 -> Run -> Run Without Debugging (or ctrl + F5) 클릭`

  * `F5` 단축키로 실행 추천(AVD 구동 안하고 하면 웹으로 킴)

  

* 에러 발생

  <img src="..\images\2022-11-12-(flutter)Study_Week3\image-20221113153903773.png" alt="image-20221113153903773"  />

  

  * 해결한 방법은 3번째 방법인 `org.gradle.java.home` 이 부분을 추가해서 해결하였습니다.

    <img src="..\images\2022-11-12-(flutter)Study_Week3\image-20221113162804432.png" alt="image-20221113162804432"  />

<br>

## 2. 시작 프로젝트 뜯어보기

**아래는 프로젝트에 구성된 폴더와 파일들의 일부분 입니다.**

```
|---- android
|---- build
|---- ios
|---- lib
|---- pubspec.yaml
```

* `android` : 안드로이드 프로젝트가 빌드 될 디렉토리
* `ios` : iOS 프로젝트가 빌드 될 디렉토리
* `lib` : 플러터 코드들이 들어갈 디렉토리
* `pubspec.yaml` : 프로젝트에 사용될 dependency들이 정의(라이브러리 설치)  
  구조는?
  * 프로젝트 이름, 설명, 버전
  * 개발 환경 (다트 버전)
  * dependency
  * 개발 dependency
  * Cupertino(애플), material(구글) 디자인은 기본으로 세팅되어 있다.
  * 앱에 들어갈 리소스 목록



### main() 함수

`runApp()` 함수를 호출

* `binding.dart`  클래스에 정의되어 있으며, 앱 시작하는 역할

```dart
// main.dart
void main() {
  runApp(const MyApp()); // MyApp이라는 위젯을 전달해서 앱 시작
}
```



### MyApp 클래스

`build()` 함수는 어떠한 위젯을 만들 것인지를 정의합니다.

* 아래 예시는 `MaterialApp` 을 활용해서 위젯 그린 예시입니다.

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'), // 상단바 설정
    );
  }
}
```

<br>

## 3. 위젯이란?

**스마트폰, PC 등에서 웹브라우저를 통하지 않고 날씨, 달력 등의 기능을 바로 이용할 수 있도록 만든 솔루션입니다.**  

* 핵심 아이디어는 위젯으로 UI를 구축한다는 것입니다.
* 또한 플러터의 위젯은 **리액트**의 영감을 많이 받았습니다.
* 플러터는 위젯 트리를 시작으로 렌더링을 하게 됩니다.
* **오픈소스 패키지**
  * [pub.dev](https://pub.dev/) - **dart와 flutter의 공식 패키지 저장소**




### Basic widgets

* `Text` : String과 style로 구성
* `Row, Column` : flex위젯이며, 가로나 세로축 방향으로 정렬
* `ListView` : Column에서 스크롤이 가능한 위젯  
  데이터가 많거나 데이터를 미리 알 수 있는 상태라면 `ListView.builder`를 사용하는게 좋다.   
  * `ListView.builder`는 아이템이 보일때 렌더링을 하는 방법으로 성능이 더 나아진다.
* `Stack` : 웹의 absolute layout과 유사한 특징
* `Container` : 직사각형 시각적 요소를 만들수 있음(여백, 패딩 등 가능)



### Using Material Components

**MaterialApp은 Material Design을 사용할 수 있게 해주는 class**

* 다양한 속성을 사용 가능합니다.
* 선택사항일 뿐이지만, 좋은 방법입니다.



### Stateless? Stateful?

위젯은 크게 상태를 가진 위젯(StatefulWidget)과 상태를 가지지 않은 위젯(StatelessWidget)으로 구분

* 둘 간의 성능차이는 없습니다.
* `setState` 메소드를 가지냐 안가지냐의 차이로 볼 수도 있습니다.
* `stateless` 는 state를 단지 안보이게 한 것일 뿐입니다.
* 그래도 상태가 없다면 `stateless` 위젯을 쓰는게 불필요한 코드를 줄입니다.



### Keys

모든 위젯에는 `key`인자가 optional로 들어가 있고, 4종류의 키가 있습니다.

* `ValueKey<T>` : 유니크하고 변하지 않는 값을 갖는 오브젝트를 식별할 때 사용
* `ObjectKey` : 오브젝트의 리스트가 있고 각 오브젝트의 각 필드들이 유니크하다고 보장할 수 없지만, 필드들의 조합은 유니크할 때 사용
* `UniqueKey` : 앱내에 딱 하나만 있는 것
* `GlobalKey` : 여러 위젯들의 상태 싱크를 맞출때 사용

