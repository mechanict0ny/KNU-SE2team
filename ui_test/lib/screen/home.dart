import 'package:flutter/material.dart';
import 'package:ui_test/screen/myKeyword.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  final String stuNum;
  HomePage({Key key, this.stuNum}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('KEYNOPIA')),
      body: Center(
        child : Column(
          children: <Widget>[
            Container(
            height: 100,
          ),
            Text(
            widget.stuNum + ' 님, 반갑습니다.',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black //폰트 하얀색,
            ),
          ),
          Container(
            height: 50,
          ),
        RaisedButton(
          child : Text("키워드 조회"),
          onPressed: (){
            MaterialPageRoute route = MaterialPageRoute(builder: (context) => MyKeywordPage(title: '키워드별 공지'));
            Navigator.push(context, route);
          },
        ),
        RaisedButton(
          child : Text("로그아웃"),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
          ],
        ),
      ),
    );
  }
}
