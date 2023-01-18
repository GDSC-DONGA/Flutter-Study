import 'package:flutter/material.dart';
import 'package:flutter_study_toyproject/providers/movie_providers.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_study_toyproject/screens/detail_screens.dart';
import 'package:flutter_study_toyproject/screens/heart_screens.dart';
import 'package:flutter_study_toyproject/screens/search_screens.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MainRoute extends StatefulWidget {
  const MainRoute({super.key});

  @override
  State<MainRoute> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainRoute> {
  List<dynamic> movie = [];
  List<dynamic> movieRecommend = [];
  int isLoading = 0; // 처음 초기값은 매번 0
  
  List<String> sid = [];
  List<int> heartCheck = List<int>.filled(20, 0);
  // => sid, heartCheck 는 DB연동할때 그때 초기값을 가질것. 지금은 0으로

  MovieProvider movieProvider = MovieProvider();

  // 추천 영화(DB 사용안하므로 NLP로 구한것 직접 선언)
  // Avengers: Age of Ultron, Iron Man, Avatar, The Avengers 를 입력했을때 추천결과
  List<String> movieRecommendName = ['The Avengers', 'Iron Man 2', 'Iron Man', 'Captain America: Civil War', 'Knight and Day', 'Iron Man 2', 'Iron Man 3', 'Cradle 2 the Grave', 'Avengers: Age of Ultron', 'Hostage', 'Apollo 18', 'The American', 'The Matrix', 'The Inhabited Island', 'Tears of the Sun', 'Avengers: Age of Ultron', 'Plastic', 'Timecop', 'This Thing of Ours', 'Thank You for Smoking'];


  Future initMovie() async {
    movie = await movieProvider.getMovie();
    for(int i= 0 ; i<20; i++){ // 당연히 실제론 DB를 활용(여기선 임의로)
      movieRecommend.add(await movieProvider.searchMovieOne(movieRecommendName[i]));
    }
    // print(movieRecommend);
  }

  @override
  void initState() { // 위젯 생성될때 생성자 다음으로 바로 호출되는 함수
    super.initState();
    print('데이터 로딩 시작');
    initMovie().then((_) {
      print('데이터 로딩 완료');
      setState(() {
        isLoading = 1; // 로딩 완료시 1
      });
    });
  }

  @override
  void pageMove(List<dynamic> movie, {int index=-1}) {
    if(index!=-1){
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context)=>DetailRoute(movie[index]))
      );
    }
  }

  @override
  void sidFun(List<String> sid, dynamic movie, int index) {
    int count = 0;
    if(sid.length!=0) {
      for(int i = 0 ; i<sid.length; i++){
        if(sid[i] == movie['id'].toString()){
          setState(() {
            sid.remove(sid[i]);
            heartCheck[index] = 0;
          });
          count = 1;
        } 
      }
      if(count == 0) setState(() {
            sid.add(movie['id'].toString());
            heartCheck[index] = 1;
          });
    }else {
      setState(() {
        sid.add(movie['id'].toString());
        heartCheck[index] = 1;
      });
    }
    print(sid);
    print(heartCheck);
  }
  
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    if(isLoading == 1) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [

              // 0. 메인 첫 그림 부분 위젯
              Stack(children: [
                Container(
                  child : Image.network(dotenv.env['FLUTTER_APP_TMDB_KEY_BASEURL_IMG'].toString()+movie[0]['poster_path'].toString(), fit: BoxFit.fill,),
                  color: Colors.blue,
                  width: deviceWidth+10,
                  height: deviceHeight/1.5,
                ),
                Positioned(child: 
                  Container(child:
                    Row(children: [
                      Container(
                        child: ElevatedButton(
                          child: Text('검색',style: TextStyle(fontSize: 20,color: Colors.white),),
                          onPressed: () {
                              Navigator.push(
                              context, 
                              MaterialPageRoute(builder: (context)=>SearchRoute())
                            );}, 
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.transparent))),
                        padding: EdgeInsets.fromLTRB(40,0,0,0),
                      ),
                      Container(
                        child: ElevatedButton(
                          child: Text('MY찜',style: TextStyle(fontSize: 20,color: Colors.white),),
                          onPressed: () {      
                            Navigator.push(
                              context, 
                              MaterialPageRoute(builder: (context)=>HeartRoute(movie, sid, heartCheck))
                            );}, 
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.transparent))),
                        padding: EdgeInsets.fromLTRB(0,0,40,0),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,),
                    width: deviceWidth+10,
                    height: deviceHeight/12,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                  )
                ),
              ],),

              // 1. 메인 그림아래 [찜, 재생, 세부정보] 위젯
              Container(child: 
                Row(
                  children: [
                    Container(
                      child: ElevatedButton(
                        child: heartCheck[0]==0?
                          Icon(Icons.favorite, color: Colors.white54,size: 25,)
                          :Icon(Icons.favorite, color: Colors.pink,size: 25,),
                        onPressed: () {
                          sidFun(sid, movie[0], 0);
                        },
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black))
                      ),
                      width: deviceWidth/3,
                    ),
                    Container(
                      child:ElevatedButton(
                        child: Row(children: [
                          Icon(Icons.play_arrow, color: Colors.black, size: 30,),
                          Text(' 재생', style: TextStyle(color: Colors.black))
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        onPressed: () {playToast();}, 
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white))
                      ),
                      width: deviceWidth/3,
                    ),
                    Container(
                      child:ElevatedButton(
                        child: Icon(Icons.info_outline, color: Colors.white54,size: 25,),
                        onPressed: () {      
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context)=>DetailRoute(movie[0]))
                          );}, 
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black))
                      ),
                      width: deviceWidth/3,
                    ),
                  ],
                ),
                width: deviceWidth+10,
                height: 80,
              ), 
              Container(
                child: Text('인기순위 영화 목록',style: TextStyle(color: Colors.white, fontSize: 16,),),
                width: deviceWidth+10, padding: EdgeInsets.fromLTRB(15,0,0,20),),

              // 2. 인기순위 영화 목록들 나열한 위젯
              SingleChildScrollView(
                child: Container(
                  child: Row(children: [

                    // test용으로 5개 데이터
                    for (int i = 0 ; i<movie.length; i++) 
                    Card(child: Column(
                      children: [
                        Container(
                          child : Image.network(dotenv.env['FLUTTER_APP_TMDB_KEY_BASEURL_IMG'].toString()+movie[i]['poster_path'].toString(), fit: BoxFit.fill,),
                          width: 150, height: 160,
                        ),
                        Container(
                          child: Row(
                            children: [
                              if(heartCheck[i] == 1)
                              IconButton(
                                onPressed: () {sidFun(sid, movie[i],i);}, 
                                icon: Icon(Icons.favorite, color:Colors.pink, size:20),
                                padding: EdgeInsets.fromLTRB(8,3,0,0), // 패딩 설정
                                constraints: BoxConstraints()
                                )
                              else if(heartCheck[i] == 0)
                              IconButton(
                                onPressed: () {sidFun(sid, movie[i],i);}, 
                                icon: Icon(Icons.favorite, color:Colors.white54, size:20),
                                padding: EdgeInsets.fromLTRB(8,3,0,0), // 패딩 설정
                                constraints: BoxConstraints()
                                ),  
                              IconButton(
                                onPressed: () {pageMove(movie, index:i);}, 
                                icon: Icon(Icons.info_outline, color:Colors.white54, size:20),
                                padding: EdgeInsets.fromLTRB(0,3,8,0), // 패딩 설정
                                constraints: BoxConstraints()
                                ), 
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                          width: 150,
                          height: 30,
                        )
                      ],
                    ),
                    color: Colors.white10,
                    )
                  ]),
                  // width: deviceWidth+10,
                  height: 200,
                ),
                scrollDirection : Axis.horizontal,
              ),


              Container(
              child: Text('사용자 맞춤 추천 콘텐츠',style: TextStyle(color: Colors.white, fontSize: 16,),),
              width: deviceWidth+10, padding: EdgeInsets.fromLTRB(15,40,0,20),),

              // 3. 사용자 맞춤 추천 콘텐츠
              SingleChildScrollView(
                child: Container(
                  child: Row(children: [
                    // 20개 데이터
                    for (int i = 0 ; i<movieRecommend.length; i++) 
                    Card(child: Column(
                      children: [
                        Container(
                          child : Image.network(dotenv.env['FLUTTER_APP_TMDB_KEY_BASEURL_IMG'].toString()+movieRecommend[i]['poster_path'].toString(), fit: BoxFit.fill,),
                          width: 150, height: 160,
                        ),
                        Container(
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {sidFun(sid, movieRecommend[i],i);}, 
                                icon: Icon(Icons.favorite, color:Colors.white54, size:20),
                                padding: EdgeInsets.fromLTRB(8,3,0,0), // 패딩 설정
                                constraints: BoxConstraints()
                                ),  
                              IconButton(
                                onPressed: () {pageMove(movieRecommend, index:i);}, 
                                icon: Icon(Icons.info_outline, color:Colors.white54, size:20),
                                padding: EdgeInsets.fromLTRB(0,3,8,0), // 패딩 설정
                                constraints: BoxConstraints()
                                ), 
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                          width: 150,
                          height: 30,
                        )
                      ],
                    ),
                    color: Colors.white10,
                    )
                  ]),
                  // width: deviceWidth+10,
                  height: 200,
                ),
                scrollDirection : Axis.horizontal,
              )
            ]),
          ),
          padding: EdgeInsets.fromLTRB(0,0,0,40),
        ),
        backgroundColor: Colors.black,
      );
    } else{
      return Scaffold(
        body: Center(child: CircularProgressIndicator(),),
        backgroundColor: Colors.black,
      );
    }
  }
}

// toast 메시지
void playToast() {
  Fluttertoast.showToast(
    msg: "재생 할 수 없습니다.",
    gravity: ToastGravity.BOTTOM,
    fontSize: 20,
    toastLength: Toast.LENGTH_SHORT
  );
}
