# SafeArea
디자인 한 UI가 어떤 기종에서든 잘 보여지도록 함.<br>
<img src="https://user-images.githubusercontent.com/84646738/204072232-fd1ea174-f076-4fec-95d1-c467ef4397cd.png"><br>
이렇게 하단이 잘리는 경우에 SafeArea로 감싸준다면<br>
<img src="https://user-images.githubusercontent.com/84646738/204072252-d02174a1-3e23-4f17-bdb1-3aa16f7301e0.png"><br>
이런 결과를 얻을 수 있다.<br><br>

SafeArea의 위젯이 MediaQuery를 통해 앱의 실제 화면 크기를 계산하고 이를 영역으로 삼아 내용을 표시하기 때문에 잘리는 부분없이 전부 나올 수 있는 것임.

```dart
import 'package:flutter/material.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'CheckboxListTile Example';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: SafeArea(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                trailing: Icon(Icons.navigate_next),
                onTap: (){},
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                trailing: Icon(Icons.navigate_next),
                onTap: (){},
              ),
            ],
          ),
          top: true,
          bottom: true,
          right: true,
          left: false,
          maintainBottomViewPadding: false,
        ),
      )
    );
  }
}
```
<img src = "https://user-images.githubusercontent.com/84646738/204074143-d46b6dbd-3186-4460-9703-0a21c1d90aea.jpg">

# Scafold
MaterialApp은 Material Design Pattern으로 하위 페이지나 구성 요소를 담는 그릇이라고 볼 수 있다.(Material Design은 구글에서 만든 디자인 스타일, 혹은 컨셉임.)<br>
그 중 home이라는 옵션은 앱의 화면 구성을 담당하는 부분이다.
<br><br>
<b>Scaffold</b>
기본적인 앱에서 디자인적인 뼈대를 구성하는 위젯이다.
앱 전반적인 디자인에 대한 다양한 속성들을 활용할 수 있다.
* appBar : 화면 상단 바에 대한 설정
* body : 메인 화면 부분

# child/children
특정 컨테이너의 하위 위젯을 넣으려면 child/children으로 할당해주면 된다.
하나만 넣으려면 child, 여러개면 children이다.
위의 코드에서는 body에 ListView 하나만 들어가므로 child로 넣었고, ListView에 ListTile이 복수로 들어갔기 때문에 children으로 넣었다.

# ListTile/ListView
ListView : 항목들을 행으로 나열함.
ListTile : 각 항목에 대한 열의 항목들을 나열함.(아이콘, 텍스트 등)

```dart
import 'package:flutter/material.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'CheckboxListTile Example';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.grey[850],
                ),
                title: Text('home'),
                onTap:(){
                  print('Home pressed');
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.image,
                  color: Colors.grey[850],
                ),
                title: Text('view Image'),
                onTap:(){},
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                leading: Icon(
                  Icons.border_color,
                  color: Colors.grey[850],
                ),
                title: Text('글쓰기'),
                onTap: (){},
                trailing: Icon(Icons.arrow_forward_ios),
              )
            ]
          )
        ),
      )
    );
  }
}
```
<img src = "https://user-images.githubusercontent.com/84646738/204074750-41b59cf6-f383-4c78-8b9c-a03c9b37fac7.jpg"><br>
* leading : 아이콘
* title : 텍스트
* onTap : 항목을 누를경우 수행되는 메서드
* trailing : title 뒤에 할당할 위젯에 대한 속성. 보통 Icon 위젯이 따라옴.
  상단의 코드에서는 Icon(Icons.arrow_forward_ios)를 넣음으로써 > 모양 아이콘이 title 다음으로 할당되는 것을 확인할 수 있음.

# Container
플러터 레이아웃의 기본 요소.
```dart

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: First(),
    );
  }
}

class First extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("hello", style: TextStyle(color: Colors.red),),
      ),
      body: Container(
        color: Colors.green,
      ),
    );
  }
}
```
![컨테이너1](https://user-images.githubusercontent.com/84646738/204076743-bfad16c1-4c63-47c8-a2e9-3327aa9b2715.jpg)<br>
따로 사이즈나 child를 지정하지 않으면 AppBar를 제외한 body 전체 영역에 설정한 옵션이 지정된다.
<br>
```dart
body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: Colors.green,
        child: Text("안녕하세요"),
        width: 300,
        
      ),
```
![컨테이너5](https://user-images.githubusercontent.com/84646738/204078035-69ee8ab6-b424-42d9-afe0-e4fd624c1932.jpg)<br>
child로 지정한 옵션의 영역을 기본적으로 할당하게 되고,
그외의 부가적인 설정으로 세부적인 영역을 설정할 수 있다.

## padding, margin
padding은 레이아웃과 위젯 사이 빈공간
margin은 위젯과 위젯 사이 빈공간을 설정한다.
* EdgeInsects.symmetric(horizontal: 10) : 양쪽 수평으로 적용
* EdgeInsects.symmetric(vertical: 10) : 양쪽 수직으로 적용
* EdgeInsects.all : 전체 방향에 적용
* EdgeInsects.only(top: 10, bottom: 10, left: 10, right: 10) : 세부 설정 가능

## Column
Container의 자식 옵션이 child라면
Column은 children을 가진다. 복수개의 하위 자식을 할당할 수 있다.

```dart
body: Column(
        children: [
          Text("자식1"),
          Text("자식2"),
          Text("자식3"),
        ],
      ),
```
![컬럼1](https://user-images.githubusercontent.com/84646738/204078395-97fde3b1-e8a9-4f78-9d81-3c263bfdc61b.jpg)<br>
Column은 레이아웃이기 때문에 Container의 색상이나 경계선, 넓이, 높이따위의 옵션을 줄 수 없다.<br>
Column의 높이는 남아있는 공간을 모두 차지하고
넓이는 아래 children중 가장 긴 것을 따라간다.(Row는 반대)

```dart
body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("자식1"),
          Text("자식2"),
          Text("자식3"),
        ],
```
mainAxisAlignment는 자식들을 위 아래 방향으로 배열시키는 옵션이다.
* mainAxisAlignment: MainAxisAlignment.start => 기본값<br>
![자식1](https://user-images.githubusercontent.com/84646738/204078793-b6afc87c-9dc5-4449-bb53-9e3d879c8417.jpg)<br>
* mainAxisAlignment: MainAxisAlignment.center => 위 아래 방향으로 정중앙<br>
![자식2](https://user-images.githubusercontent.com/84646738/204078831-214de9fd-b461-4499-bc32-13afc23a4011.jpg)<br>
* mainAxisAlignment: MainAxisAlignment.end<br>
![자식3](https://user-images.githubusercontent.com/84646738/204079171-d25387f4-78d2-4403-8b25-810dd101eaae.jpg)
<br>
crossAxisAlignment는 자식들을 수평 방향으로 배열시키는 옵션이다.
```dart
body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("자식1"),
          Text("자식222"),
          Text("자식33333"),
        ],
```

* crossAxisAlignment: CrossAxisAlignment.start => 수평방향 기본값<br>
![크로스11](https://user-images.githubusercontent.com/84646738/204079551-d9c79efa-eb42-442c-8ace-f8d65920212f.jpg)<br>

* crossAxisAlignment: CrossAxisAlignment.center => 수평방향 정중앙<br>
![크로스22](https://user-images.githubusercontent.com/84646738/204079654-76820293-4924-4a60-9e11-3a63879bd938.jpg)

* crossAxisAlignment: CrossAxisAlignment.end => 수평방향 오른쪽 정렬<br>
![크로스33](https://user-images.githubusercontent.com/84646738/204079743-f80176dc-d5bd-4b0b-b3fd-83dc41b92980.jpg)


# Button
!! 주의사항
1. child와 onPressd는 required이기 때문에 반드시 써줘야함.
2. 색상과 같은 design부분은 styleForm을 받아서 함.
3. 버튼의 높이나 너비를 지정하기 위해서는 반드시 sizedbox를 활용해 child로 넣어야 함.
4. 버튼은 사방으로 약간의 margin이 기본적으로 존재함.(2px 정도)

플러터의 버튼은 크게 3종류가 있다.<br>
Text BUTTON : Text만 나옴.
Elevated BUTTON : 배경색으로 버튼임을 강조함.
Outlined BUTTON : 가장자리가 존재함.

```dart

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar:AppBar(
          title: Text('hello world'),
        ),
        body:Center(
          child: Column(
            children:[
              TextButton(onPressed: () {}, child: Text("Text Button"),
              ),
              ElevatedButton(onPressed: () {}, child: Text("Elevated Button"),
              ),
              OutlinedButton(onPressed: () {}, child: Text("Outlined Button"),
              ),
            ]
          )
        )
      )
    );
  }
}
```
![버튼1](https://user-images.githubusercontent.com/84646738/204561960-88f60017-04f3-44f1-a3a0-6fed3daaf602.jpg)


# Textfield
```dart

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar:AppBar(
          title: Text('hello world'),
        ),
        body:Center(
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Input',
            ),
         )
        )
      )
    );
  }
}
```
![image](https://user-images.githubusercontent.com/84646738/204785449-3a285c7f-4dca-4839-93de-3c8161da4a12.png)

사용자의 입력을 받는 Textfield
```dart
TextField(
  decoration: InputDecoration(
    labelText: 'Input',
  ),
)
```
InputDecoration을 사용하면 Textfield 위젯을 더 다양하게 사용할 수 있다.

```dart

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar:AppBar(
          title: Text('hello world'),
        ),
        body:Center(
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'Enter your email',
              labelStyle: TextStyle(color: Colors.redAccent),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(width: 1, color: Colors.redAccent),
              )
            ),
         )
        )
      )
    );
  }
}
```
![image](https://user-images.githubusercontent.com/84646738/204787649-372acfd5-06e8-46fb-abb5-fd5ef0f649e5.png)

# image
![image](https://user-images.githubusercontent.com/84646738/204792940-4d1e521b-2761-430f-9635-f3f4ea08b353.png)<br>
프로젝트에 image파일들을 보관할 경로를 새로 만들어준다.<br>

![image](https://user-images.githubusercontent.com/84646738/204793464-25cf489f-16ac-4102-b185-fd2944abdf0d.png)<br>
pubspec.yaml에서 assets 부분에 해당 폴더의 경로를 잡아주고 Pub get을 누른다.


```dart

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: cat(),
      )
    );
  }

  Widget cat() {
    return Image.asset('images/sunflower.jpg', height: 200, width: 300);
  }
}
```
![image](https://user-images.githubusercontent.com/84646738/204793140-f4976b68-1f8b-4090-9160-19fa2aa06264.png)<br>

# Icon
기본적으로 사용할 수 있는 것으로 Materal UI와 Cupetino아이콘이 있다.
## Material UI 아이콘
1. Google Font 사이트에서 Icon 검색:  https://fonts.google.com/icons?selected=Material+Icons 
2. 적용하고자 하는 아이콘 선택
3. 오른쪽 화면에서 Icon ID를 복사 
![image](https://user-images.githubusercontent.com/84646738/204795103-3dd00947-a445-4e66-a39d-e3b45ff58f7d.png)

main.dart 상단에 import 'package:flutter/material.dart'; 를 통해 Icon class의 객체를 만들어 사용할 수 있다. Icon class는 Icon ID, color, size, accessibility mode에서의 text를 설정할 수 있다.

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Center(
                child: (Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const <Widget>[
          Icon(
            Icons.favorite,
            color: Colors.pink,
            size: 24.0,
            semanticLabel: 'Text',
          ),
          Icon(
            Icons.audiotrack,
            color: Colors.green,
            size: 30.0,
          )
        ])))));
  }
}
```
![image](https://user-images.githubusercontent.com/84646738/204797002-5db6b600-3217-4162-b0b2-59f4c345770e.png)


# IconButton
버튼에 아이콘 박은거.
버튼을 누르면 소리 볼륨이 10씩 올라가는 모양의 예시 코드.
```dart
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = 'IconButton class Test';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const Center(
          child: MyStatefulWidget(),
        )
      )
    );
  }
}
double _volume = 0.0;
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.volume_up),
          tooltip: 'Increase volume by 10',
          onPressed: () {
            setState(() {
              _volume += 10;
            });
          },
        ),
        Text('Volume: $_volume'),
        ]
    );
    
  }
}
```
![image](https://user-images.githubusercontent.com/84646738/204804102-0a359646-e84b-45ae-83d5-382eb730fcca.png)

# CircularProgressIndicator
앱 진행 상황을 나타낼 때 가장 많이 사용되는 위젯. 
원형과 선형 2가지를 주로 쓴다.

1. Determinate
특정한 값을 갖는 것인데, CircularProgressIndicator의 value 속성을 활용하는 것이다. 0.0~1.0사이의 값을 value에 설정한다.
특정 값으로 고정시킬경우, 위젯 자체도 움직이지 않는다. 따라서 value가 계속 변화하기위해 Controller가 필요하다.



2. Indeterminate
value값을 특정하지 않아서, 진행률이 얼마나 되는지 표시하지 않는다. 진행중이라는 모션을 계속해서 보여준다.

```dart
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: Stack(
            fit: StackFit.expand,
            children: const [
              CircularProgressIndicator(
                strokeWidth: 10,
                backgroundColor: Colors.white,
                color: Colors.green,
              ),
              Center(
                child: Text(
                  'My Progress Indicator',
                  style: TextStyle(fontSize: 20),
                )
              )
            ]
          )
        )
      )
    );
  }
}
```
![image](https://user-images.githubusercontent.com/84646738/204811035-ce0738f2-9708-4fe3-ad43-6a334379310c.png)

# Container와 SizedBox 위젯차이
둘 다 width, height를 가진다는 공통점이 있다.

Container의 경우 width, height를 넣지 않으면 최대 크기로 확장해준다.
```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Container와 SizedBox 차이",
      home: Example(),
    );
  }
}
class Example extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Center(
          child: Text("컨테이너"),
        ),
      ),
    );
  }
}
```
![image](https://user-images.githubusercontent.com/84646738/205084870-58a8d113-3e34-4882-b58f-aea0466b82a9.png)


SizedBox의 경우 width와 height 둘 중 하나라도 설정하지 않으면 크기는 child의 크기에 맞게 설정된다.
```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Container와 SizedBox 차이",
      home: Example(),
    );
  }
}
class Example extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          child: Container(
            color: Colors.blue,
            child: Text("Container"),
          ),
        )
      )
    );
  }
}
```
![image](https://user-images.githubusercontent.com/84646738/205087401-87209de4-e2f6-47f5-bd26-41486864f100.png)
그리고 color 속성이 없어서 색상을 입힐 수 없다고 한다.

# Stack
기존에는 컨테이너와 같은 위젯들을 배치하기 위해 Column, Rows 같은 배치용 위젯을 사용했다.
Stack은 컨테이너나 이미지를 서로 겹쳐서 배치할 수 있도록 만들어준다.

Column, Rows와 마찬가지로 배치하고자 하는 위젯들을 Stack으로 감싸주면 된다!
```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Stack 예제'),
          ),
          body: Stack(children: <Widget>[
            Container(
              color: Colors.yellow,
              height: 100,
              width: 80,
            ),
            Container(
              color: Colors.blue,
              height: 50,
              width: 50,
            )
          ])),
    );
  }
}
```
![image](https://user-images.githubusercontent.com/84646738/205091737-784c9f9c-b201-427f-97cf-7fe8a3c82d0d.png)

Positioned 위젯으로 감싸서 가로 세로 위치를 지정하여 child에 배치 하고자하는 위젯을 넣어줄 수도 있다. 이렇게 하면 컨테이너의 위치를 지정할 수 있다.
```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Stack 예제'),
          ),
          body: Stack(children: <Widget>[
            Container(
              color: Colors.yellow,
              height: 100,
              width: 80,
            ),
            Positioned(top:50, left:50,
            child: Container(
              color: Colors.blue,
              height: 50,
              width: 50,
            )
            )])),
    );
  }
}
```
![image](https://user-images.githubusercontent.com/84646738/205092677-5ac7cdf3-5128-480c-8412-8aa08a12028f.png)
다만 이럴 경우 노란색 컨테이너가 먼저 작성이 되어있기 때문에 그 컨테이너 범위 내에서만 파란색 컨테이너가 이동할 수 있다. 그 범위를 넘어서게 되면 위 그림처럼 잘리게 된다.


# ButtomNavigationBar

하단바(탭)을 제작하는 위젯
```dart
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MarketPage(),
    );
  }
}

class MarketPage extends StatefulWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold
  );  // 텍스트 스타일 지정 부분

  final List<Widget> _widgetOptions = <Widget>[
    MySellPostPage(),
    MyPostPage(),
    MyPage(),
  ];  // 3개의 버튼에 각각 연결된 페이지 지정
  void _onItemTapped(int index) { // 탭을 클릭했을 때 지정한 페이지로 이동하는 State
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.text_snippet),
              label: '나의 판매글',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '홈',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: '마이페이지',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightGreen,
        onTap: _onItemTapped,
      ),
    );
  }
  @override
  void initState() {  // 해당 클래스가 호출되었을
  super.initState();
  }
  @override
  void dispose() {
  super.dispose();
  }
}
```
![image](https://user-images.githubusercontent.com/84646738/205099693-9dec5582-2135-4a3c-9aef-4c148927b110.png)

