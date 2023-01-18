import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_study_toyproject/screens/detail_screens.dart';


class HeartRoute extends StatefulWidget {
  // const HeartRoute({super.key});

  List<dynamic> movie;
  List<String> sid;
  List<int> heartCheck = List<int>.filled(20, 0);
  HeartRoute(this.movie, this.sid, this.heartCheck, {Key? key}) : super(key: key); // 생성자
  // this.id로 생성자 인수에 적어두면, id변수에 바로 매핑시켜서 저장

  @override
  State<HeartRoute> createState() => _HeartWidgetState(movie, sid, heartCheck);
}

class _HeartWidgetState extends State<HeartRoute> {
  List<dynamic> movie;
  List<String> sid;
  List<int> heartCheck = List<int>.filled(20, 0);
  _HeartWidgetState(this.movie, this.sid, this.heartCheck, {Key? key});
  // this.id로 생성자 인수에 적어두면, id변수에 바로 매핑시켜서 저장

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
  void pageMove(List<dynamic> movie, {int index=-1}) {
    if(index!=-1){
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context)=>DetailRoute(movie[index]))
      );
    }
  }

  
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    List<int> heartMovie = [];
    for(int i = 0 ; i<heartCheck.length; i++){
      if(heartCheck[i] == 1) heartMovie.add(i);
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.0),
        child: AppBar(
          title: Text("Movie Heart"),
          backgroundColor: Colors.transparent, // 투명
          elevation: 1.0, // 그림자 농도
        ),
      ),
      extendBodyBehindAppBar: true, // body 위에 앱바 허용
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              for(int i = 0 ; i<heartMovie.length; i+=2) // 현재 찜목록은 20개까지만
              Container(child: Row(children: [
                if(i>=heartMovie.length)
                  Container()
                else
                  Card(child: Column(
                      children: [
                        Container(
                          child : Image.network(dotenv.env['FLUTTER_APP_TMDB_KEY_BASEURL_IMG'].toString()+movie[heartMovie[i]]['poster_path'].toString(), fit: BoxFit.fill,),
                          width: deviceWidth/2.2, height: deviceHeight/3,
                        ),
                        Container(
                          child: Row(
                            children: [
                              if(heartCheck[heartMovie[i]] == 1)
                              IconButton(
                                onPressed: () {sidFun(sid, movie[heartMovie[i]],heartMovie[i]);}, 
                                icon: Icon(Icons.favorite, color:Colors.pink, size:20),
                                padding: EdgeInsets.fromLTRB(8,3,0,0), // 패딩 설정
                                constraints: BoxConstraints()
                                ),
                              IconButton(
                                onPressed: () {pageMove(movie, index:heartMovie[i]);}, 
                                icon: Icon(Icons.info_outline, color:Colors.white54, size:20),
                                padding: EdgeInsets.fromLTRB(0,3,8,0), // 패딩 설정
                                constraints: BoxConstraints()
                                ), 
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                          width: deviceWidth/2.2,
                          height: 30,
                        )
                      ],
                    ),
                    color: Colors.white10,
                  ),
                if(i+1>=heartMovie.length)
                  Container()
                else
                  Card(child: Column(
                      children: [
                        Container(
                          child : Image.network(dotenv.env['FLUTTER_APP_TMDB_KEY_BASEURL_IMG'].toString()+movie[heartMovie[i+1]]['poster_path'].toString(), fit: BoxFit.fill,),
                          width: deviceWidth/2.2, height: deviceHeight/3,
                        ),
                        Container(
                          child: Row(
                            children: [
                              if(heartCheck[heartMovie[i+1]] == 1)
                              IconButton(
                                onPressed: () {sidFun(sid, movie[heartMovie[i+1]],heartMovie[i+1]);}, 
                                icon: Icon(Icons.favorite, color:Colors.pink, size:20),
                                padding: EdgeInsets.fromLTRB(8,3,0,0), // 패딩 설정
                                constraints: BoxConstraints()
                                ),
                              IconButton(
                                onPressed: () {pageMove(movie, index:heartMovie[i+1]);}, 
                                icon: Icon(Icons.info_outline, color:Colors.white54, size:20),
                                padding: EdgeInsets.fromLTRB(0,3,8,0), // 패딩 설정
                                constraints: BoxConstraints()
                                ), 
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                          width: deviceWidth/2.2,
                          height: 30,
                        )
                      ],
                    ),
                    color: Colors.white10,
                  ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              ),
              ),
            ],
          ),
          padding: EdgeInsets.fromLTRB(0,55,0,40),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}