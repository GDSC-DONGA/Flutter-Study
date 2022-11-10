/**
클래스 구현 해놓고 생성자 생략하면 기본생성자가 자동으로 제공됨.
기본 생성자는 클래스명과 동일하면서 인자가 없고, 부모 클래스의 인수가 없는 생성자를 호출한다.**/

class Person {
  Person() {
    print('Person 생성자!');
  }
}

/**
부모 클래스는 자식 클래스에게 멤버를 물려주는(상속하는) 관계이다. extends 키워드로 어떤
클래스로부터 상속받을지 역할을 지정할 수 있다. **/

class Person {
  Person() {
    print('Person 생성자!');
  }
}

class Student extends Person{ //Student가 자식, Person이 부모.
  Student() {
    print('Student 생성자!');
}

main() {
  var student = Student();
}

/**
'기본 생성자는 클래스명과 동일하면서 인자가 없고, 부모 클래스의 인수가 없는 생성자를 호출한다.'
라고 했으므로, 위를 빌드하면 
Person 생성자!
Student 생성자!
순으로 출력되는 것을 확인할 수 있다.

다만 기본 생성자는 상속되는 것이 아니라 호출된 것 뿐이다.
기본 생성자는 상속되지 않는다.

이름 있는 생성자 : 클래스 내에 많은 생성자를 생성할 경우 관계를 명확히 하기 위해 사용한다.
**/
  

class Person {
  Person() {
    print('Person 생성자!');
  }
  
  Person.init() {
    print('Person.init 생성자!');
  }
}

class Student extends Person{ //Student가 자식, Person이 부모.
  Student() {
    print('Student 생성자!');
}

main() {
  var person = Person();
  var init = Person.init();
}
/**
Person 생성자!
Person.init 생성자!
**/

/**
다만 이름 없는 생성자는(기본 생성자) 단 하나만 가질 수 있고, 이름 있는 생성자 선언 시
기본 생성자는 생략할 수 없다는 점에 유의하자.

초기화 리스트 : 생성자 구현부 실행전에 멤버 변수를 초기화 할 수 있다.
**/
  
class Person {
  String name;
  
  Person() : name = 'Min' { // 콜론(:)으로 사용한다.
    print('Person 생성자, 이름은 $name');
  }
}
void main() {
  var person = Person();
}
  
  
// 리다이렉팅 생성자 : 본체가 비어있고 메인 생성자에게 위임(delegate)하는 역할을 한다.
class Person{
  String name;
  int age;
  
  Person(this.name, this.age) { 
    print('Person 생성자 $name, $age');  // 3. 출력 실행
  }
  
  Person.initName(String name) : this(name, 20); // 2. this는 현재 인스턴스이므로 멤버 변수로 Min, 20이 할당됨.  Person 생성자 호출
}

main() {
  var person = Person.initName("Min"); // 1. Person.initName 생성자로 전달
}

// 상수 생성자 : 해당 클래스가 변하지 않는 객체를 생성함. 대신 인스턴수 변수는 final을, 생성자는 const를 붙임
  
class Person{
  final String name;
  final num age;
  
  const Person(this.name, this.age);
}

main() {
  Person person1 = const Person('Min', 20); 
  Person person2 = const Person('Min', 20);
  Person person3 = Person('Min', 20);
  Person person4 = Person('Min', 20);
  
  print(identical(person1, person2)); // true
  print(identical(person2, person3)); // false
  print(identical(person3, person4)); // false
}
 // 상수 생성자는 동일한 인스턴스를 참조해서 서로 같고, person3,4는 새로운 인스턴스를 각각 생성했기에 다르다.
  
  
  
