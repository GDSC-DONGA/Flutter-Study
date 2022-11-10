/**
기본 자료형
**/
int a = 5; //정수형
double b = 0.01; //실수형
String str = '민지훈'; //문자열, 맨 앞이 대문자 S, 작은따옴표로 쓰는게 표준.
bool c = false; //참, 거짓 불리언

num n1 = 40;
num n2 = 23.12; //num은 int, double 혼합 타입
num n = a; //가능

// var : 타입 추론형 타입. 초기화 값에 따라 알아서 데이터 타입을 정해줌.
var a = 11;
var b = false;
var c = '민지훈';

// 상수 : final, const -> 한번 초기화 해놓으면 변경 불가능.

void main() {
  const int cnt = 20;
  cnt = 30; //error
  final String str = "민지훈";
  str = "김지훈"; //error
}


// !!대신 final, const는 var 타입과 같이 사용하면 안된다.!!
/**
final과 const의 차이
const int age;
age = 26; 처럼 값 최초 1회 부여 가능

final : 반드시 선언부에서 값을 부여해야만 함.
final int age = 26; (O)

final int age;
age = 26;(X)

const는 컴파일 시에 값이 결정됨.
final은 파일이 실행될 때(런타임 시) 해당 위치에서 값이 결정됨.

예시) 어떤 프로그램이 실행될 때 시간에 대한 로그를 남기고 싶으면
DateTime.now()를 사용한다.
**/
final log1 = DateTime.now(); // final은 실행 시에 시간이 결정되므로 사용 가능
const log2 = DateTime.now(); // 컴파일 시의 시간을 담으므로 활용도가 떨어짐.
//위는 둘의 차이를 구분하기 위한 예시일뿐이며, 상황에 따라 맞게 사용하면 된다.
