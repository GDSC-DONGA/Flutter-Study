import 'package:flutter/material.dart';
import 'package:flutter_study_toyproject/screens/main_screens.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
    await dotenv.load(fileName: 'assets/config/.env');
  runApp(MaterialApp(
    title: 'Movie',
    home: MainRoute(), // 메인 페이지
    ));
}

