## Intro

- 플러터의 상태란? (StatelessWidget vs StatefulWidget)
- 플러터에서는 어떻게 상태 관리를 하는가 (setState())

**참고URL : [상태관리](https://velog.io/@redforest/%ED%94%8C%EB%9F%AC%ED%84%B0%EC%9D%98-%EC%83%81%ED%83%9C%EA%B4%80%EB%A6%AC), [setState](https://terry1213.github.io/flutter/flutter-statefulwidget-setState/)**

<br>

## StatelessWidget vs StatefulWidget

**StatelessWidget은 고정된 형태로 한번 그려지고 나면 변화가(화면에) 없는 위젯   **

**StatefulWidget은 내부에 오는 데이터가 바뀔때마다 다시 그려질(화면에) 수 있는 위젯**



### setState

`StatefulWidget`을 사용하면 `setState` 함수로 데이터 변경에 따라 화면(UI)를 동적으로 변경시킬 수 있다.

**보통 `stful` 을 입력후 엔터를 하면 아래 코드가 자동 생성 된다.**

```dart
class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

* 이 코드가 `StatefulWidget` 사용하는 기본 뼈대라고 생각하면 된다.



**이번엔 `setState`를 활용해 보자.**

```dart
class _MyWidgetState extends State<MyWidget> {
  int _counter = 0;
    
  @override
  Widget build(BuildContext context) {
	return Scaffold(
      appBar: AppBar(
        title: Text('StatefulWidget Example'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text(
            '현재 숫자: $_counter',
          ),
           setState(() { // setState() 추가 => 핵심
              _counter++;
           });
        ),
      ),
    );
  }
}
```

* 버튼을 눌렀을때 화면에 숫자가 올라가는 예제인데, 여기서 `_counter` 변수를 우선 선언해주고,
* 다음으로 버튼 클릭 이벤트때 `_counter++` 을 하는데 이때 `setState` 함수를 사용한 덕분에
* 화면의 UI가 동적으로 바뀔 수 있는것이다.

<br>

## 플러터의 상태관리

**보통 데이터 전달 구조**

![image-20230107171751550](..\images\2023-01-07-(flutter)Study_Week6\image-20230107171751550.png)



**Bloc 상태관리 사용한 데이터 전달 구조**

![img](..\images\2023-01-07-(flutter)Study_Week6\image.png)



**이 뿐만아니라 Redux, GetX, Provider 등등 다양한 방법이 있다.**
