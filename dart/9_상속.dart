/**
자식 클래스는 부모 클래스의 멤버 변수와 메서드를 모두 상속받는다.
따라서 자식 클래스 인스턴스에서 바로 부모 클래스의 멤버 변수와 메서드를 사용할 수 있다.
선언된 위치만 부모 클래스에 있을 뿐, 자식 클래스 내에 존재하는 것처럼 사용할 수 있는 것이다.
**/

class Person {
  String? name;
  
  setName(String name) {
    this.name = name;
  }
  getName() {
    return name;
  }
  
  showInfo(){
    print('name is $name');
  }
}

class Student extends Person{
  int? studentID;
  
  @override // 기존 메서드를 재정의한다.(새로운 기능을 가지도록 만듬)
  showInfo() {
    print('name is ${super.getName()} and id is $studentID.'); // super로 부모 클래스의 메서드에 접근 가능. 사실 이미 상속 받은 상태라 생략해도 사용 가능
  }
}

main() {
  Student student = Student();
  student.studentID = 2020;
  student.setName('Min');
  student.showInfo();
}
// name is Min and id is 2020.

/**
상속은 코드 재사용으로 클래스 간소화와 수정 추가의 용의성 때문에 사용한다.
부모 클래스의 멤버들을 재선언 할 필요가 없고, 필요한 메서드도 재정의해서(override) 사용할 수 있다.
**/
