/**
프로그램 개발하다가 런타임 중(애플리케이션 실행 중) null 참조 에러가 많이 발생한다.
null safety는 이 문제를 코드가 실행되기 전 컴파일러가 해당 버그를 잡아줌으로써
예상치 못한 상황에 대비할 수 있게 해준다.

기존의 nullable 타입의 문제점
모든 자료형은 Object의 상속을 받고, 동시에 Null 클래스의 부모 클래스였다.
int 자료형에 null을 대입한다면 int 클래스에 Null 클래스의 인스턴스를 대입한 것이고 당연히
Null 클래스에서는 아무런 메서드가 정의되지 않았기 때문에 NoSuchMethodError라는 런타임 에러를 호출했다.
이러한 코드는 컴파일 상 문제가 없기 때문에 실행은 됐었으나,
dart를 사용하는 flutter는 사용자들과 직접적으로 소통해야 했기 때문에 non-nullable 타입으로
문제를 해결할 수 있었다.

null-safety에서는 Null 클래스가 다른 자료형과 완전히 분리가 되었다.
따라서 모든 자료형은 기본적으로 null을 허용하지 않는 자료형이 되었다.

그러나 null 자체는 굉장히 중요한 자료형이기 때문에 자료형 뒤에 ?을 붙이는 방법으로
기존 자료형에 null을 할당할 수 있도록 허용하였다.
이제 int에 null을 할당하는 것은 불가능하지만, int? 에 null을 할당하는 것은 가능해졌다.

// null safety 적용 이후
**/
requireNonNullableVariable(int nonNullableVar){
    print(nonNullableVar);
}
main(){
    int? nullabaleVar = null; // 정수형이나 null을 대입해도 무방
    int a = null; // 컴파일 에러!!
    int? b = 23; // 
    requireNonNullableVariable(nullableVar); // 컴파일 에러!!
}

/**
앞서 말했듯, null safety가 적용된 지금의 상황에서 변수를 초기화 하지 않으면 에러가 난다.
초기화 하지 않을 경우 컴파일러가 해당 변수가 사용가능하다는 것을 보증해줄 수 없기 떄문이다.
**/
int topLevel = 0; 
class SomeClass{
    static int staticVar = 1; 
    // 초기화 하지 않아도 됨(이경우 생성자 진입전 초기화 필요)
    int initializingFormal;
    int initializationList;
    // 생성자에서는 생성자 body 진입 전 초기화를 끝내야 한다.
    SomeClass(this.initializingFormal)
        : initializationList = 0;
    
    int someFunc(int para){
        // 예외적으로 지역 변수의 경우는 해당 변수를 사용하기 전에만 초기화하면 된다. 메서드 내부의 변수를 지역변수라고 한다.
        int result;
        result = 3;
        return result;
    }
}

// late 연산자
class Developer{
  String _techStack;
  void frontend() => _techStack = "flutter";
  void backend() => _techStack = "Spring";
  void devOps() => _techStack = "aws";
  String introduce() => "I'm using "+_techStack;
}
// 위의 코드는 컴파일 에러가 발생한다.
/**
생성자를 사용하지 않는 한 non-nullable인 인스턴스 변수 String _techStack은
변수 생성시 초기화 해야만 한다.
변수를 String? 타입으로 지정해도 좋지만 null을 활용하지 않는 예정인 코드에서는 late 연산자를 사용하여
초기화를 늦추는 방법을 사용해도 좋다.

**/
String _techStack; -> lagte String _techStack;
/**
결론적으로 late는 초기화를 늦추지만 null을 허용하지 않늗다.
또한 코드 작성시 초기화전에 해당 변수를 사용한다면 에러가 발생한다.
**/


// null check 방법 4가지

void main() {
  // 1
  String ? str;
  str = null;
  
  print(str); 
  
  // 2
  if (str == null) {
    print("empty");
  } else{
    print(str);
  }
  
  // 3
  print(str == null ? "empty" : str);
  
  // 4
  print(str ?? "empty");  // ?? 연산자 : 변수가 null이면 뒤의 값으로 대채.
  

/** 이름있는 매개변수 named parameter
Non- nullable 타입의 매개변수가 포함된 함수를 선언하려면 어떻게 해야하나?
함수 호출 쪽에서 매개변수를 입력하지 안흥면 null이 들어가므로 컴파일 에러가 난다.

해결법 1 : 매개변수의 초기값을 설정해줌. null이 들어가지 않기 위함.
해결법 2 ; required 키워드를 붙여서 함수를 호출할 때 입력을 강제할 수 있다.

required를 쓰면 매개변수가 여러개 있는 함수를 호출할 때 반드시 그 매개변수에 대한 인자값을 입력하도록 강제한다.
**/
int addThree({
  required int first,
  required int second,
  required int third,
}) {
  return firs + second + third;
}

void main() {
  final sum = addThree(
    first: 2,
    second: 5,
    third: 3,
    );
  print(sum); // 10
}
 
// 클래스 변수 초기화를 위한 선택적 매개변수에 대한 예시
class Person
{
  String name;
  int ? birth;
  int money;
  
  Person({required this.name, // this.name = ""도 가능
          this.birth,
          this.money = 0}); // 생성자 초기화
}
void main() {
  Person p1 = Person(name: "홍길동");
  print(p1.name);   // 홍길동
  print(p1.birth ?? "알 수 없음");  // 알 수 없음
  print(p1.money);   // 0
}

