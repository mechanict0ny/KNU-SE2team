import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ui_test/screen/webview.dart';

class KeyDetailPage extends StatefulWidget {
  final String word;
  KeyDetailPage({Key key, this.word}) : super(key: key);
 @override
 _KeyDetailPageState createState() {
   return _KeyDetailPageState();
 }
}

class _KeyDetailPageState extends State<KeyDetailPage> {

Widget build(BuildContext context) {
  //var data = Firestore.instance.collection('keywords').document(widget.word).collection('목록').snapshots();
   return Scaffold(
     appBar: AppBar(title: Text(widget.word +' 세부 목록')),
     body: _buildBody(context),
   );
 }

 Widget _buildBody(BuildContext context) {
 return StreamBuilder<QuerySnapshot>(
   //stream: Firestore.instance.collection('keywords').snapshots(),
   stream: Firestore.instance.collection('keywords').document(widget.word).collection('목록').snapshots(),
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

   return Padding(
     key: ValueKey(record.title),
     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
     child: Container(
       decoration: BoxDecoration(
         border: Border.all(color: Colors.grey),
         borderRadius: BorderRadius.circular(5.0),
       ),
       child: ListTile(
         title: Text(record.title, overflow: TextOverflow.ellipsis),
         trailing: Text(record.date),
         //onTap: () => record.reference.updateData({'value': FieldValue.increment(1)}),
          onTap: (){
           Navigator.push(
             context, 
             MaterialPageRoute(builder: (context) => WebTest(url: record.url)),
             );
         },
       ),
     ),
   );
 }
}

class Record {
  final String date;
 final String url;
 final String title;
 final DocumentReference reference;

 Record.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['url'] != null),
       assert(map['제목'] != null),
        assert(map['date'] != null),
        date = map['date'],
       url = map['url'],
       title = map['제목'];

 Record.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);

 @override
 String toString() => "Record<$date:$title:$url>";
}