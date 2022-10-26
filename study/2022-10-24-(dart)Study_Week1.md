## Intro

`Fluter`를 본격적으로 들어가기 앞서 `Dart`언어를 공부합니다. 

`Dart`언어는 아래의 홈페이지에서 사용할 것이며, `Fluter` 공부 시작할때 **Fluter 개발 환경**을 본격적으로 진행 할 예정입니다.

* **[Dart](https://dartpad.dev/)**

<br>

## 0. Dart 언어란?

*  google이 javascript를 대체하기 위해 2011년에 개발한 **웹프로그래밍 언어**
* **C언어와 유사**한 특징



## 1. 데이터 타입

* `Numbers` (int, double, **num**)

  * **'num'** can have both int and double

  ```dart
  // num
  num x = 1; // 1(int)
  x = 1.5; // 1.5(double)
  
  // String -> int
  int.parse("1"); // "1" -> 1
  
  // int -> String
  1.toString(); // 1 -> "1"
  ```

* `Strings` (String)

  * one line : `'문자열'` or `"문자열"`
  * multi line : `'''문자열'''` or `"""문자열"""`

* `Booleans` (bool)

* `Lists` (List, also known as arrays)

  * List, Set, Map은 아래에서 자세히 정리
  
* `Sets` (Set)

* `Maps` (Map)

* `Runes` (Runes; often replaced by the characters API)

  ```dart
  // 유니코드 코드 포인터를 가져오는 정수
  const string = 'Dart';
  final runes = string.runes.toList();
  print(runes); // [68, 97, 114, 116]
  ```

* `Symbols` (Symbol)

  * Dart 프로그램 내에서 선언된 식별자나 연산자를 표현하는 데 쓰이는 자료형

* `The value null` (Null)

<br>

## 2. 변수와 연산자

### 변수

* `var` : 동적 타입 지정
  * 타입 상관없이 바로 초기화 : `var num = 0;`
  * 이후 다른 타입 입력 불가능 : `num = '가나';`
* `Dynamic` : 동적 타입 지정 + 타입 변경 가능
  * `num='가나';` 이 가능
* `Final/Const` : 상수형 타입
  * `Final` : 컴파일 시간에 값이 이미 지정되었어야 함
  * `Const` : 런타임에 값이 지정되어도 상관없음



### 연산자

* **산술 연산자**

  * `+, -, *, /, ~/, %, ++, --`
  * `~/` : 몫 연산자

* **할당 연산자**

  * `=, +=, -=, *=, /=, ~/= 등`

* **관계 연산자**

  * `==, !=, >, <, >=, <=`

* **비트 & 시프트 연산자**

  * `&, |, ^, ~, <<, >>`
  * `&, |, ^, ~` : AND, OR, XOR, NOT

* **타입 검사 연산자**

  * `as, is, is!`
  * `as` : 형 변환(상위 타입으로)
  * `is, is!` : 타입 같은지 여부 확인

* **조건 표현식**

  * `삼항연산자, ?, ??`
  * `?` : 좌항이 null이면 null을 리턴하고 아니면 우항의 값을 리턴
  * `??` : 좌항이 null이 아니면 좌항 값을 리턴하고 null이면 우항 값을 리턴

* **캐스케이드 표기법**

  * `..` : 매번 객체를 표기하는 불필요한 과정을 줄여줌

  ```dart
  Employee employee = Employee()
      ..name = 'Kim'
      ..setAge(25)
  ```

<br>

## 3. 반복문 및 조건문

### 반복문

* `for, while, do~while`
  * 사용방식 : C와 유사



### 조건문

* `if, if~else, switch`

* `assert` : 조건식이 거짓이면 error(debug mode에서만 동작)

  ```dart
  int a = 10;
  int b = 20;
  assert(a > b); // debug mode에서는 error
  ```

<br>

## 4. 배열(리스트)와 맵

* `List` : 중복 허용, 순서 있는 집합

  * `const [1,2,3] ` : 요소 변경 불가 가능(다른 타입들도 `const`사용 가능)
  * `spread operator` & `null-aware` 사용 가능

  ```dart
  // const [1,2,3]
  List list = const [1,2,3];
  list[0] = 2; // error
  
  // spread opreator
  List list = [1, 2, 3];
  List list2 = [0, ...list]; // [0,1,2,3]
  
  // null-aware
  List list = [];
  List list2 = [0, ...?list]; // [0]
  ```

* `Set` : 중복 허용X, 순서 없는 집합

  * **unique value** : `Set names = {1, 2, 3, 3}; // {1,2,3}` 
  * **type지정** : `Set<String> names = {};` 
  * **주의** : `var names = {};` Create a map, not a set

* `Map` : 요소들이 key-value 쌍인 집합

  * **key, value형태** : `Map names = {1:'a', 2:'b', 3:'c'};` 
  * **type지정** : `Map<int, String> names = {};`

<br>

## 5. 함수와 클래스, 클래스의 상속

* **Function(함수)**

  * **구조** : C처럼 사용하면 되고, 반환값 없을때는 C처럼 void로 한다.

  * JS처럼 `콜백함수, 고차함수` 지원(순서상관 없이 호출할 때 유용)
    * `콜백함수` : 고차함수의 매개변수 인자에 들어가게되는 함수
    * `고차함수` : 매개변수에 콜백함수를 넣어서 직접 사용하는 함수
  * JS처럼 `익명함수(화살표 함수 = 람다함수)`도 지원
    * 익명함수니까 보통 변수에 넣어서 사용
    * JS의 경우 해당 변수명으로 메모리 내부에서 익명함수가 이름을 가지게끔 동작

  ```dart
  // 일반 함수의 구조
  void main() {
      // return 없는 void 형태
  }
  
  // 익명함수
  var sum = (a, b) { return a+b; }; // sum(1,2); 로 호출 가능
  // 화살표 함수 = 람다함수
  var sum2 = (a, b) => a+b; // sum(1,2); 로 호출 가능
  ```

  * **파라미터**

    * **default parameter** : 매개변수의 기본값을 설정(=)

    * **optional parameter** : `[]` 를 사용해서 선택적으로 매개변수 사용이 가능

      ```dart
      int sum(int a=0, int b=0, [int c=0]) {}
      assert(sum(1,2));
      assert(sum(1,2,3));
      ```

    * **named parameter** : `{}` 를 사용해서 `name : value` 형태가 가능  
      또한, `optional parameter` 형태이기 때문에 선택적으로 매개변수 사용 가능

      ``` dart
      int sum({int a=0, int b=0, int c=0}) {}
      assert(sum(a : 1, b : 2));
      assert(sum(a : 1, b : 2, c : 3));
      assert(sum(b : 1, a : 2, c : 3)); // 순서 변경도 가능
      
      // 추가로 @required 속성(선택이 아닌 필수로 만들어주는 속성)
      int sum({int a=0, int b=0, @required int c=0}) {}
      assert(sum(a : 1, b : 2)); // 오류
      assert(sum(a : 1, b : 2, c : 3)); // 정상
      ```

* **Class(클래스)**

  * 클래스 사용법도 기존 언어들과 매우 유사

  ```dart
  // 기본 구조
  class 클래스명 {
      멤버 변수;
      멤버 함수();
  }
  
  main(){
      // 인스턴스 생성 및 접근법
      var 변수명 = new 클래스명();
      var 변수명 = 클래스명; // new 생략 가능
      변수명.멤버 변수;
      변수명.멤버 함수();
  }
  ```

* **Inheritance(상속)**

  * 부모 클래스를 자식 클래스가 상속 받아서 부모 클래스의 변수, 함수들을 자식 클래스가 사용가능

  * `extends` 키워드로 상속 선언
  * `@override` 키워드로 오버라이딩 선언
