## Intro

**자주 쓰는 위젯 알아보기**

- SafeArea, Scaffold, Container, ListView, Padding, TextButton, Text, TextField, Column, Row, Image, Icon, IconButton, CircularProgressIndicator, SizedBox, Stack, AppBar, BottomNavigationBar, Divider, PageView, ListTile

**자주 쓰지는 않지만 알아야 하는 위젯 알아보기**

- MaterialApp, SingleChildScrollView, AspectRatio

**참고문서**

* [공식 문서](https://api.flutter.dev/index.html) + 구글링

<br>

## 자주 쓰는 위젯

### SafeArea

`SafeArea`의 위젯이 `MediaQuery`를 통해 앱의 실제 화면 크기를 계산해서 표시하기 때문에 잘리거나 가려지는 부분을 해결할 수 있다.

- **Constructors**  

  ```
  SafeArea({Key? key, bool left = true, bool top = true, bool right = true, bool bottom = true, EdgeInsets minimum = EdgeInsets.zero, bool maintainBottomViewPadding = false, required Widget child})
  ```

  * `child` 속성에 `SafeArea`를 적용할 위젯을 적용하면 트리구조 하위로 들어가게 되는것



### Scaffold

`Scaffold` 위젯은  Material Design 형식(구글)의 레이아웃 구조를 제공한다.   
즉, 디자인의 뼈대 역할을 해준다.

* **예시** 

  ```dart
  return Scaffold(
      appBar: AppBar(
          title: const Text('Sample Code'),
      ),
  )
  ```

  <img src="..\images\2022-12-18-(flutter)Study_Week4\image-20221218182017452.png" alt="image-20221218182017452"  /> **Scaffold로 적용된 AppBar 디자인**



### Container, Row, Column

**3개를 응용하면 아래와 같은 그림을 그려낼 수 있다.**

<img src="..\images\2022-12-18-(flutter)Study_Week4\image-20221218182751993.png" alt="image-20221218182751993" style="zoom:80%;" />                                                  <img src="..\images\2022-12-18-(flutter)Study_Week4\image-20221218183141319.png" alt="image-20221218183141319" style="zoom:80%;" />

* **Container** : 색, 위치, 크기 지정 등을 편리하게 할 수 있는 위젯(child : 단수)
* **Row, Coulmn** : 자식들을 행 or 열로 나열하는 위젯(children : 복수)



### ListView

선형으로 정렬된 **스크롤**이 가능한 위젯 목록이다.

**총 4가지 생성 방식 존재**

* **ListView : 명시적 호출**
  * **문제점 **  
    `ListView`는 사용할 수 있는 최대 공간을 사용,  
    `Column`은 높이가 무한대  
    따라서 상위 위젯이 `Column`인 경우 `ListView`의 높이가 무한이 됨으로 에러가 발생
  * **해결법**  
    `Expanded(child: ListView내용)` 이런식으로 감싸서 해결
* **ListView.builder : 동적 호출**
  * 사용할 List를 정해두고, itemBuilder를 사용하여 item을 itemcount에 맞춰서 ListView를 구성
* **ListView.custom**
* **ListView.separated : 구분선 사용 가능**
  * ListView.builder에 구분선이 추가된 형태(separatorBuilder)



### Padding

내부 여백을 지정하는 위젯

* 참고 : `margin` 의 경우 외부 여백을 지정

* `Container` 위젯에서도 padding 속성이 지정 가능한데, 이때 내부적으로 `Padding` 위젯을 생성하는 동작을 진행한다고 함

  * 즉, 어떻게 사용하든 전혀 상관없고 `Container.padding` 이든 `Padding` 위젯을 사용하든 편한 방식대로 사용

  ```dart
  child: Padding(
  	padding: EdgeInsets.all(16.0), // padding 값 지정(all : 전체 방향)
      child: Text('Hello World!')
  )
  ```



### TextButton, IconButton

Material Design의 `TextButton, IconButton`이다.

* TextButton : 말그대로 Text 형태의 디자인 버튼             

* IconButton : 아이콘으로 이루어진 버튼(단일 항목 선택, 해제 때 주로 사용)

  <img src="..\images\2022-12-18-(flutter)Study_Week4\image-20221218234724309.png" alt="image-20221218234724309" style="zoom: 80%;" />             <img src="..\images\2022-12-18-(flutter)Study_Week4\image-20221219183217444.png" alt="image-20221219183217444"  />



### Text, TextField

Text는 말그대로 Text를 출력하는 위젯(Text는 자세한 설명 생략)  
TextField는 Material Design기반이며 사용자 입력을 받아 출력이 되는 위젯

* TextField는 `InputDecoration`을 사용하면 좀 더 다양하게 꾸밀수 있음

* 앱의 키보드가 활성화되고, 키보드 이외의 영역을 선택하였을 시 키보드가 사라지게 하는것은?

  * `GestureDetector`,  `FocusScope` 위젯을 사용

    ```dart
    GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: TextField(...),
    ),
    ```

  

### Image, Icon

Image위젯은 이미지를 출력하는 위젯  
Icon위젯은 아이콘을 출력하는 위젯

* `Icons`속성을 사용하면, `Material Icons`에 지정된 여러 아이콘들을 간편하게 사용할 수 있다.
  * 예로 `Icons.audiotrack` 을 사용하면 오른쪽 아이콘을 간편하게 사용      <img src="..\images\2022-12-18-(flutter)Study_Week4\image-20221219001057936.png" alt="image-20221219001057936" style="zoom:80%;" /> 



### CircularProgressIndicator

앱 로딩 중을 나타내기 위해 회전하는 Material Design 형태인 원형 프로그래스 표시기이다.

<img src="..\images\2022-12-18-(flutter)Study_Week4\image-20221219001718141.png" alt="image-20221219001718141"  />



### SizedBox

`Container`는 width와 height가 없으면 크기가 확장되었지만,   
`SizedBox`는 width와 height가 없으면 child 위젯 크기에 딱 맞게 설정된다.

* 또한, `SizedBox`는 `color` 속성이 없다.



### Stack

`Column`과 `Row`는 각각 세로, 가로 방향 순서대로 위젯들을 배치하였었다.  
그런데, `Stack`은 위치나 규칙없이 배치하므로 위젯들을 겹칠수가 있다.

* 이때 위치를 특정하기 위해 사용하는 위젯은 `Positioned`



### AppBar

앱 상단에 위치하는 부분을 의미

<img src="..\images\2022-12-18-(flutter)Study_Week4\image-20221219003826957.png" alt="image-20221219003826957" style="zoom:80%;" />

* AppBar를 자세히 본다면 `leading, title, actions, flexibleSpace, bottom`으로 나눌수 있다.

  * `leading, actions`는 icon
  * `title`은 text
  * `flexibleSpace`는 AppBar의 크기를 조절할때
  * `bottom`은 AppBar의 탭바(아래쪽에 화면을 이용)등에 쓰인다. 

  <img src="..\images\2022-12-18-(flutter)Study_Week4\image-20221219004121435.png" alt="image-20221219004121435"  />



### BottomNavigationBar

그림의 하단바 부분을 구성하는 위젯이다.

<img src="..\images\2022-12-18-(flutter)Study_Week4\image-20221219010155216.png" alt="image-20221219010155216" style="zoom:;" />

* 아이콘이 필수
* 클릭할때마다 각 파일들은 처음상태로 적용(초기화)



**기본 형태**

```dart
Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex], // screens 배열에 화면 구성할 위젯 미리 선언한 상태
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() =>currentIndex = index), // setState를 써야 바뀐다. 
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            // ... 반복
```



### Divider

구분선 위젯이다.

* 가로 구분선 : `Divider(thickness: 1, height: 1, color: myColor)`
* 세로 구분선 : `VerticalDivider(thickness: 1, width: 1, color: color)`



### PageView

`PageView`를 사용하면 한 화면에서 여러 페이지를 책처럼 넘겨볼 수 있도록 구현할 수 있다.

* 페이지를 수직, 수평으로 넘기거나 페이지 전환 애니메이션 등을 적용가능
* PageController 클래스를 사용해서 트리거 역할을 진행

<img src="..\images\2022-12-18-(flutter)Study_Week4\image-20221219013510586.png" alt="image-20221219013510586" style="zoom:80%;" /> * 페이지를 수평으로 넘기는 `PageView` 의 모습



**코드 구조**

* `PageView` 로 책처럼 페이지들을 구성하고, `PageController` 로 페이지를 넘기기위해 `PageView`에 연결한다.
* `scrollDirection` 속성과 같이 여러 속성들로 커스텀이 가능 

```dart
// PageController 초기화 - index가 0인 페이지 먼저 보여줌
final PageController pageController = PageController(
  initialPage: 0,
);

PageView(
  controller: pageController, // PageController 연결
  // scrollDirection: Axis.vertical, // 페이징 방향을 수직으로 설정도 가능
  // 페이지 목록
  children: [
    // 첫 번째 페이지
    SizedBox.expand(
      child: Container(
        color: Colors.green,
        child: Center(
          child: Text(
            'Page index : 2',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    ),
    // 두 번째 페이지
	// 반복 ...
```





### ListTile

아래 그림과 같은 느낌의 구조를 만들고 싶을때 유용하게 사용할 수 있는 위젯이다.  

<img src="..\images\2022-12-18-(flutter)Study_Week4\image-20221219012506516.png" alt="image-20221219012506516"  />

* `ListTile`은 오른쪽 그림의 뼈대 역할<img src="..\images\2022-12-18-(flutter)Study_Week4\image-20221219012610284.png" alt="image-20221219012610284" style="zoom: 67%;" />

* **특징 : 높이가 고정된 1개의 행(텍스트, 아이콘 등을 포함)**

* **아래 같은 형태로 작성**

  ```dart
  ListTile (
      leading: FlutterLogo(size: 56.0),
      title: Text('Two-line ListTile'),
      subtitle: Text('Here is a second line'),
      trailing: Icon(Icons.more_vert),
  )
  ```

<br>

## 자주 안쓰지만 알아야 할 위젯

### MaterialApp

`MaterialApp` 은 Material Design을 사용할 수 있게 해주는 class이다.  
속성이 여러가지 있는데 `theme, home` 만 설명 하겠다.

* `theme` : 앱의 주요부분 배경색이나, 기본 폰트 등등을 수정할 수 있다.
* `home` : 이부분은 페이지 이며, `Scaffold` 형태를 가진다. 따라서 `Scaffold` 위젯을 사용한다.
  * 참고 : 앞에서 `Scaffold` 위젯은  Material Design 형식(구글)의 레이아웃 구조를 제공한다고 하였었다.



### SingleChildScrollView

화면의 크기보다 위젯이 더 큰 경우 발생하는 overflow 에러를 해결하기 좋은 위젯이다.  
이 위젯을 사용하려는 최상위 위젯을 감싸게 되면, 스크롤을 할 수 있는 형태로 바뀌게 된다.

* `scrollDirection` 속성을 사용해서 스크롤 방향 지정이 가능



### AspectRatio

특정 종횡비로 자식크기를 조정하는 위젯이다. 예로 이미지를 비율로 표시할 수 있게 해준다.

* 높이 계산법 : (width/width ratio) * height ratio
  * 예로 width:300, height:600인 이미지에 ratio:2/1 비율을 주면?  
    width = 300, height = (300/2)*1
  * width = 300, hegith = 150 이 되고, 2:1비율임을 알 수 있다.

<br>

