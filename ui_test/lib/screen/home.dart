import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';


 class TextClass{
   String title;
   TextClass({this.title});
 }


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> mywidgets = List();
  //
  Future<String> creatAlertDialog(BuildContext context) {
    TextEditingController mycontroller = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            title: Text("추가할 키워드를 입력하세요"),
            content: TextField(
              controller: mycontroller,
            ),
            actions: <Widget>[
              MaterialButton(
                  elevation: 5.0,
                  onPressed: () {
                    Navigator.of(context).pop(mycontroller.text.toString());
                  },
                  child: Text("추가"))
            ],
          );
        });
  }

  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   mywidgets.add(Padding(padding: EdgeInsets.fromLTRB(20,0,20,0)),);
  //   mywidgets.add(Container(
  //           padding: EdgeInsets.only(left: 10),
  //           alignment: Alignment.centerLeft,
  //           color: Colors.blue,
  //           height: 50,
  //           child: Text(
  //             'fdsfa',
  //             textAlign: TextAlign.start,
  //             style: TextStyle(
  //               fontSize: 30,
  //               fontWeight: FontWeight.w400
  //             ),

  //             )
  //           ),);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FirstRoute()),
                );
              }),
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        //children: <Widget>[...loadWidget()],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          creatAlertDialog(context).then((onValue) {
            addList(onValue);
          });
        },
        tooltip: '키워드를 추가하려면 클릭하세요',
        label: Text('키워드 추가'),
        icon: Icon(Icons.add),
      ),
    );
  }

  List<Widget> loadWidget() {
    return mywidgets;
  }

  void addList(String keyword) {
    setState(() {
      mywidgets.add(
        ListTile(
          //ListTile
          // padding: EdgeInsets.only(left: 10),
          // alignment: Alignment.centerLeft,
          // height: 60,

          //color: Colors.white,
          title: Text(
            keyword,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
          ),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.red),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => detailScreen(word: keyword),
              ),
            );
          },
          //onLongPress: , 삭제
        ),
      );
      mywidgets.add(Divider(height: 2, color: Color(0xFF777777)));
    });
  }
}

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('알림 설정'),
      ),
      body: Center(
        child: Text('text'),
      ),
    );
  }
}

class detailScreen extends StatelessWidget {
  final String word;
  detailScreen({Key key, this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(word),
        ),
        body: SafeArea(
          child: WebView(
            initialUrl: 'http://cse.knu.ac.kr/06_sub/02_sub_2.html?no=767&bbs_cmd=view&page=1&key=&keyfield=&category=&bbs_code=Site_BBS_26',
            javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
      // body: FutureBuilder<TextClass>(
      //   future: (() async{
      //     final result =
      //       await http.get('http://cse.knu.ac.kr/06_sub/02_sub_6.html');
      //     return TextClass(title: json.decode(result.body)['title']);
      //   })(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData){
      //       return Text(snapshot.data.title);
      //     } 
      //     else if(snapshot.hasError){
      //       return Text(snapshot.error.toString());
      //     }
      //     return LinearProgressIndicator();
      //   },
      //   ),
      );
    //);
  }
}
