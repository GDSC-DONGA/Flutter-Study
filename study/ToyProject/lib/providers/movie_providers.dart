import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

// DISCOVER
String baseUrl_discover = dotenv.env['FLUTTER_APP_TMDB_KEY_BASEURL_DISCOVER'].toString();
String url_discover = baseUrl_discover + 'api_key=' + dotenv.env['FLUTTER_APP_TMDB_KEY'].toString();
String baseOption_discover = '&language=ko-KR&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate';

// SEARCH
String baseUrl_search = dotenv.env['FLUTTER_APP_TMDB_KEY_BASEURL_SEARCH'].toString();
String url_search = baseUrl_search + 'api_key=' + dotenv.env['FLUTTER_APP_TMDB_KEY'].toString();
String baseOption_search = '&language=ko-KR&sort_by=popularity.desc&page=1&query=';

class MovieProvider {
  // 인기순으로 가져옴(1page만 : 최대 20개 데이터)
  Uri uri_discover = Uri.parse(url_discover + baseOption_discover);

  Future<List<dynamic>> getMovie() async {
    List<dynamic> movie = [];

    final response = await http.get(uri_discover);

    if (response.statusCode == 200) {
      movie = jsonDecode(response.body)['results'];
    }

    return movie;
  }

  Future<List<dynamic>> searchMovie(String name) async {
    // 검색결과를 가져옴(1page만 : 최대 20개 데이터)
    Uri uri_search = Uri.parse(url_search + baseOption_search + name);
    List<dynamic> movie = [];

    final response = await http.get(uri_search);

    if (response.statusCode == 200) {
      movie = jsonDecode(response.body)['results'];
    }

    return movie;
  }

  Future<dynamic> searchMovieOne(String name) async {
    // 검색결과를 가져옴 1개만
    Uri uri_search = Uri.parse(url_search + baseOption_search + name);
    List<dynamic> movies = [];
    dynamic movie;

    final response = await http.get(uri_search);

    if (response.statusCode == 200) {
      movies = jsonDecode(response.body)['results'];
      movie = movies[0];
    }
    return movie;
  }

}