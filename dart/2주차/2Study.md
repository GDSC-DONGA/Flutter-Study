# Getter & Setter
의도하지 않은 곳에서 접근해 값을 변경하는 일을 방지하기 위해 클래스 내부 정보를 은닉하는 방식을 캡슐화라고 한다.
특정 멤버 변수에 접근할 수 있는 특별한 기능을 하는 메서드를 Getter, Setter메서드라고 한다.
Getter는 멤버 변수 값을 가져오는 역할을, Setter는 값을 쓰는 역할을 한다.

```dart
class Person {
  String? _name;
  String? get name => _name;   
  set name(String? name) => _name = name;
}
/* 여기서 name은 멤버변수에 접근할 때 사용할 이름이다. name이라는 이름으로 _name에 접근할 수 있는 것이다.*/

main() {
  Person person = Person();
  person.name = 'Kim';
  print(person.name);
}
```
> Kim


# 인터페이스
dart에서는 인터페이스를 class로 선언해 사용한다.
구헌 클래스에서 인터페이스를 implements 하면된다.
```dart
class WorldInterface {
  String? name;
  void sayName(){}
}

class Korea implements WorldInterface{
  String? name;
  Korea(
    String? name,
  ):this.name= name;
  
  void sayName(){
    print('이 나라의 이름은 ${this.name}입니다.');
  }
}

class Usa implements WorldInterface {
  String? name;
  
  Usa(
    String? name,
  ):this.name = name;
  
  void sayName(){
    print('이 나라의 이름은 ${this.name}입니다.');
  }
}

void main() {
  Korea korea = Korea('한국');
  korea.sayName();
  Usa usa = Usa('미국');
  usa.sayName();
}
```
> 이 나라의 이름은 한국입니다.<br>
> 이 나라의 이름은 미국입니다.


abstarct라는 이름으로 추상클래스를 먼저 선언하고 implements를 통해 인터페이스를 구현하는 방법도 가능하다.
```dart
abstract class Person {
  final String? name;
  Person(this.name);
  String sex();
  String age();
  String eat() => '$name eats nothing';
  String say() => '$name says nothing';
}

class John implements Person {
  @override
  String? get name => 'John';
  
  @override
  String sex() => '$name is male';
  
  @override
  String age() => '$name is 20';
  
  @override
  String eat() => '$name eats pizza';
  
  @override
  String say() => '$name says something';
}

main() {
  John john = John();
  print(john.sex());
  print(john.age());
  print(john.eat());
  print(john.say());
}
```
> John is male<br>
> John is 20<br>
> John eats pizza<br>
> John says something<br>

implements가 사용되면 Person의 모든 변수와 함수가 의무적으로 재정의되어야 한다.

# 상속
extends를 통해 상속을 하는 경우에는 의무적으로 재정의해야하는 것은 추상 함수뿐이다.
```dart
abstract class Person {
  final String? name;
  Person(this.name);
  String sex(); /*추상함수*/
  String age(); /*추상함수*/
  String eat() => '$name eats nothing';
  String say() => '$name says nothing';
}

class Jane extends Person {
  Jane(String name) : super(name);
  
  @override
  String sex() => '$name is female';
  
  @override
  String age() => '$name is 21';
}
```
나머지 함수들은 필요한 경우에 선택적으로 재정의 할 수 있다.

```dart
abstract class Person {
  final String? name;
  Person(this.name);
  String sex();
  String age();
  String eat() => '$name eats nothing';
  String say() => '$name says nothing';
}

abstract class Male extends Person {
  Male(String name) : super(name);
  
  @override
  String sex() => '$name is a male';
}

class Mike extends Male {
  Mike(String name) : super(name);
  
  @override
  String age() => '$name is 22';
  
  @override
  String eat() => '$name eats burger';
}

main() {
  Mike mike = Mike('mike');
  print(mike.age());
  print(mike.eat());
  print(mike.sex());
  print(mike.say());
}
```
> mike is 22<br>
> mike eats burger<br>
> mike is a male<br>
> mike says nothing<br>

위처럼 여러 단계의 상속이 필요한 경우 implements가 아니라 extends를 활용하면 된다. mike클래스는 male을 상속하면서 자연스럽게 Person까지 상속받게 되는 것이다.


# Extension 확장

효율적인 구조를 위해 사용. 코드 가독성에 도움을 줌.

Extension 사용 안할 경우
```dart
class UserIdValidation {
  static bool isValidLength(String str) {
    return str.length >= 7 ? true : false;
  }
}

void main() {
  print(UserIdValidation.isValidLength("vkdfaofjaf"));
  print(UserIdValidation.isValidLength("vkdfaf"));
}
```
> true
> false

Extension 사용할 경우
```dart
extension UserIdValidation on String {
  bool get isValidLength {
    return this.length >= 7 ? true : false;
  }
}

void main() {
  print("doifajdfa".isValidLength);
  print("faioe".isValidLength);
}
```

예시 : 두 단어 합치기
```dart
extension StringExtension on String {
  String concatWithSpace(String other) {
    return '$this $other';  /* 인자로 받는 String과 extend 하는 String은 $ 키워드로 참조해 구분함.
  }
}

void main() {
  print("XimYa".concatWithSpace("Kim"));
}
```
> XimYa Kim


# Generic
List, Set, Map과 같은 컬렉션에서는 <>을 사용하는데 이 부분에 타입 매개변수를 지정한다.
이것을 매개변수화 타입을 정의한다고 한다.

타입 매개변수는 클래스 생성 시 생성자에서 사용하거나 함수 호출 시 인자로 타입을 전달하기 위해 사용한다.
```dart
List<String> colors = List();
colors.add('Red');
```
해당 List에는 String타입만 넣을 수 있다.
이런식으로 매개변수에 값을 넘겨주듯이 타입을 넘겨줄 수 있는 것이 제네릭의 핵심이다.
이렇게하면 코드를 중복으로 선언할 필요가 없게된다. 단 하나의 코드로 다양한 타입에 대한 커버가 가능하기 때문이다.

```dart
void main() {
  List list = [];
  
  void result() {
    int sum = 0;
    list.forEach((element) {
      sum += element;
    });
    print(sum);
  }
  
  list.add(1);
  list.add(2);
  list.add(3);
  
  list.addAll([5, 6, 7]);
  list.add("value");
  result();
}
```
> Error: A value of type 'num' can't be assigned to a variable of type 'int'.
> sum += element;
위와같은 에러가 발생한다. 정수 사이에 value라는 문자열 값을 넣어놓고는 int형 변수 sum에다가 더하려고 했기 때문이다.



다음과 같이 타입 매개변수 자리에 dynamic을 넣는 경우 어떠한 자료형이든 들어갈 수 있다.

```dart
void main() {
  List<dynamic> number = new List();
  
  number.add(2);
  number.add('test');
  number.add(7.4);
  number.add(addNumber(3, 4));
  number.add(true);
  print(number); // [2, test, 7.4, 7, true]
}
```
그러나 제네닉 타입은 가급적 var키워드나 dynamic 키워드를 사용하지말고, 구체적인 타입으로 지정해서 사용하는 것이 바람직하다.

```dart
void main() {
  List<String> names = List();
  
  // addAll 함수를 사용하면 다양한 요소를 추가할 수 있다
  names.addAll(['James', 'John', 'Tom']);
  print(names); 
}
```


# 고차함수(콜백함수)

다트는 객체지향 언어이므로 함수 자체로도 객체이며 Function이라는 형식을 가진다.
그렇기에 함수를 값으로 전달하거나 할당역시 가능하다. 이를 고차함수(콜백함수)라고 한다.

## 일급 객체
다른 객체들에 일반적으로 적용가능한 연산을 모두 지원하는 객체.

조건
1. 변수에 대입 가능.
2. 다른 함수에 인자로 전달 받음.
3. 다른 함수의 결과로서 반환될 수 있음.
4. int, bool, String, Object, 그리고 함수가 이에 해당됨.

일급 객체로서 함수 사용 예시 -> 콜백 함수 정의 및 전달법
```dart
import 'dart:math';

class MyWidget {
  // 콜백함수 대입 받는 변수 선언
  final int Function(int, int) callback;
  
  // 생성자로 콜백함수 대입
  MyWidget({required this.callback});
  
  int run() {
    var rng = Random();
    // 호출 받은 함수에서 콜백함수 호출.
    return callback(rng.nextInt(100), rng.nextInt(100));
  }
}

int sum(int a, int b) {
  return a + b;
}

void main() {
  // 생성자로 콜백함수 넘겨주기
  var w = MyWidget(callback: sum); // sum() 콜백 함수 정
  print('My Widget Result: ${w.run()}');  // My Widget Result: 23
}
```
위 예시 코드을 간단히 설명하면 아래와 같다.

1. sum() 콜백 함수를 정의한다.
2. MyWidget 클래스에 콜백함수를 대입 받는 변수를 final 반환데이터타입<br> Function(매개변수목록) 변수; 형식으로 선언한다.
3. MyWidget 인스턴스를 생성할 때 생성자로 sum 콜백 함수를 함수 이름(포인터)으로 전달한다. (괄호를 붙이지 않음)
4. 플러터에서는 위젯에서 이벤트를 전달하고 위젯에서 이벤트가 발생하면 변경된 상태값을 들어올리는(lift) 데 주로 활용되는 기법이다.

