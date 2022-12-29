# Week 4
## 1. 자주 쓰는 위젯 알아보기
### SafeArea
-----
- 자식 위젯에 패딩을 넣어서 디바이스 영역이 앱의 위젯 영역을 침범하는 것을 막음
- Scaffold → body 다음에 위치
    ```
    return Scaffold(
        body: SafeArea(
        )
    )
    ```
- Safearea 있는 경우와 없는 경우 차이<br/>
    ![noSafeArea](https://user-images.githubusercontent.com/111935711/209932428-088f74cb-20e9-4342-b78f-5b8e11059605.png)
    ![safeArea](https://user-images.githubusercontent.com/111935711/209932435-365decc1-dbf3-4cac-9771-0a1f91250f1a.png)<br/>

    (사진출처 : https://all-dev-kang.tistory.com/entry/%ED%94%8C%EB%9F%AC%ED%84%B0-SafeArea-%EC%97%90-%EB%8C%80%ED%95%B4%EC%84%9C)

### Scaffold
-----
- 기본적인 material design의 시각적인 레이아웃 구조를 실행
- 디자인의 구조를 정해주는 만큼 앱 전반적인 디자인에 대한 다양한 속성들이 존재
- MaterialApp이 앱으로서 기능을 할 수 있도록 해주는 뼈대라면 Scaffold은 구성된 앱에서 디자인적인 부분에서의 뼈대
- 주로 서랍, 스낵바, 하단 시트, 플로팅 버튼등을 보여줄때 사용
```
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
      ),
      bottomNavigationBar: BottomAppBar(
      ),
      floatingActionButton: FloatingActionButton(
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
}
```

### Container
-----
- Container는 한 개의 자식을 갖는 레이아웃 위젯
- Container의 생성자
    ```
    Container({
        Key key,
        this.alignment,
        this.padding,
        Color color,
        Decoration decoration,
        this.foregroundDecoration,
        double width,
        double height,
        BoxConstraints constraints,
        this.margin,
        this.transform,
        this.child,
    })
    ```
- 예시<br/>
    ![container](https://user-images.githubusercontent.com/111935711/209934143-0bc840ff-0c02-4881-a103-af7ca74806cd.png)
    ```
    body: Container(
          width: 300,
          height: 300,
          padding: EdgeInsets.all(50),
          margin: EdgeInsets.all(50),
          decoration: BoxDecoration(
            color: Colors.cyanAccent,
            borderRadius: BorderRadius.all(
              Radius.circular(70),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[600],
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
            border: Border.all(
              color: Colors.black,
              width: 3,
            ),
          ),
          child: Text(
            "컨테이너",
            style: TextStyle(fontSize: 50),
          ),
        ),
    ```
    (예시 출처 : https://ahang.tistory.com/10)
### ListView
-----
- 가장 일반적으로 사용되는 스크롤 위젯

- ListView를 생성하는 4가지 방법
    1. 일반적인 ListView를 명시적으로 호출하고 children 전달하는 방법 - 적은 데이터에 사용시 용이
        ```
        return ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
                HeaderTile(),
                PersonTile(people[0]),
                PersonTile(people[1]),
                PersonTile(people[2]),
                PersonTile(people[3]),
                PersonTile(people[4]),
                PersonTile(people[5]),
            ],
        );
        ```
    2. ListView.builder builder를 사용하여 동적으로 호출 - 많은 양의 데이터 리스트에 용이함 index사용가능 
        ```
        return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: people.length + 1,
            itemBuilder: (BuildContext context, int index) {
                if (index == 0) return HeaderTile();
                return PersonTile(people[index-1]);
            },
        );
        ```
    3. ListView.separated는 2번에 구분선 사용 가능 
        ```
        return ListView.separated(
            itemCount: people.length + 1,
            itemBuilder: (context, index) {
            if (index == 0) return HeaderTile();
            return PersonTile(people[index - 1]);
            },
            separatorBuilder: (context, index) {
            if (index == 0) return SizedBox.shrink();
            return const Divider();
            },
        );
        ```
    4. ListView.custom

    (예시 출처 : https://greedy0110.tistory.com/42)
### Padding
-----
- child widget에 Padding을 가지도록 하는 Widget
- padding의 생성자
    ```
    Padding({
        Key key,
        @required this.padding,
        Widget child,
    })
    ```
### TextButton, IconButton
-----
- TextButton은 글자가 있는 버튼
- TextButton 테두리가 보이지 않아서, 다른 내용과 섞이지 않도록 주의해서 배치
    ```
    TextButton(
        onPressed: () {},                  //@required
        onLongPress: () {},
        focusNode:,
        autofocus: true,
        clipBehavior: Clip.none,
        style: ButtonStyle(),
        child: Widget(),                   //@required
    )
    ```
- IconButton은 아이콘이 있는 버튼

### Text
-----
- Text를 출력하는 기본 위젯
    ```
    Text('텍스트')
    ```
### TextField
-----
- Text를 입력받는 기본 위젯
- decration 파라미터에 InputDecoration을 사용하여 여러가지 설정을 할 수 있음
    ```
    TextField(
    decoration: InputDecoration(
        labelText: 'Input',
    ),
    )
    ```
### Column, Row
-----
- Column은 세로, Row는 가로 방향으로 배치하는 위젯
    ```
    body: Row(Column) (
    ),
    ```
### Image, Icon
-----
- 모바일 앱에서 작은 화면에 다양한 형태의 이미지나 아이콘을 표시
- 가장 단순하게 이미지를 불러오는 방법은 Image.asset()메서드를 호출
- 이미지는 파일 입출력을 동반하기 때문에 다양한 방법으로 이미지를 불러올 수 있음
- Icon 위젯 안에 아이콘을 넣어서 표출할 수 있음
    ```
    Icons.<아이콘 이름>
    ```
### CircularProgressIndicator
-----
- 앱 진행상황을 나타낼 때 가장 많이 사용되는 위젯
- 원형(Circular)과 선형(Linear) 2가지 Indicator 를 주로 사용(사용 방법은 거의 동일)
- Determinate
  - 특정한 값을 갖는 것
  - CircularProgressIndicator의 value 속성을 활용
- Indeterminate
  - value값을 특정하지 않아서, 진행률이 얼마나 되는지 표시하지 않음
### SizedBox
-----
- SizedBox의 두 가지 목적
  - child widget의 size를 강제하기 위해
  - Row, Column에서 widget 사이에 빈 공간을 넣기 위해
```
 const SizedBox({ Key key, this.width,this.height, Widget child })
```
- 추가) SizedBox와 Containor의 차이
  - Container는 width와 height가 없으면 크기가 확장되지만, SizedBox는 child 위젯 크기에 딱 맞게 설정됨
  - SizedBox는 color 속성이 없어서 색상을 입힐 수 없음

### Stack
-----
- Row나 Column으로 표현할 수 없는 겹쳐있는 모양의 위젯을 표현할 때 사용
- Row(Column)와 Stack의 차이<br/>
![Column](https://user-images.githubusercontent.com/111935711/209939143-ad46d29f-f079-4f08-ad56-fe7f53e23d89.jpg)
![Stack](https://user-images.githubusercontent.com/111935711/209939149-2bc2fb24-c30e-4e3c-a5f9-3138ea84b25c.jpg)

### AppBar
-----
- 앱의 상단 제목 줄을 의미
- leading과 actions는 icon을, title은 text를 flexibleSpace는 appBar의 크기를 조절할때, bottom은 appBar의 탭바(아래쪽에 화면을 이용)등에 쓰임<br/>
![Appbar](https://user-images.githubusercontent.com/111935711/209939567-43d387f5-14d6-4f25-8294-01ea12e9f112.png)
### BottomNavigationBar
-----
- 화면 하단에 Navigation 기능을 하는 영역
- required(필수로 넣어야 하는) 속성은 items 하나 - List< BottomNavigationBarItem> 형태의 배열을 넣어줌
    ```
    bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        // type: BottomNavigationBarType.fixed,
        // selectedItemColor: Colors.amber[800],
        // unselectedItemColor: Colors.blue,
        // backgroundColor: Colors.black,
      ),
    ```
    (참고 : https://velog.io/@sharveka_11/BottomNavigationBar)
### Divider
-----
- 구분선 위젯
- 가로 구분선
    ```
    const Divider({
        Key? key,
        this.height,
        this.thickness,
        this.indent,
        this.endIndent,
        this.color,
    })
    ```
- 세로 구분선
    ```
    const VerticalDivider({
        Key? key,
        this.width,
        this.thickness,
        this.indent,
        this.endIndent,
        this.color,
    })
    ```
### PageView
-----
- 여러 페이지를 한 화면에서 처리할 수 있게 해주는 위젯
- 한 화면에서 여러 페이지를 책처럼 넘겨볼 수 있도록 구현할 수 있음
- 예제 코드
    ```
    PageView(
    // 페이지 목록
    children: [
        // 첫 번째 페이지
        SizedBox.expand(
        child: Container(
            color: Colors.red,
            child: Center(
            child: Text(
                'Page index : 0',
                style: TextStyle(fontSize: 20),
            ),
            ),
        ),
        ),
        // 두 번째 페이지
        SizedBox.expand(
        child: Container(
            color: Colors.yellow,
            child: Center(
            child: Text(
                'Page index : 1',
                style: TextStyle(fontSize: 20),
            ),
            ),
        ),
        ),
        // 세 번째 페이지
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
        // 네 번째 페이지
        SizedBox.expand(
        child: Container(
            color: Colors.blue,
            child: Center(
            child: Text(
                'Page index : 3',
                style: TextStyle(fontSize: 20),
            ),
            ),
        ),
        )
    ],
    )
    ```
- PageController : 페이지 전환을 트리거
    ```
    final PageController pageController = PageController(
        initialPage: 0,
    );

    PageView(
        controller: pageController, // PageController 연결
        children: ...
    )
    ```
### ListTile
-----
- 높이가 고정된 1개의 행. 텍스트나 아이콘 등을 포함
- 텍스트는 3줄까지 가능하고, 체크박스나 더보기 같은 아이콘을 넣을 수 있음(아이콘들은 leading, trailing 속성에다 설정)
- 텍스트는 Title, subtitle 속성에 설정
- 3줄까지 텍스트를 쓰려면 isThreeLine 을 true로 주면 됨
- dense 속성을 true로 주면 해당 ListTile의 높이와 내부 텍스트 크기까지 줄어들게 됨<br/>
![listTile](https://user-images.githubusercontent.com/111935711/209941203-0a1713f2-26c7-4010-8681-1376b904875a.png)<br/>
(사진출처 : https://velog.io/@sharveka_11/Flutter-4.-ListTile)

## 2. 자주 쓰지는 않지만 알아야 하는 위젯 알아보기
### MaterialApp
-----
- Material Design을 사용할 수 있게 해주는 클래스
### SingleChildScrollView
-----
- 나열하는 위젯이 많아져서 스크린에 다 나오지 못할 때 스크린을 스크롤 가능하게 해주는 위젯
- 사용하고자 하는 위젯의 최상위 Class를 SingleChildScrollView로 감싸주면 됨
### AspectRatio
-----
- 자식 위젯을 특정한 비율로 만드는 클래스
- 비율은 분수, 소수로 표현 가능
