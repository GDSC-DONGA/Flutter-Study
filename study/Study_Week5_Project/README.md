## Intro..

**5주차 소규모 프로젝트로서 간단한 영화(나 그 외 어떤 것이든) 정보 조회 앱 만들어보기.**

좀 더 정리를 잘 해뒀었지만, 파일을 실수로 날림; ; ; ;

- 데이터는 모두 더미로 생성
  - `TMDB` 사이트에서 API 신청을 통해서 영화 정보를 따로 가져옴
  - 코드 상에서 API 호출은 생략하였고, 따로 데이터를 가공해서 `main.dart` 상단에 변수로 선언해두었다.

- 첫 페이지에서는 여러 영화의 이미지, 제목, 설명 등을 간단하게 보여주는 리스트.
- 해당 영화를 클릭하면 영화의 세부정보 (이미지, 제목, 설명 외에도 개봉, 감독, 배우, 총 길이 등)

<br>

## Run APP

<img src="..\..\images\2023-01-03-(flutter)Study_Week5_Project\image-20230105033258603.png" alt="image-20221218182751993" />

<img src="..\..\images\2023-01-03-(flutter)Study_Week5_Project\image-20230105033403321.png" alt="image-20221218182751993" />

<br>

## Folder Structure

* **[`./lib/main.dart`](./lib/main.dart)**
  * **위젯 구조 : `MaterialApp -> FirstRoute -> SecondRoute`**
    * `FirstRoute -> Scaffold -> SingleChildScrollView -> Column -> Card -> ListTile`
    * `SecondRoute -> Scaffold -> SingleChildScrollView -> Column -> Image,Text,Row`

* **[`./assets/json/dataDummy.json`](./assets/json/dataDummy.json)**
  * `TMDB` 에서 가져온 데이터를 저장해두었다.
  * 실제론, 이 파일 사용하진 않고 미리 데이터를 **[`/main.dart`](/lib/main.dart)** 에 변수 선언 하였다.

* **[`./pubspec.yaml`](./pubspec.yaml)**
  * `assets` 방식으로 파일 입출력을 통해서 json 파일을 가져오려고 했지만, 이방법은 사용하지 않게 되었다.


<br>

## 참고 skill

* `StatefulWidget` 형태가 아닌 `StatelessWidget`  를 상속받아서 작성하였다.
* `MaterialApp` 위젯은 `Scaffold` 위젯을 사용하기 때문에 사용하였다.
* `SingleChildScrollView ` 를 통해서 화면을 넘어서는 데이터량을(오버플로 에러) 스크롤 형태로 해결하였다.
* `ListTile` 을 통해서 데이터 나열을 위해 따로 UI를 구성하지않고, 간단히 해결하였다.
* `Navigator.push, Navigator.pop`을 사용해서 페이지 이동을 하였다.
  * `MaterialPageRoute` 을 통해 페이지 이동간에 데이터 전달을 함께 하였다.

<br>

## 공부할 점

* 코드 안에서 for문, if문 등등을 사용하는 부분이 구조상 어디에서 가능한지 좀 더 공부할 필요가 있다.

* `StatefulWidget` 사용시 상태관리를 할 수 있는것 같던데, `setState` 같은 상태 함수를 사용하게 된다면?
  * 이때 동적으로 데이터를 보여주려면 **비동기, 동기 함수**를 사용할테니 이부분을 더 공부할 필요가 있다.
    * 리액트 네이티브의 경우 `async, await`  or `.then`  등등 사용

* `StatelessWidget` 도 당연히 동기, 비동기 가능하며 동적으로 데이터 보여주는 방법이 있는것 같아서 공부!
