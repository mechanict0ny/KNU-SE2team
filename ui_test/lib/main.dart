import 'package:flutter/material.dart';
import 'package:ui_test/screen/login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final FirebaseMessaging fcm = FirebaseMessaging();
  void initState(){
    fcm.configure(
      onMessage: (Map<String, dynamic> message) async { 
        print("onMessage: $message"); 
      }, 
      onResume: (Map<String, dynamic> message) async { 
        print("onResume: $message"); 
      }, 
      onLaunch: (Map<String, dynamic> message) async { 
        print("onLaunch: $message"); 
      } 
    );
  }


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
