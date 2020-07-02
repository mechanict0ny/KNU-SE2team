import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ui_test/screen/key_detail.dart';


//void main() => runApp(KeyApp());


class KeyApp extends StatefulWidget {
  final String stuNum;
  KeyApp({Key key, this.stuNum}):super(key:key);
 @override
 _KeyAppState createState() {
   return _KeyAppState();
 }
}

class _KeyAppState extends State<KeyApp> {

  final String colName = "keywords";
  //final String fnKey = "keyword";
  final String fnName = "name";
  //final String fnvalue = "value";


  void createDoc(String name){//키워드 추가
    //int a = int.parse(vote);
    //Firestore.instance.collection(colName).document(name).setData({ fnName: name });
    Firestore.instance.collection(colName).document(widget.stuNum).collection('키워드').document(name).setData({fnName: name});

  }
  void deleteDoc(String docID){//키워드 삭제
    //Firestore.instance.collection(colName).document(docID).delete();
    Firestore.instance.collection(colName).document(widget.stuNum).collection('키워드').document(docID).delete();
  }

  void showCreateDialog(){
    //TextEditingController keyCon = TextEditingController();
    TextEditingController nameCon = TextEditingController();
    TextEditingController valueCon = TextEditingController();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            title: Text("추가할 키워드를 입력하세요"),
            content: Container(
              height: 60,
              child: Column(
                children: <Widget>[
                  // TextField(
                  //   autofocus: true,
                  //   decoration: InputDecoration(labelText: "키워드 이름"),
                  //   controller: keyCon,
                  //   ),
                  TextField(
                    autofocus: true,
                    decoration: InputDecoration(labelText: "name"),
                    controller: nameCon,
                  ),
                  // TextField(
                  //   decoration: InputDecoration(labelText: "value"),
                  //   controller: valueCon,
                  // )
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                  elevation: 5.0,
                  onPressed: () {//empty조건 추가할 것
                    if (nameCon.text.isNotEmpty){
                      createDoc(nameCon.text);
                    }
                    //keyCon.clear();
                    nameCon.clear();
                    //valueCon.clear();
                    Navigator.pop(context);
                  },
                  child: Text("추가"))
            ],
          );
        });
  }

 void showDeleteDialog(DocumentSnapshot data){
   showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            title: Text("\'"+data.documentID+"\'" + " 키워드를 삭제합니다."),
            content: Container(
              height: 10,
            ),
            actions: <Widget>[
                  FlatButton(
                    child: Text("삭제"),
                    onPressed: (){
                      deleteDoc(data.documentID);
                      Navigator.pop(context);
                    },
                  ),
                  FlatButton(
                    child: Text("취소"),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  )
                ]
          );
        }
    );
 }


 @override
 Widget build(BuildContext context) {
   Firestore.instance.collection(colName).document(widget.stuNum).setData({'name':widget.stuNum});
   return Scaffold(
     appBar: AppBar(title: Text('키워드 조회')),
     body: _buildBody(context),
     floatingActionButton: FloatingActionButton.extended(
       icon: Icon(Icons.add), 
       tooltip: '키워드를 추가하려면 클릭하세요',
       label: Text('키워드 추가'),
       onPressed: showCreateDialog,
    )
   );
 }


 Widget _buildBody(BuildContext context) {
 return StreamBuilder<QuerySnapshot>(
   //stream: Firestore.instance.collection('keywords').snapshots(),
   stream: Firestore.instance.collection('keywords').document(widget.stuNum).collection('키워드').snapshots(),
   builder: (context, snapshot) {
     if (!snapshot.hasData) return LinearProgressIndicator();

     return _buildList(context, snapshot.data.documents);
   },
 );
}

 Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
   return ListView(
     padding: const EdgeInsets.only(top: 20.0),
     children: snapshot.map((data) => _buildListItem(context, data)).toList(),
   );
 }

 Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
   final record = Record.fromSnapshot(data);
   var collection = Firestore.instance.collection('keywords').document(widget.stuNum).collection('키워드').document(record.name).collection('목록');
   return Padding(
     key: ValueKey(record.name),
     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
     child: Container(
       decoration: BoxDecoration(
         border: Border.all(color: Colors.grey),
         borderRadius: BorderRadius.circular(5.0),
       ),
       child: ListTile(
         title: Text(record.name),
         //trailing: Text(record.value.toString()),
         //onTap: () => record.reference.updateData({'value': FieldValue.increment(1)}),
         onTap: (){
           Navigator.push(
             context, 
             MaterialPageRoute(builder: (context) => KeyDetailPage(word: record.name, col: collection,)),
             );
         },
         onLongPress: (){
           showDeleteDialog(data);
         },
       ),
     ),
   );
 }
}

class Record {
 final String name;
 final DocumentReference reference;

 Record.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['name'] != null),
       name = map['name'];

 Record.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);

 @override
 String toString() => "Record<$name>";
}
