import 'package:flutter/material.dart';
import 'screen/home.dart';
import 'screen/fbtest.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      //home: MyHomePage(title: '키워드별 공지'),
      home: KeyApp(),
    );
  }
}