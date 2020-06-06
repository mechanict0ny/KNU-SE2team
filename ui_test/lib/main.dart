import 'package:flutter/material.dart';
import 'package:ui_test/screens/login.dart';
//import 'screen/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '로그인',
         theme: new ThemeData(
          canvasColor: const Color(0xFFe70b0b)//배경 빨간색,
      ),
        home: Scaffold(
            body: LoginPage(),
        ),
    );
  }
}
/*class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: '키워드별 공지'),
    );
  }
}
*/
