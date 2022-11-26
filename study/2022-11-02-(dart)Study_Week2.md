## Intro

`Fluter`를 본격적으로 들어가기 앞서 `Dart`언어를 공부합니다. 

`Dart`언어는 아래의 홈페이지에서 사용할 것이며, `Fluter` 공부 시작할때 **Fluter 개발 환경**을 본격적으로 진행 할 예정입니다.

* **[Dart](https://dartpad.dev/)**

<br>

## 1. 인터페이스 (abstract class)

* **인터페이스** :  구현된 것은 아무 것도 없는 밑그림만 있는 설계도(abstract, interface)
* 즉, `class`가 꼭 선언해야하는 `메소드, 변수`를 지정해주는 역할을 한다



### Abstract classes(추상 클래스)

**추상 클래스 자체로 instance(객체)화는 불가**

* 보통 상속 받아 implement(구현)해서 사용
* `abstract`를 `class`앞에 붙여 사용



### Abstract methods(추상 메소드)

* **추상 메소드**는 추상 클래스내에서 작성 가능

* **body(함수 몸체)**가 없음

```dart
abstract class Test {
  void doSomething(); // body X
}

class Test2 extends Test { // 상속받아서 구현(implement)
  void doSomething() {
    print("test");
  }
}

void main() {
  var test = Test2(); // instance(객체) 생성
  test.doSomething(); // test 출력
}
```



###  Implicit interfaces(암시적 인터페이스)

**다른 언어는 Interface 키워드를 사용하는 편인데, dart에서는 class로 바로 사용**

* 인터페이스는 body(몸체)에 기능을 정의해주지 않으면 된다
* 이 클래스를 상속받는 자식 클래스에서는 `extends` 키워드 대신 `implements` 키워드를 사용하면 된다.

```dart
class TestInterface {
  // 함수안에 기능 정의 X
  void doSomething(){}
}

class Test2 implements TestInterface {
  String str="";
  Test2(String str){ // 생성자
    this.str = str;
  }
  void doSomething() { // implements
    print(this.str);
  }
}

void main() {
  var test = Test2("test");
  test.doSomething(); // test 출력
}
```

<br>

## 2. 확장 (Extension)

**보통 IDE에서 코드 작성할때 자동 완성으로 여러 함수들이 뜨는걸 본 경험이 있을텐데,  
일반 함수, 확장 함수 둘 다 제안을 한다**

* **형태** : `extension <extension name> on <type> { (<member definition>)* }`

* `string_apis.dart` 에 정의되어 있는 확장함수 사용 예시

```dart
// Extension Fun
extension NumberParsing on String {
  int parseInt() {
    return int.parse(this);
  }
  // ···
}

// Use extension fun & normal fun
import 'string_apis.dart';
...
print('42'.padLeft(5)); // Use a String method.
print('42'.parseInt()); // Use an extension method.
```

<br>

## 3. 제네릭(Generic)

**제네릭은 클래스나 메소드에서 사용할 내부 데이터 타입을 컴파일 시에 미리 지정하는 방법**

* 장점 : 타입을 넘겨줌으로써 코드 중복을 줄여준다.
* 제네릭 구조 예시

```dart
// dart의 List 클래스 구조
abstract class List<E> implements EfficientLengthlterable<E> {
    void add(E value);
}

List<int> numbers = List();
numbers.add(1);
```

* 만약 일반적인 경우? 
* 각각 타입들마다 오버로딩을 해야한다.

```dart
class List {
    void add(String value);
    void add(int value);
	// 등등 ... 
}
```

<br>

## 4. 콜백 및 고차함수

**콜백함수는 다른 함수의 인자로써 이용되는 함수이며, 어떤 이벤트에 의해 호출되어지는 함수로 볼 수도 있다.**

* **사용하는 이유**
  * 어떤 함수가 호출되고 순차적으로 다음 작업을 실행해야 할 때 사용한다.
  * 비동기 처리나, 이벤트리스너 같은 경우는 순서를 보장해 주지 않기 때문에 콜백함수가 필요한 상황이 생긴다.

* **콜백함수** : 고차함수의 매개변수 인자에 들어가게되는 함수
* **고차함수** : 매개변수에 콜백함수를 넣어서 직접 사용하는 함수



**정말 간략하게만 소개**

```dart
int callFun(val, func) { // 고차함수
  return func(10, val);
}
int add(a,b) { // 콜백함수
  return a+b;
}
int sub(a,b) {
  return a-b;
}

void main() {
  print(callFun(20, add)); // 30
  print(callFun(5, sub)); // 5
}
```