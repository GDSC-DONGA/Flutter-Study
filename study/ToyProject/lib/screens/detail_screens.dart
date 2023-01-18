import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DetailRoute extends StatelessWidget {
  dynamic movie;
  DetailRoute(this.movie, {Key? key}) : super(key: key); // 생성자
  // this.id로 생성자 인수에 적어두면, id변수에 바로 매핑시켜서 저장
  
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie Detail"),
        backgroundColor: Colors.transparent, // 투명
        elevation: 1.0, // 그림자 농도
      ),
      extendBodyBehindAppBar: true, // body 위에 앱바 허용
      body: SingleChildScrollView(
        child: Container(
          child: 
            Column(
              children: [
                Container(
                  child : Image.network(dotenv.env['FLUTTER_APP_TMDB_KEY_BASEURL_IMG'].toString()+movie['poster_path'].toString(), fit: BoxFit.fill,),
                  color: Colors.blue,
                  width: deviceWidth+10,
                  height: deviceHeight/1.5,
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        child: Text(movie['original_title'].toString(), 
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white
                        )),
                        width: deviceWidth+10,
                      ),
                      Text('\n'+movie['overview'].toString()+'\n',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),),
                      Container(
                        child: Text('출시날짜 : '+movie['release_date'].toString()+
                        '\n평점 : '+movie['vote_average'].toString()+
                        '\n총 투표수 : '+movie['vote_count'].toString(),
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white70,
                          ),
                        ),
                        width: deviceWidth+10,
                      )
                    ],
                  ),
                  width: deviceWidth+10,
                  padding: EdgeInsets.fromLTRB(20,20,20,40),
                )
              ],
            )
          ,
          // onPressed: () {
          //   Navigator.pop(context);
          // },
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}