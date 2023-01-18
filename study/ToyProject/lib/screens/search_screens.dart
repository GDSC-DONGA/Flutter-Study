import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_study_toyproject/providers/movie_providers.dart';
import 'package:flutter_study_toyproject/screens/detail_screens.dart';


class SearchRoute extends StatefulWidget {
  const SearchRoute({super.key});

  @override
  State<SearchRoute> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchRoute> {
  final TextEditingController _textController = new TextEditingController();
  List<dynamic> movie = [];
  int isLoading = 0; // 처음 초기값은 매번 0
    
  _SearchWidgetState({Key? key});
  // this.id로 생성자 인수에 적어두면, id변수에 바로 매핑시켜서 저장

  MovieProvider movieProvider = MovieProvider();

  Future initMovie(String name) async {
    movie = await movieProvider.searchMovie(name);
    print(movie);
  }

  @override
  void searchClick(String name) {
    print('데이터 검색 시작');
    initMovie(name).then((_) {
      print('데이터 검색 완료');
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
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(55.0),
          child: AppBar(
            title: Text("Movie Search"),
            backgroundColor: Colors.transparent, // 투명
            elevation: 1.0, // 그림자 농도
          ),
        ),
        extendBodyBehindAppBar: true, // body 위에 앱바 허용
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [

                // 검색칸 부분 위젯
                Container(child: Row(children: [
                  Container(child: TextField(
                    onSubmitted: (value) => searchClick(value),
                    controller: _textController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: '검색',
                      hintStyle: TextStyle(fontSize: 15.0, color: Colors.white38, ),
                      contentPadding: EdgeInsets.all(10.0), // padding으로 중앙
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      filled: true,
                      fillColor: Colors.white30,
                    ),
                  ),width: deviceWidth/1.2,height: 40,),
                  Container(child: IconButton(
                      onPressed: () {searchClick(_textController.text);}, 
                      icon: Icon(Icons.search, color:Colors.white38, size:40),
                    )
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
                ),),

                // 검색칸 하단에 결과를 보여줄 위젯
                for(int i = 0 ; i<movie.length; i+=2)
                Container(child: Row(children: [
                  if(i>=movie.length)
                    Container()
                  else
                    Card(child: Column(
                        children: [
                          Container(
                            child : Image.network(dotenv.env['FLUTTER_APP_TMDB_KEY_BASEURL_IMG'].toString()+movie[i]['poster_path'].toString(), fit: BoxFit.fill,),
                            width: deviceWidth/2.2, height: deviceHeight/3,
                          ),
                          Container(
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {}, 
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
                            width: deviceWidth/2.2,
                            height: 30,
                          )
                        ],
                      ),
                      color: Colors.white10,
                    ),
                  if(i+1>=movie.length)
                    Container()
                  else
                    Card(child: Column(
                        children: [
                          Container(
                            child : Image.network(dotenv.env['FLUTTER_APP_TMDB_KEY_BASEURL_IMG'].toString()+movie[i+1]['poster_path'].toString(), fit: BoxFit.fill,),
                            width: deviceWidth/2.2, height: deviceHeight/3,
                          ),
                          Container(
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {}, 
                                  icon: Icon(Icons.favorite, color:Colors.white54, size:20),
                                  padding: EdgeInsets.fromLTRB(8,3,0,0), // 패딩 설정
                                  constraints: BoxConstraints()
                                  ),
                                IconButton(
                                  onPressed: () {pageMove(movie, index:i+1);}, 
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
            padding: EdgeInsets.fromLTRB(0,80,0,40),
          ),
        ),
        backgroundColor: Colors.black,
      ),
    );
  }
}