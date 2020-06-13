import 'package:flutter/material.dart';
import 'package:ui_test/screen/login.dart';
//import 'screen/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'knupia login',
      home: LoginPage(),
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
