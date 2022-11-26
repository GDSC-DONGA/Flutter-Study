# Week 2
## 1. 인터페이스 (abstract class)
### 추상 클래스
-----
- Dart에는 abstract class라는 형식의 추상 클래스를 제공
- 동작을 구현하지 않은 기능을 정의하고, 상속을 받아 실제 동작에 대한 내용을 구현(재정의)
```
abstract class Coffee {                                                             // 추상클래스 Coffee
	int price = 0;
	int shot = 0;

	Coffee(this.shot) {
		price = shot * 1000;
	}

	void describe() {                                                               // 완전한 메소드인 describe
		print(price);
	}

	void description();                                                             // 불완전한 메소드인 description
}                                                                                   // 추상클래스에서는 완전한 메소드와 불완전한 메소드를 모두 선언할 수 있음

class Americano extends Coffee {                                                    // 추상클래스 Coffee를 상속받은 하위 클래스 Americano
	Americano(int shot) : super(shot);

	@override
	void description() {                                                            // 하위 클래스는 추상클래스의 불완전한 메소드를 완성시켜주어야함
		print("Americano는 에스프레소에 물을 타서 희석시킨 커피입니다.");
	}
}

void main() {
	var americano = new Americano(2);
	americano.describe();
	americano.description();
}
```

### 인터페이스
-----
- Interface를 이용하면 추상클래스에 선언된 모든 함수들을 재정의 하도록 규제할 수 있고, 상속에서 불가능했던 다중상속을 가능하게 할 수 있음
- 다른 언어에서는 Interface 키워드를 사용하거나 별도의 파일에 정의하여 상속받아 사용하지만 dart에서는 일반적인 class처럼 선언해서 사용함(Implicit interfaces)
- 상속 관계는 부모-자식의 계층관계를 만들어내지만, 인터페이스의 구현(implements)은 계층관계를 만들지 않음 → implements 개념을 사용하면 어떠한 기능의 틀을 만들어 두고 각각의 클래스가 이들을 상속받도록 할 수 있음
```
abstract class Ice {
	void addIce();                                                                  // 추상클래스 Ice는 불완전 함수 선언 가능
}

class BlackSugar {
	void addBlackSugar(){}                                                          // 일반 클래스 BlackSugar은 완전한 함수만 선언 가능
}

abstract class Coffee {
	int price = 0;
	int shot = 0;

	Coffee(this.shot) {
		price = shot * 1000;
	}

	void describe() {
		print("Price is $price.");
	}

	void description();
}

class Americano extends Coffee implements Ice, BlackSugar {                         // implements를 사용하여 Implicit interfaces를 사용할 수 있고, 일반 클래스도 implements가 가능
	Americano(int shot) : super(shot);

	@override
	void description() {
		print("Americano는 에스프레소에 물을 타서 희석시킨 커피입니다.");
	}

	@override
	void addIce() {
		this.price += 500;
	}

	@override                                                                       // 일반 클래스에서 구현한 내용은 상속받은 클래스에서 사용되지 않음 → 사용하기 위해서는 "상속"또는 "추상클래스"를 활용
	void addBlackSugar() {                                                          // implements를 사용하면 일반 메소드도 하위 클래스에 재정의해야함(추상 클래스를 implements 할 때도 똑같음)
		this.price += 300;
	}
}

void main() {
	var americano = new Americano(2);
	americano.description();
	americano.describe();
	
	americano.addIce();
	americano.describe();
	
	americano.addBlackSugar();
	americano.describe();
}
```
## 2. 확장 (Extension)
-----
- 확장 메소드를 만들면 IDE에서 일반 메소드와 같이 확장 메소드도 같이 제안
- 사용방법 : extension \<extension name> on \<type> { (\<member definition>)* }
```
extension StringExtension on String {
  String numberFormat() {
    final formatter = NumberFormat("#,###");
    return formatter.format(int.parse(this));
  }
}

print('5000'.numberFormat());
// 5,000

print('1000000'.numberFormat());
// 1,000,000
// String 객체 뒤에 . 을 표시하고 정의한 확장 메소드인 numberFormat() 함수를 사용
```
## 3. 제네릭
-----
- 매개변수의 인자 값이 타입
- TypeScript와 같이 해당 타입의 값만 넣을 수 있는 객체가 생성됨
- 코드를 중복으로 선언하지 않아도 된다는 이점이 있음
```
List<String> colors = List();                                                           // String타입의 값만 들어갈 수 있는 List
colors.add("Red");
```
- extends를 사용해서 특정 클래스를 지정하면 매개변수화 타입을 제한 할 수 있음 → 해당 특정 클래스와 그 클래스의 자식 클래스가 실제 타입 매개변수가 될 수 있음(다형성)
- 클래스 뿐만 아니라 메소드의 리턴타입, 매개변수를 제네릭으로 지정할 수 있음

## 4. 콜백 및 고차함수
- 함수의 매개변수에 콜백함수가 들어가는 것을 고차함수라고 함
- 고차함수의 매개변수에 들어가는 함수를 콜백함수라고 함
- 비동기처리와같이 순서가 보장되지 않는 경우, 순차적으로 작업을 실행시키기 위해서 사용
