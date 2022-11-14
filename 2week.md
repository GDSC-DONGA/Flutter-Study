OOP - Object Oriented Programing 객체지향 프로그래밍 // clase를 사용한 프로그래밍
```dart
class Test{} == class Test extends Object{} // 모든 클래스는 오브젝트를 상속(생락 가능)
```
Class를 만들었을 때(변수와 함수를 정의) -> Instance 생성(결과물 도출)
```dart
void main(){
  Drink cola = Drink();
  
  print(cola.name);
  print(cola.group);
  cola.sayName();
  cola.sayGroup();
}

class Drink{
  String name = '콜라'; // 변수
  List<String> group = ['코카콜라', '닥터페퍼', '펩시']; // 변수
  
  void sayName(){ // 함수
    print('콜라종류 입니다.'); 
  }
  void sayGroup(){ // 함수
    print('종류는 코카콜라, 닥터페퍼, 펩시 입니다.');
  }
}
```
```
콜라
[코카콜라, 닥터페퍼, 펩시]
콜라종류 입니다.
종류는 코카콜라, 닥터페퍼, 펩시 입니다.
```
constructor
```dart
void main(){
  Drink cola = Drink( // 생성자에서 받을 값을 지정
    '콜라',
    ['코카콜라', '닥터페퍼', '펩시']
  );
  
  print(cola.name);
  print(cola.group);
  cola.sayName();
  cola.sayGroup();
}

class Drink{
  String name; // 지정해뒀던 값을 지울 수 있음
  List<String> group; // 외부에서 값을 받기 때문
  
  // Drink();  constructor
  Drink(String name, List<String> group)
    : this.name = name,
      this.group = group;
  
  void sayName(){
    print('콜라종류 입니다.'); 
  }
  void sayGroup(){
    print('종류는 코카콜라, 닥터페퍼, 펩시 입니다.');
  }
}
```
```
콜라
[코카콜라, 닥터페퍼, 펩시]
콜라종류 입니다.
종류는 코카콜라, 닥터페퍼, 펩시 입니다.
```
multi instance
```dart
void main(){
  Drink cola = Drink(
    '콜라',
    ['코카콜라', '닥터페퍼', '펩시']
  );
  
  print(cola.name);
  print(cola.group);
  cola.sayName();
  cola.sayGroup();
  
  Drink cidar = Drink(
    '사이다',
    ['칠성', '스프라이트', '킨']
  );
  
  print(cidar.name);
  print(cidar.group);
  cidar.sayName();
  cidar.sayGroup();
}

class Drink{
  String name;
  List<String> group;
  
  // Drink();  constructor
  Drink(String name, List<String> group)
    : this.name = name,
      this.group = group;
  
  void sayName(){
    print('${this.name}종류 입니다.');  // 인스턴스에 따른 출력 변경
  }
  void sayGroup(){
    print('종류는 ${this.group} 입니다.'); // 인스턴스에 따른 출력 변경
  }
}
```
```
콜라
[코카콜라, 닥터페퍼, 펩시]
콜라종류 입니다.
종류는 [코카콜라, 닥터페퍼, 펩시] 입니다.
사이다
[칠성, 스프라이트, 킨]
사이다종류 입니다.
종류는 [칠성, 스프라이트, 킨] 입니다.
```
문장을 더 간결하게
```dart
class Drink{
  String name;
  List<String> group;
  
  Drink(String name, List<String> group)
    : this.name = name,
      this.group = group;
		↓
  Drink(this.name, this.group);
  // 클래스의 값을 바로 받아서 넣음(타입 자동 유추)
```
named constructor // parameter를 받는 또 다른 방법
```c
void main(){
  Drink cola = Drink(
    '콜라',
    ['코카콜라', '닥터페퍼', '펩시']
  );
  
  print(cola.name);
  print(cola.group);
  cola.sayName();
  cola.sayGroup();
  
  Drink cidar = Drink.fromList(
    [
      ['칠성', '스프라이트', '킨'],
      '사이다'
    ]
  );
  
  print(cidar.name);
  print(cidar.group);
  cidar.sayName();
  cidar.sayGroup();
}

class Drink{
  String name;
  List<String> group;
  
  Drink(this.name, this.group);
  
  Drink.fromList(List valuse)
    : this.group = valuse[0],
      this.name = valuse[1];
  
  void sayName(){
    print('${this.name}종류 입니다.'); 
  }
  void sayGroup(){
    print('종류는 ${this.group} 입니다.');
  }
}
```
immutable programing
```dart
void main(){
  Drink cola = const Drink( // 빌드타임의 값을 알 수 있을 때 const 선언
    '콜라',
    ['코카콜라', '닥터페퍼', '펩시']
  );
  // cola.name = '콜라다';(불가) → 바꾸지 못하게 하여 버그 방지
  print(cola.name);
  print(cola.group);
  cola.sayName();
  cola.sayGroup();
  
  Drink cidar = Drink.fromList(
    [
      ['칠성', '스프라이트', '킨'],
      '사이다'
    ]
  );
  
  print(cidar.name);
  print(cidar.group);
  cidar.sayName();
  cidar.sayGroup();
}

class Drink{
  final String name; // 인스턴스를 만들 때 final이 선언된다.
  final List<String> group;
  
  const Drink(this.name, this.group); // const를 이용한 값 변경 방지
  
  Drink.fromList(List valuse)
    : this.group = valuse[0],
      this.name = valuse[1];
  
  void sayName(){ // 함수
    print('${this.name}종류 입니다.'); 
  }
  void sayGroup(){ // 함수
    print('종류는 ${this.group} 입니다.');
  }
}
```
const 활용(값이 같을 때 동일 인스턴스로 확인)
```dart
//const 미사용
void main(){
  Drink cola =  Drink(
    '콜라',
    ['코카콜라', '닥터페퍼', '펩시']
  );
  Drink cola2 =  Drink(
    '콜라',
    ['코카콜라', '닥터페퍼', '펩시']
  );
  print(cola==cola2); // false
}

class Drink{
  final String name;
  final List<String> group;
  
  const Drink(this.name, this.group);
}
```
```dart
//const 사용
void main(){
  Drink cola =  c  onst Drink(
    '콜라',
    ['코카콜라', '닥터페퍼', '펩시']
  );
  Drink cola2 =  const Drink(
    '콜라',
    ['코카콜라', '닥터페퍼', '펩시']
  );
  print(cola==cola2); // true
}

class Drink{
  final String name;
  final List<String> group;
  
  const Drink(this.name, this.group);
}
```
getter/setter
// 데이터를 가져올 때/데이터를 설정할 때
```dart
void main(){
  Drink cola = Drink(
    '콜라',
    ['코카콜라', '닥터페퍼', '펩시']
  );

  
  Drink cidar = Drink.fromList(
    [
      ['칠성', '스프라이트', '킨'],
      '사이다'
    ]
  );  
  //getter
  print(cola.firstGroup);
  print(cidar.firstGroup);
  //setter
  cola.firstGroup = '근본제로';
  cidar.firstGroup = '사이다별로';
  print(cola.firstGroup);
  print(cidar.firstGroup);
  //기능은 같음, 함수는 로직이 많이 들어갈 때 사용
  print(cola.getFirstGroup());
}

class Drink{
  String name;
  List<String> group;
  
  Drink(this.name, this.group);
  
  Drink.fromList(List valuse)
    : this.group = valuse[0],
      this.name = valuse[1];
  
  void sayName(){
    print('${this.name}종류 입니다.'); 
  }
  void sayGroup(){
    print('종류는 ${this.group} 입니다.');
  }
  //getter, 간단한 데이터 가공 시 사용
  String get firstGroup{
    return this.group[0];
  }
  // setter, 파라미터에 무조건 하나만 들어감
  set firstGroup(String name){
    this.group[0] = name;
  }
  //기능은 같음, 함수는 로직이 많이 들어갈 때 사용
  String getFirstGroup(){
    return this.group[0];
  }
}
```
List 는 final 을 사용해도 값 변경 가능
setter에서 파라미터를 List로 받아서 바꾸는건 불가능
```dart
set firstGroup(List<String> group){ //불가
    this.group = group;
  }
```
Private
// 외부파일에서 사용할 수 없는 데이터(같은 파일 내에서만 사용 가능)
```dart
void main(){
  _Drink cola = _Drink(
    '콜라',
    ['코카콜라', '닥터페퍼', '펩시']
  );

  
  _Drink cidar = _Drink.fromList(
    [
      ['칠성', '스프라이트', '킨'],
      '사이다'
    ]
  );  
}

class _Drink{ // 언더스코어를 사용해 프라이빗 클래스로
  String name;
  List<String> group;
  
  _Drink(this.name, this.group);
  
  _Drink.fromList(List valuse)
    : this.group = valuse[0],
      this.name = valuse[1];
  
  void sayName(){
    print('${this.name}종류 입니다.'); 
  }
  void sayGroup(){
    print('종류는 ${this.group} 입니다.');
  }
}  
```
Inheritance
//상속 받으면 부모 클래스의 모든 속성을 자식 클래스가 부여받는다.
```dart
void main(){
  Cola coke = Cola(name: '코카콜라', groupCount:5);
  coke.sayName();
  coke.sayGroupCount();
  
  Coke edition = Coke('한정판', 7); //상속받음
  edition.sayName();
  edition.sayGroupCount();
  edition.sayZero(); //coke.sayZero(); 사용불가
  
  DrPeper mutation = DrPeper('이단아', 2);
  mutation.sayName();
  mutation.sayGroupCount();
  mutation.sayMutant(); // 선언된 클래스 내에서만 사용 가능
  
  //Type Comparison
  print(coke is Cola);
  print(coke is Coke); // 자식클래스가 될 수는 없음
  print(coke is DrPeper);
  
  print(edition is Cola); // 자식클래스는 부모클래스도 될 수 있음
  print(edition is Coke);
  print(edition is DrPeper); // 자식클래스 간 상관관계 없음
}

class Cola{
  String name;
  int groupCount;
  Cola({
    required this.name, // Named Parameter
    required this.groupCount,
  });
  void sayName(){
    print('이것은 ${this.name}입니다.');
  }
  void sayGroupCount(){
    print('${this.name}은 ${this.groupCount}개가 있습니다.');
  }
}

class Coke extends Cola{ // class 자식클래스 extends 부모클래스)
  Coke(
  String name,
  int groupCount,
  ): super( // Cola class의 Constructor
        name: name,
        groupCount: groupCount,
      );
  void sayZero(){ // 자식클래스에서 만든 함수는 부모클래스에서 사용 못함
    print('저는 제로칼로리 입니다.');
  }
}

class DrPeper extends Cola{
  DrPeper(
  String name,
  int groupCount,
  ): super(
        name: name,
        groupCount: groupCount,
  );
  void sayMutant(){ // 자식클래스에서 만든 함수는 다른 자식클래스에서 사용 불가
    print('저는 이단아입니다.');
  }
}
```
```
이것은 코카콜라입니다.
코카콜라은 5개가 있습니다.

이것은 한정판입니다.
한정판은 7개가 있습니다.
저는 제로칼로리 입니다.

이것은 이단아입니다.
이단아은 2개가 있습니다.
저는 이단아입니다.

true
false
false

true
true
false
```
Override
```dart
void main(){
  TimesTwo tt = TimesTwo(2);
  print(tt.calculate());
  
  TimesFour tf = TimesFour(2);
  print(tf.calculate());
}

// method - function (class 내부에 있는 함수)
// override - 덮어쓰다 (우선시하다)
class TimesTwo{
  final int number;
  TimesTwo(
    this.number,
  );
  //method
  int calculate(){
    return number * 2; // class 내에만 number가 있을 시 this.number에서 this 생략 가능
  }
}

class TimesFour extends TimesTwo{
  TimesFour(
    int number,
  ): super(number);
  
  @override // 부모클래스의 함수를 자식클래스에서 덮어쓰기 가능
  int calculate(){
    return super.number * 4; // super(정석) 대신 this 도 사용 가능(생략도 가능)
    // return super.calculate() * 2; -> 부모클래스의 메소드를 살린 방법
    	// 이 때는 this 사용 불가(부모클래스가 아닌 자식클래스의 함수를 사용해 무한히 반복)
  }
}
```
Static // instance에 귀속되지 않고 class에 귀속
```dart
void main() {
  //instance 귀속
  Employee yoojung = Employee('유정');
  Employee minjung = Employee('민정');
  
  yoojung.printNameAndBuilding();
  minjung.printNameAndBuilding();
  //class 귀속
  Employee.building = '롯데타워';
  Employee.printBildng();
  
  yoojung.printNameAndBuilding();
  minjung.printNameAndBuilding();
}

class Employee{
  static String? building;
  final String name;
  
  Employee(
    this.name
  );
  
  void printNameAndBuilding(){
    print('제이름은 $name입니다. $building 건물에서 근무하고 있습니다.');
  }
  
  static void printBildng(){
    print('저는 $building 건물에서 근무중입니다.');
  }
}
```
```
제이름은 유정입니다. null 건물에서 근무하고 있습니다.
제이름은 민정입니다. null 건물에서 근무하고 있습니다.
저는 롯데타워 건물에서 근무중입니다.
제이름은 유정입니다. 롯데타워 건물에서 근무하고 있습니다.
제이름은 민정입니다. 롯데타워 건물에서 근무하고 있습니다.
```
Interface // 특수한 구조를 강제하기 위해 사용, instance화 하지 않음(abstract 이용)
```dart
void main(){
  CokeGroup coca = CokeGroup('코카');
  LotteGroup pepsi = LotteGroup('펩시');
  
  coca.sayName();
  pepsi.sayName();
}

abstract class ColaInterface {
  String name;
  
  ColaInterface(this.name);

  void sayName(){}
}

class CokeGroup implements ColaInterface{
  String name;
  CokeGroup(this.name);
  void sayName(){
    print('이것은 $name입니다.');
  }
}
class LotteGroup implements ColaInterface{
  String name;
  LotteGroup(this.name);
  void sayName(){
    print('이것은 $name입니다.');
  }
}
```
Generic // 타입을 외부에서 받을 때 사용
```dart
void main(){
  Lecture<String, String> lecture1 = Lecture('123', 'lecture1');
  lecture1.printIdType();
  
  Lecture<int, String> lecture2 = Lecture(123, 'lecrure2');
  lecture2.printIdType();
}

class Lecture<Type1, Type2>{
  final Type1 id; // id 값의 타입을 외부에서 Lecture를 instance로 만들 때 선언 가능
  final Type2 name;
  
  Lecture(this.id, this.name);
  
  void printIdType(){
    print(id.runtimeType);
  }
}
```
