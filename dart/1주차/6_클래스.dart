/**
다트는 모든 것이 객체인 완전 객체 지향 언어.
모든 객체는 클래스의 인스턴스이다.
모든 클래스는 Object 클래스의 자식이다.

클래스는 멤버 함수(메서드), 멤버 변수(인스턴스 변수)로 구성됨.
클래스를 사용하려면 객체를 생성해야 한다. 그렇게 하면 메모리에 올라가고, 이를 인스턴스화라고 부른다.
이렇게 메모리에 클래스가 할당되어 인스턴스가 된 것을 객체라고 한다.

클래스 내부 함수를 메서드라고 하고, 클래스 외부에서 하나의 기능을 하는 함수는 Function이라 한다.
멤버 변수는 객체가 생성되면 인스턴스 변수라고 한다.
**/

class Person{
  late String name; // 멤버 변수. late에 대해서는 추후 기술 예정.
  getName() {   // 멤버 함수(메서드)
    return name;
  }
}

main() {
  var student = new Person(); 
  var teacher = Person(); // 플러터에서는 기본적으로 new 생략함.
  Person person = Person(); // 자바에서 객체 생성 형태
  student.name = 'Kim';
  teacher.name = 'Min';
  print('${student.getName()}');
  print('${teacher.getName()}');
  print('${person.getName()}');
}
