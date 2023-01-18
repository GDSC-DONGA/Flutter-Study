## Intro..

**플러터 스터디 8주차 토이 프로젝트 진행..**

* `TMDB` 사이트에 영화 데이터 사용(API)
* `NLP` - **BOW(Bag of Words)의 TF-IDF 기반의 벡터화**를 사용(추천 알고리즘)
  * BOW의 피처 벡터화는 `CountVectorizer, TF-IDF 기반의 벡터화` 가 존재하는데,
  * 문장의 양이 많은 경우 일반적으로 `TF-IDF 기반의 벡터화` 를 사용
    * 불용어를 많이 제거해주기 때문



**간단히 하다보니 구현 PASS 한 부분들**

* **DB를 따로 사용안함**
  * 영화 데이터를 가져와서 DB에 기록을 해둬야 자유롭게 데이터를 사용할 수 있음
  * 또한, 영화를 찜 하였으면 DB에 기록을 해둬야 앱을 종료해도 기억을 할 수 있음
    * 이 문제로 인해 찜은 정말 단순히 변수에 기록해서 주고받는 수준으로 구현
  * **해결방안?**
    * 물론 `firebase or sqlite` 등등 해결가능인데 PASS!!
    * 시간 부족,, => 어차피 사용해봤으니까 그냥 PASS했음
* **NLP로 구한 데이터를 DB를 사용하지 않아서 기록 못하고, 자동화(CI/CD)도 아님**
  * `DB, CI/CD`가 있었다면? (`firebase, git-action` 가정) 
    * `git-action`으로 `cron`을 사용해서 하루에 한번씩 `(예)추천 알고리즘 동작.py` 을 돌림
    * 이 파일은 `firebase`에 저장된 찜 데이터를 가져와서 알고리즘 동작 후에
    * 얻은 추천 영화 정보들을 `firebase` 에 저장
    * 프론트는 그저 `firebase` 에서 이 추천 데이터들을 가져와서 출력이 전부
  * 그러나 임시로 한 방식은?
    * 영화 4개를 임시로 골라서 찜 4개 했다고 가정 후 `(예)추천 알고리즘 동작.py` 을 코랩에서 돌림
    * 각각 5개씩 추천 받는다고 가정하고, 5*4=20개의 추천 데이터를 사용
    * 프론트에 직접 이 20개 데이터를 변수에 선언해서 가져다 사용중
  * **해결방안?**
    * `firebase` or `sqlite` 와 `git-action` 등등 해결가능인데 PASS!!
    * 시간 부족,, => 어차피 사용해봤으니까 그냥 PASS했음
* **코드 리팩토링 안해서 코드가 매우 난해**

<br>

## Run APP

<img src="..\..\images\ToyProject\image-20230118024248332.png" alt="image-20221218182751993" style="zoom:80%;" />



<img src="..\..\images\ToyProject\image-20230118024650026.png" alt="image-20221218182751993" style="zoom:80%;" />



<img src="..\..\images\ToyProject\image-20230118024801174.png" alt="image-20221218182751993" style="zoom:80%;" />



<img src="..\..\images\ToyProject\image-20230118024729403.png" alt="image-20221218182751993" style="zoom:80%;" />



<img src="..\..\images\ToyProject\image-20230118024947566.png" alt="image-20221218182751993" style="zoom:80%;" />

<br>

## 구현과정

* **UI구성**
  * 메인화면 1개 + 영화 정보 화면 1개 + My 찜 화면 1개 + 검색 화면 1개
  * 총 4개 screen 필요
* **검색 기능**
  * 검색 데이터를 입력받으면 이를 이용해서 `search`하는 `api`를 호출해서 데이터 가져온다.
  * DB가 있었다면 DB에 저장된 데이터들에다가 검색을 하였을 것이다.
* **찜 기능**
  * 하트를 클릭 시 색이 변하며 내부 변수에 해당 영화 `id` 를 기록한다.
  * 이를 MY 찜 에서 볼 수 있게 한다. 물론, 종료시 사라짐(DB를 사용안해서)
* **추천 알고리즘 기능**
  * `NLP` - **BOW(Bag of Words)의 TF-IDF 기반의 벡터화**를 사용한다.
  * 여기서 텍스트 정보는 줄거리 정보를 사용한다.
  * `TMDB 5000 영화정보.csv` 사용 하였고, 옛날 자료인게 아쉬운 점
  * 그래도 **줄거리기반 Kaggle-TDBM관련 추천알고리즘 인기 게시글**의 정보이다.

<br>

## 참고 skill

* `fromMap` 함수는 map 데이터 구조를 초기화하는 생성자 메서드이다.
* `statefulwidget` 은 `stful`을 치고 엔터를 누르면 구조를 자동으로 적어준다.
  * 여기서 구조가 class가 2개 생성되는것을 확인
  * 이를 이용해 `setState` 활용
* `http` 라이브러리 버전마다 사용 함수 다르므로 잘 확인
  * 보통 `Future` 타입과 `async, await` 사용 필수

* `flutter_dotenv` 라이브러리 통해서 `.env` 파일 사용
* `coulmne, row` 위젯은 배경색 지정을 못함 => `container` 등등 자식으로 줘서 색 지정
* `flex` 같이 비율에 맞게 1:1, 1:3 등등 형태로 자리 차지하기 위해서는??
  * `expanded` 위젯 사용
  * 다만, `singlechildscrollview`와 함께 사용시 `expnaded`가 부모로 와야 에러 발생 X

* 현재 화면크기를 통해서 거기에 맞게 너비, 높이 계산하는 방식도 추천!
  * 화면너비 예시 : `final deviceWidth = MediaQuery.of(context).size.width;`

* 참고로 플러터 버전이 올라가면서 `버튼 위젯`도 바뀜
* `fluttertoast` 라이브러리 통해서 메시지 출력하려고 했는데 아래 에러가 발생
  * 에러 : `Flutter fluttertoast don't support null safety`
  * 해결법 : `flutter run --no-sound-null-safety` 를 터미널에 입력

* 위젯의 위치를 `절대적위치`로 주는 방식은 `Stack` 위젯에 `Positioned` 위젯을 사용
* 정말 간단하게 위젯을 반복 나열하거나, 간단한 조건문을 줄때 간단한 방식이 존재
  * childeren의 [] 내부에 if, for문 사용 가능
  * child: 바로 뒤에 삼항연산자 사용 가능

* `textfiled` + `GestureDetector` 까지 같이 사용 추천
  * 또한, `TextEditingController` 사용해서 `textfiled` 의 텍스트 추출


<br>

## NLP

**자세한 설명은 생략**

* **[(NLP)Movie Recommendation System.ipynb](https://colab.research.google.com/drive/1R4qTWTLci82sG1r7Z9YS6fCK_toFHbnH?usp=sharing)**

* **파일로도 프로젝트에 올려놨음**

<br>

## Folder Structure

* **[`./lib/main.dart`](./lib/main.dart)**
  * 위젯 형태 : `MaterialApp -> MainRoute`
  * `dotenv` 를 여기서 로드하였음
* **[`./lib/screens/main_screens.dart`](./lib/screens/main_screens.dart)**
  * 맨 처음 앱 구동시 로딩화면과 메인 화면을 담당
  * 위젯 형태 : `메인의 첫 그림 부분 위젯, 인기순위 영화 목록 나열한 위젯, 사용자 맞춤 추천 콘텐츠 위젯`
  * **[`./lib/screens/detail_screens.dart`](./lib/screens/detail_screens.dart)**
    * 영화의 정보를 나타내는 화면을 담당
  * **[`./lib/screens/heart_screens.dart`](./lib/screens/heart_screens.dart)**
    * 영화 찜 목록들을 나타내는 화면을 담당
  * **[`./lib/screens/search_screens.dart`](./lib/screens/search_screens.dart)**
    * 영화 검색을 나타내는 화면을 담당
* **[`./lib/providers/movie_providers.dart`](./lib/providers/movie_providers.dart)**
  * `TMDB API` 호출을 통해 데이터 수집하는 파일


* **`./assets/config/.env`**
  * `.gitignore` 에 해당 파일 추가했기 때문에 깃에 올라가지 않음
  * `API KEY`를 기록해 두었음

* **[`./pubspec.yaml`](./pubspec.yaml)**

  * `dependencies` 을 아래와 같이 주었다.

    ```yaml
    http: ^0.13.5
    flutter_dotenv: ^5.0.2
    fluttertoast: ^8.0.0
    ```

  * `assets` 를 아래와 같이 주었다.

    ```yaml
    assets:
    	- assets/config/.env
    ```

* **[`./colab/(NLP)Movie_Recommendation_System.ipynb`](./colab/(NLP)Movie_Recommendation_System.ipynb)**

  * `NLP` 를 사용해서 추천 데이터를 얻게 하는 코드
  * **[`./colab/tmdb_5000_movies.csv`](./colab/tmdb_5000_movies.csv)**
    * `TMDB 5000` 의 영화 데이터셋

<br>

## 참고 문서

* **[http api 호출](https://cholol.tistory.com/568)**
* **[참고한 UI](https://m.blog.naver.com/PostView.naver?isHttpsRedirect=true&blogId=ejunglestory&logNo=221977815351)**
* **[NLP 참고 Kaggle](https://www.kaggle.com/code/ibtesama/getting-started-with-a-movie-recommendation-system)**