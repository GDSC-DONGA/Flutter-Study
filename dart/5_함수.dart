/**
다트 함수의 특징
1. 변수가 함수 참조 가능
2. 다른 함수의 인자로 함수 전달 가능
3. 이름 있는 선택 매개변수
4. 위치적 선택 매개변수
5. 익명 함수 및 람다
**/


// 1. 변수가 함수 참조 가능
void main() {
  var name = getName();
  print(name); // Min출력
  
  int a = 10;
  int b = 5;
  print('$a + $b = ${add(a, b)}'); // 10 + 5 = 15
}

getName() {  // 함수의 리턴 타입, 매개 변수 타입을 지정하지 않아도 되지만 명시하는 것이 좋다.
  return "Min";
}

int add(int a, int b) {
  return a + b;
}

// 2. 다른 함수의 인자로 함수 전달 가능
int add(int a, int b) {
  return a + b;
}

int sub(int a, int b) {
  return a - b;
}

int multi(int a, int b) {
  return a * b;
}

main() {
  int a = 10;
  int b = 5;
  
  print('${a+b} * ${a-b} = ${multi(add(a, b), sub(a,b))}'); // 15 * 5 = 75
}

/** 3. 이름 있는 선택 매개변수 : 매개변수명으로 인자 값을 넘길 수 있다.
이때, 인자 값 넘겨줄 매개변수는 {}로 감싼다.

getAddress (String 매개변수명1, {String 매개변수명2, String 매개변수명3 }) {
}

예시 :
getAddress('seoul', {district : 'gangnam', code : '123'}) {
}
**/

String getAddress(String city, {String district = "", String zipCode = '1234'}){ // 각 값을 명시할 경우 인자값 수정 시도가 없으면 디폴트 값으로 처리됨. 
  return '$city시 $district구 $zipCode';
}

main() {
  print('${getAddress('서울', district: '강남')}'); // 서울시 강남구 1234
  print('${getAddress('부산', district: '동래', zipCode: '4567')}');  // 부산시 동래구 4567
  print('${getAddress(district: '강남', zipCode: '123456')}'); // error : 매개변수에 대한 인자값 누락
}


// 4. 위치적 선택 매개변수 : 미리 초깃값을 지정해놓고 호출할 때 인자 값을 안넘겨주면 그냥 초깃값 사용. {} 대신 [] 사용

String getAddress(String city, [String district = '강남', String zipCode = '1234']){
  return '$city시 $district구 $zipCode';
}

main() {
  print('${getAddress('서울')}'); // 서울시 강남구 1234
  print('${getAddress('서울', '서초')}'); // 서울시 서초구 1234
  print('${getAddress('서울', '0123')}');  // 서울시 0123구 1234  인자 값 줄 때 매개변수 위치를 반드시 고려할 것.
}

// 5. 익명 함수 및 람다식
int add(int a, int b){
  return a + b;
}

var multi = (_a, _b) {  // 익명 함수식
  return _a * _b;
}; // 세미콜론 주의

int sub(int _a, int _b) => _a - _b;  // 람다 함수식

main() {
  int a = 10;
  int b = 5;
  
  print('$a + $b = ${add(a,b)}'); // 10 + 5 = 15
  print('$a - $b = ${sub(a,b)}'); // 10 - 5 = 5
} 
