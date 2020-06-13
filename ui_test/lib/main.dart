import 'package:flutter/material.dart';
import 'package:ui_test/screen/login.dart';
import 'screen/home.dart';
import 'screen/fbtest.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '로그인',
        theme: new ThemeData(
           primarySwatch: Colors.red,
          //canvasColor: const Color(0xFFe70b0b)//배경 빨간색,
        ),
        home: Scaffold(
            body: Login(),
        ),
    );
  }
}
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: new ThemeData(
//         primarySwatch: Colors.red,  //2020/06/13
//         canvasColor: const Color(0xFFe70b0b)//배경 빨간색,
//       ),
//       home: MyHomePage(title: '키워드별 공지'),
//       home: KeyApp(), 2020/06/13
//       home: Scaffold(
//         body: Login(),
//       ),
//     );
//   }
// }