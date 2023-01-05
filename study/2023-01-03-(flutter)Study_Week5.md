## Intro

- 페이지 간 이동 방법, 다른 페이지 만드는 방법 알아보기 (Navigator)
- 페이지 간에 데이터 넘겨주는 방법 알아보기
- 외부의 리소스 가져오는 방법 알아보기 (보통 이미지나 글꼴, `pubspec.yaml`의 `assets`에 등록.)
- 간단한 영화(나 그 외 어떤 것이든) 정보 조회 앱 만들어보기.
  - 이부분에 관해서는 따로 정리해서 프로젝트 폴더를 올리겠다.
  - 즉, 이 문서에서는 위의 3가지를 정리한다.

**참고문서**

* [공식 문서](https://api.flutter.dev/index.html) + [Navigator](https://flutter-ko.dev/docs/cookbook/navigation/navigation-basics) + 구글링

<br>

## Navigator

**스택 구조로 하위 위젯 세트를 관리하는 위젯을 Navigator 위젯이라고 한다.**

* 참고로 flutter에서는 *screen* 과 *page* 는 *route* 로 불린다.
  * route는 Android의 Activity와 동일
  * route또한 flutter에선 위젯이다.



**여러 페이지를 만들어서 페이지 간 이동을 구현하는 방법**

* 두 개의 route를 생성한다.
* Navigator.push()를 사용하여 두 번째 route로 전환한다.
* Navigator.pop()을 사용하여 첫 번째 route로 되돌아 온다.
* 참고로 당연히 다른 메소드를 사용하는 방법이라던지 등등 여러가지가 있다.



### 1. 두 개의 route를 생성

route는 앞서 얘기했듯이 page. 즉, 안드로이드에서의 Activity로 생각을 하자.

**그럼 Activity로 구성될 페이지 2개를 클래스로 생성한다.**

* 아래 코드는 페이지 1개의 클래스 코드 구조를 보여주는 예시이다.

```dart
class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Route'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Open route'),
          onPressed: () {
            // 눌렀을 때 두 번째 route로 이동합니다.
            // 이곳에 Navigator 메소드 사용하게 될 것.
          },
        ),
      ),
    );
  }
}
```



### 2. Navigator.push() 사용

`Navigator.push()` 를 사용해서 두 번째 route로 전환한다.

**즉, 내부적으로 route를 Navigator가 관리하는 route 스택에 추가하는 동작을 진행한다.**

* 따라서 `onPressed()` 콜백을 수정한다.
  * 전환할 페이지를 넣을때 Route를 직접 만들거나, `MaterialPageRoute` 을 사용하면 된다.
* 아래는 예시 코드

```dart
// Within the `FirstRoute` widget
onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SecondRoute()),
  );
}
```



### 3. Navigator.pop() 사용

`Navigator.pop()` 를 사용해서 두 번째 route를 닫고, 첫 번째 route로 되돌아 간다.

**즉, 내부적으로 Navigator가 관리하는 route 스택에서 현재 route를 제거한다.**

* 따라서 `onPressed()` 콜백을 수정한다.
  * `context`가 현재 페이지를 가리키는 거라고 생각하면 된다.
* 아래는 예시 코드

```dart
// Within the SecondRoute widget
onPressed: () {
  Navigator.pop(context);
}
```



### 최종 코드

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: FirstRoute(),
  ));
}

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Route'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Open route'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondRoute()),
            );
          },
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
```

<img src="..\images\2023-01-03-(flutter)Study_Week5\image-20230103210518208.png" alt="image-20221218182751993" style="zoom:80%;" />                               <img src="..\images\2023-01-03-(flutter)Study_Week5\image-20230103210613309.png" alt="image-20221218182751993" style="zoom:80%;" />

<br>

## 페이지 간에 데이터 넘겨주는 법

**앞서 페이지 이동을 배웠다면, 페이지 이동을 할 때 데이터도 같이 주고 받는 방법을 알아보자.**

앞서 `Navigator.push` 메소드에서 사용한 `MaterialPageRoute`에 인자로 데이터를 넘겨주면 된다.

```dart
// Within the `FirstRoute` widget
onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SecondRoute(data)),
  );
}
```



만약 `Navigator.pop` 메소드를 통해서 이전 페이지로 돌아올때도 데이터를 넘겨줄 수 있다.

```dart
Navigator.pop(context, reData);
```



**또한 이 데이터를 받을때도 매우 중요하다.**

* 비동기를 이용해서 SecondPage -> FirstPage로 보내는 데이터를 기다리고, 코드가 진행되어야 한다.
  * 따라서 비동기 함수인 `async`를 사용해주고, 데이터 기다려 줄 부분에 `await`을 함께 사용한다.

```dart
onPressed: () async {
          final reData = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SecondPage(data)
              )
          );
          if( reData != null ){
            print("SecondPage에서 받은 데이터 : $reData");
          }
        },
```

<br>

## 외부의 리소스 가져오는 방법

**여러가지 방법들이 존재한다.**

* file: 외부의 폴더나 갤러리에 있는 파일을 사용하는 경우
* asset: 앱을 만들 때 미리 넣어놓은 파일을 사용하는 경우
* memory: 배열이나 문자열 형태의 이미지 데이터를 사용하는 경우
* **보통의 방법인 assets 방법을 알아보겠다.**



### 이미지의 경우

우선 프로젝트 부분에 image라는 폴더를 생성해서 원하는 이미지를 넣어서 보관한다.

다음으로 `pubspec.yaml` 파일에 이미지 정보를 추가해준다.

```yaml
flutter:
	uses-material-design: true
	assets:
		- image/test.png
```



이미지를 `pubspec.yaml` 파일에 `asset`으로 선언해줬기 때문에 간단히 가져올 수 있다.

```dart
Image.asset('image/test.png')
```



### 폰트의 경우

우선 프로젝트 부분에 font라는 폴더를 생성해서 원하는 폰트를 넣어서 보관한다.

다음으로 `pubspec.yaml` 파일에 폰트 정보를 추가해준다.

```yaml
 fonts:
    - family: notosanscjkkr
      fonts:
        - asset: font/noto_sans_cjkkr_bold.otf
          weight: 400
```



폰트를 `pubspec.yaml` 파일에 `asset`으로 선언해줬기 때문에 간단히 가져올 수 있다.  

* 이름은 `notosanscjkkr` 로 등록하였기 때문에 아래 코드에서 해당 이름의 폰트를 가져오는 모습이 확인가능

```dart
const Text('Hello Flutter',
           style: TextStyle(fontFamily: 'notosanscjkkr',
                            fontSize: 30, color: Colors.blue),
          )
```

<br>

