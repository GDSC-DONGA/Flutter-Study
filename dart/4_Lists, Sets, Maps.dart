/**
collections 데이터 타입 : 데이터들이 모여 있는 묶음 타입 : Lists, Sets, Maps
**/

//List : 데이터 묶음
List<int> ages = [17, 18, 19, 20];
List<String> fruits = ['사과', '배', '포도'];

print(ages[0]); // 17
print(fruits.length); // 3

ages.add(21); // 리스트에 데이터 추가


//Sets : 순서없고 중복 존재 못하는 데이터 묶음
Set<String> names = {'snake', 'lion', 'human', 'lion'};
-> 중복 비허용이므로 {'snake', 'lion', 'human'}이 된다.
  
//Maps : key-value 쌍 데이터 타입
Map<String, String> model = {
  'id' : 'astar5327',
  'pass' : '1234'
  };

print(model['pass']); // 1234 (출력)
model['name'] = '민지훈'; // 데이터 추가

// dynamic 데이터 타입을 활용한 방법, value값으로 다양한 데이터타입을 담을 수 있다. List나 Map도 가능.
Map<String, dynamic> min = {
  'name' : '민지훈',
  'age' : 26,
  'gender' : 'Man',
  'fancy food' : ['hamburger', 'apple', 'orange']
  };
print(min['fancy food'][2]); // orange
