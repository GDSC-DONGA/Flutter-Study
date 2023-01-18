## Intro

- 외부 라이브러리를 현재 프로젝트에 등록하는 방법 알아보기
- 외부 라이브러리의 공식 문서를 읽고, 라이브러리 사용하는 방법 알아보기
- 비동기가 무엇인지 알아보기 (Future)
- `shared_preference`
  - 로컬에 데이터를 저장하는 라이브러리
- `http`
  - HTTP 요청을 보낼 수 있게 해주는 라이브러리
  - 응답을 받아서, 이를 쉽고 정확하게 사용할 수 있도록 가공하는 방법 알아보기 (객체 등으로 파싱)
    - 이 과정을 거치지 않으면, 해당 응답 JSON이나 XML에 들어있는 값의 타입을 확실히 알지 못하기 때문에, 이것이 비지니스 로직에 섞이게 되면 예상치 못한 에러를 발생시킬 수 있습니다.
- 플러터에서 어떻게 비동기를 처리할지 알아보기.
  - 위의 가장 흔한 경우는, 서버에서 데이터를 받아와야 화면을 보여줄 수 있는 상황입니다.
  - 인스타그램을 생각해보면, 우리가 앱에 접속했을 때 그 수많은 이미지와 텍스트가 모두 로딩이 되어야 화면이 정상적으로 보여질 수 있을 것입니다. 따라서, 당장 유저에게 보일 화면에 필요한 모든 데이터를 불러오기 전까지 보여줄 화면을 어떻게 구성할지, 또 데이터를 불러왔을 때 어떻게 데이터를 레이아웃에 맞게, 효율적으로 보여줄지를 고민해보아야 합니다.
  - **일반적으로는 setState와 Future#then을 섞어서 많이 사용합니다.**

<br>

## 외부 라이브러리 등록, 사용 방법

`pubspec.yaml` 파일에 `dependencies:` 부분이 있는데 이곳에 외부 라이브러리를 등록한다.

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^0.13.5
```

* `http` 를 등록한 방법
* 이때, 자동으로 다운되거나 다운받는 액션이 뜨면 다운하면 된다.



[http](https://pub.dev/packages/http) 이곳 사이트에서 라이브러리 사용법을 볼 수 있다.

* 사용법은 아래에서 정리하겠다.

<br>

## 동기와 비동기

**동기 : 모든 동작을 차례대로 수행**

**비동기 : 어떤 동작이 완료가 되지 않아도 다음 동작을 수행**

**비동기 처리를 위해 존재하는 것이 `Future` 이다.**



### 동기식 then

```dart
Future<Int> createData() {
    return readMemory().then((id){
        return readData(id);
    }).then((data){
        return data;
    })
}
```

* 이런식으로 동기는 `.then` 을 이용해서 차례로 수행을 할텐데 매우 난잡해 보인다.



### 비동기식 async / await

```dart
Future<Int> createData() async {
    final id = await readMemory();
    final data = await readData(id);
    return data;
}
```

* 비동기 방법중에서 유명한 `async/await` 방식이며, 한눈에봐도 코드가 간결해진걸 알 수 있다.

* 코드에서 동기처럼 사용할 부분에 `await` 키워드를 사용하면 동기처럼 동작한다.
* 또한 `await` 키워드는 `async` 함수 안에서 사용해야 하므로 `async`를 붙여준다.
* 마지막으로 반환 타입은 `Future` 이므로 꼭 `Future` 타입을 사용해준다.

<br>

## http

* `Uri uri = Uri.parse(url주소)` 를 하고나서
* `http.get(uri)` 를 해서 통신한다.
  * 이전 버전에서는 `parse` 함수 사용이 아니였음
  * 따라서 꼭 문서를 보고 최신 문법이 바뀌었나 잘 확인이 필요
* 데이터를 담을 수 있게 뼈대 역할을 할 객체 모델을 잘 만들어 두는것이 중요하다.
  * 데이터 가공하라는 뜻



**아래는 예시 코드입니다.**

```dart
Future<List<Movie>> getMovie() async {
    List<Movie> movie = [];

    final response = await http.get(uri);

    if (response.statusCode == 200) {
        movie = jsonDecode(response.body)['results'].map<Movie>((result){return Movie.fromMap(result);}).toList();
    }

    return movie;
}
```

<br>

## 응용(Future, async/await, then, setState)

**보통 이 방식들을 활용해서 비동기 처리를 한다.**

**예시를 보여주겠다.**

```dart
class _MainWidgetState extends State<MainRoute> {
  List<Movie> movie = [];

  MovieProvider movieProvider = MovieProvider();

  Future initMovie() async {
    movie = await movieProvider.getMovie();
    ...
  }

  @override
  void initState() {
    super.initState();
    print('데이터 로딩 시작');
    initMovie().then((_) {
      print('데이터 로딩 완료');
      setState(...);
    });
  }
...
```

* `Future...` 부분은 `async/await`을 활용해서 데이터를 차례로 가져오는 코드이다.
* `@override` 아래 부분은 앱 구동시 실행될텐데 이때 위에서 `Future...` 부분 만든 함수를 사용한다.
  * `.then` 을 이때 또 이용해서 동기적으로 진행해서 아래 `setState` 함수에 변경된 값을 잘 넣을 수 있는것이다.
