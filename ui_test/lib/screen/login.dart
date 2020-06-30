import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ui_test/screen/fbtest.dart';

class Login extends StatefulWidget {
  @override
  State createState() => LoginState();
}

class LoginState extends State<Login> {
  String stuNumber = '';
  String stuID = '';
  String stuPW = '';
  String temp = '';
  int a;
  final String fnName = "name";
  final String fnvalue = "value";
  bool capital;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            height: 25,
          ),
          Text(
            "KNUPIA",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 60,
                //color: const Color(0xFFffffff) //폰트 하얀색,
                color: Colors.red
            ),
          ),
          Container(height: 20),
          makeRowContainer('학  번', 1),
          makeRowContainer('아이디', 2),
          makeRowContainer('비밀번호', 3),
          Container(child: RaisedButton(
              child: Text('로그인', style: TextStyle(fontSize: 16)),
              textColor: Colors.white, //로그인 폰트 화이트
              color: Colors.black, //로그인 버튼 색깔 검정

              onPressed: () {
                temp = stuID;
                Firestore.instance
                .collection('userinfo')
                .document(stuNumber)
                .get()
                .then((DocumentSnapshot ds){
                  if(ds['studentID'] == stuID && ds['studentPW'] == stuPW && ds['studentNum'] == stuNumber ){
                    a = 1;
                    stuID = '';
                    stuPW = '';
                    //stuNumber ='';
                    //라우트??
                    Navigator.pushReplacement(
                      context, 
                      MaterialPageRoute(builder: (context) => KeyApp(stuNum: stuNumber,)),
                     );
                    //####스낵바 수정 필요!! ####
                    Scaffold.of(context).showSnackBar( 
                      new SnackBar(content: new Text("로그인 성공!!"), duration: Duration(milliseconds: 1000))
                    );
                  }
                  
                });

                // Scaffold.of(context).showSnackBar(
                //     new SnackBar(content: new Text("로그인 정보 없음"), duration: Duration(milliseconds: 500)) 
                //     );
              }       
          ),
            margin: EdgeInsets.only(top: 12),
          ),
          Container(height: 10),
          Text(
            "아이디와 비밀번호는 통합정보 시스템과 동일합니다.",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              //color: const Color(0xFFffffff) //폰트 하얀색
              color: Colors.black,
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }

  Widget makeRowContainer(String title, int op) {
    return Container(
      child: Column(
        children: <Widget>[
          //makeText(title),
          makeTextField(title, op),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      padding: EdgeInsets.only( top: 10, bottom: 8),
    );
  }

  // Cascade 문법 사용. 주석으로 막은 코드보다 ..을 사용한 한 줄 코드가 훨씬 낫다.
  // Cascade 문법은 아래에서 따로 설명한다.
  Widget makeText(String title) {
    // var paint = Paint();
    // paint.color = Colors.green;

    return Text( //학번 아이디 비밀번호 텍스트
      title,
      style: TextStyle(
        fontSize: 21,
        // background: paint,
      ),
    );
  }


  Widget makeTextField(String title, int op) {
    // TextField 위젯의 크기를 변경하고 padding을 주려면 Container 위젯 필요.
    // TextField 독자적으로는 할 수 없음.
    return Container(
      child: TextField(
        // TextField 클래스는 입력 내용을 갖고 있지 않고, TextEditingController 클래스에 위임.
        // 입력 내용에 접근할 때는 controller.text라고 쓰면 된다.
        // 여기서는 로그인에 성공했을 때 초기화를 위한 용도로만 사용한다. 아래처럼 초기값을 줄 수도 있다.
        // controller: TextEditingController()..text = '플러터',

        obscureText: title == '비밀번호' ? true : false,
        controller: TextEditingController()
          ..text = '',
        style: TextStyle(fontSize: 20, color: Colors.black),
        textAlign: TextAlign.left,
        // 테두리 출력. enabledBorder 옵션을 사용하지 않으면 변경 불가.
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(),
          labelText: title,
          //hintText: "\'"+ title+"\'"+" 입력해주세요."
        ),
        onChanged: (String str) {
          // 입력이 변경될 때마다 갱신이 필요하지 않기 때문에 세터 사용 안함
          // 아이디와 비밀번호 중에서 하나를 갱신한다.
          if (op == 1)
            stuNumber = str;
          else if (op == 2)
            stuID = str;
          else
            stuPW = str;
        },
      ),
      // TextField 위젯의 크기를 설정하려면 Container 위젯을 부모로 가져야 한다.
      // 컨테이너의 크기가 텍스트필드의 크기가 된다.
      width: 300,
      //padding: EdgeInsets.only(left: 80),
    );
  }

}
