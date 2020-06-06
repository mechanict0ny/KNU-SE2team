import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String stuNumber = '';
  String stuID = '';
  String stuPW = '';
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
                fontSize: 50,
                color: const Color(0xFFffffff) //폰트 하얀색,
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
                // 사용자 이름과 비밀번호가 일치한다면!
                Firestore.instance
                .collection('userinfo')
                .where('studentID', isEqualTo: stuID)
                .where('studentPW', isEqualTo: stuPW)
                .getDocuments().then((QuerySnapshot ds) {
                  ds.documents.forEach((doc) => print(doc['studentName']));
                  
                }); 
                if (stuNumber == '1' && stuID == '1' && stuPW == '1') {
                  // 세터로 초기화를 했기 때문에 build 함수 자동 호출하면서
                  // 아이디와 비밀번호 텍스트필드가 빈 문자열로 초기화된다.
                  Scaffold.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text('로그인 성공!!!')));
                  setState(() {
                    stuNumber = '';
                    stuID = '';
                    stuPW = '';
                  });
                }
                else
                  Scaffold.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text('일치하지 않습니다!!')));
              }
          ),
            margin: EdgeInsets.only(top: 12),
          ),
          Container(height: 10),
          Text(
            "아이디와 비밀번호는 통합정보 시스템과 동일합니다.",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: const Color(0xFFffffff) //폰트 하얀색
              ,
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }

  Widget makeRowContainer(String title, int op) {
    return Container(
      child: Row(
        children: <Widget>[
          makeText(title),
          makeTextField(op),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 8),
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


  Widget makeTextField(int op) {
    // TextField 위젯의 크기를 변경하고 padding을 주려면 Container 위젯 필요.
    // TextField 독자적으로는 할 수 없음.
    return Container(
      child: TextField(
        // TextField 클래스는 입력 내용을 갖고 있지 않고, TextEditingController 클래스에 위임.
        // 입력 내용에 접근할 때는 controller.text라고 쓰면 된다.
        // 여기서는 로그인에 성공했을 때 초기화를 위한 용도로만 사용한다. 아래처럼 초기값을 줄 수도 있다.
        // controller: TextEditingController()..text = '플러터',
        controller: TextEditingController()
          ..text = '',
        style: TextStyle(fontSize: 20, color: Colors.black),
        textAlign: TextAlign.center,
        // 테두리 출력. enabledBorder 옵션을 사용하지 않으면 변경 불가.
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,

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
      width: 240,
      padding: EdgeInsets.only(left: 16),
    );
  }

}

/*class Login extends StatefulWidget {
    @override
    State createState() => LoginState();
}

class LoginState extends State<Login> {
    String stuNumber = '';
    String stuID = '';
    String stuPW = '';
    
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
                  fontSize: 41,
                  color: Colors.black,
                ),
              ),
              Container(
                height: 25,
              ),
                    makeRowContainer('학  번', 1),
                    makeRowContainer('아이디', 2),
                    makeRowContainer('비밀번호', 3),
                    Container(child: RaisedButton(
                            child: Text('로그인', style: TextStyle(fontSize: 21)),
                            onPressed: () {
                                // 사용자 이름과 비밀번호가 일치한다면!
                                if(stuNumber == '1' && stuID == '1' && stuPW == '1') {
                                    // 세터로 초기화를 했기 때문에 build 함수 자동 호출하면서 
                                    // 아이디와 비밀번호 텍스트필드가 빈 문자열로 초기화된다.
                                    Scaffold.of(context)
                                        ..removeCurrentSnackBar()
                                        ..showSnackBar(SnackBar(content: Text('로그인 성공!!!')));
                                    setState(() {
                                        stuNumber='';
                                        stuID = '';
                                        stuPW = '';
                                    });
                                }
                                else
                                    Scaffold.of(context)
                                        ..removeCurrentSnackBar()
                                        ..showSnackBar(SnackBar(content: Text('일치하지 않습니다!!')));
                            }
                        ),
                        margin: EdgeInsets.only(top: 12),
                    ),
                    Container(height: 20),
                    Text(
                "아이디와 비밀번호는 통합정보 시스템과 동일합니다.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
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
            child: Row(
                children: <Widget>[
                    makeText(title),
                    makeTextField(op),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            padding: EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
        );
    }
    
    // Cascade 문법 사용. 주석으로 막은 코드보다 ..을 사용한 한 줄 코드가 훨씬 낫다.
    // Cascade 문법은 아래에서 따로 설명한다.
    Widget makeText(String title) {
        // var paint = Paint();
        // paint.color = Colors.green;
        
        return Text(
            title,
            style: TextStyle(
                fontSize: 21,
                // background: paint,
            ),
        );
    }
    
    Widget makeTextField(int op) {
        // TextField 위젯의 크기를 변경하고 padding을 주려면 Container 위젯 필요.
        // TextField 독자적으로는 할 수 없음.
        return Container(
            child: TextField(
                // TextField 클래스는 입력 내용을 갖고 있지 않고, TextEditingController 클래스에 위임.
                // 입력 내용에 접근할 때는 controller.text라고 쓰면 된다.
                // 여기서는 로그인에 성공했을 때 초기화를 위한 용도로만 사용한다. 아래처럼 초기값을 줄 수도 있다.
                // controller: TextEditingController()..text = '플러터',
                controller: TextEditingController(),
                style: TextStyle(fontSize: 21, color: Colors.black),
                textAlign: TextAlign.center,
                // 테두리 출력. enabledBorder 옵션을 사용하지 않으면 변경 불가.
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.red,
                            width: 1.0
                        ),
                    ),
                    contentPadding: EdgeInsets.all(10),
                ),
                onChanged: (String str) { 
                    // 입력이 변경될 때마다 갱신이 필요하지 않기 때문에 세터 사용 안함
                    // 아이디와 비밀번호 중에서 하나를 갱신한다.
                    if(op==1)
                        stuNumber = str;
                    else if(op==2)
                        stuID = str;
                    else
                        stuPW = str;
                },
            ),
            // TextField 위젯의 크기를 설정하려면 Container 위젯을 부모로 가져야 한다.
            // 컨테이너의 크기가 텍스트필드의 크기가 된다.
            width: 240,
            padding: EdgeInsets.only(left: 16),
        );
    }
}
/*
class AuthPage extends StatelessWidget {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            color: Colors.red,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                width: 200,
                height: 200,
                color: Colors.red,
              ),
              Stack(
                children: <Widget>[
                  Form(
                      key: _formkey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                  icon: Icon(Icons.account_circle),
                                  labelText: "Email"),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "Please input correct email.";
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                icon: Icon(Icons.vpn_key),
                                labelText: "Password",
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "Please input correct Password.";
                                }
                                return null;
                              },
                            ),
                            Container(
                              height: 8,
                            ),
                            Text("Forget Password?"),
                          ])),
                  Container(
                    width: 100,
                    height: 50,
                    color: Colors.green,
                  ),
                ],
              ),
              Container(height: size.height * 0.1),
              Text("아이디와 비밀번호는 통합정보 시스템과 동일합니다."),
              Container(
                height: size.height * 0.2,
              )
            ],
          ),
        ],
      ),
    );
  }
}
*/*/