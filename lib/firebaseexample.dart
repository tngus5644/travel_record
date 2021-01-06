import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class firebaseExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          FlatButton(
            color: Colors.blue,
            child: Text("create button", style: TextStyle(color: Colors.white)),
            onPressed: () {
              String book = "송우리";
              db.collection('group').document(book).setData({'member': '윤수현', 'id': 1, 'mem_id': 'tngus5644'});
              print(db.collection("users").doc('tngus5644').get().then((DocumentSnapshot ds){
                print(ds.data()['id'].toString());
                print(ds.data()['name'].toString()  );

              }));
            },
          ),
          FlatButton(
              color: Colors.blue,
              child: Text("read button", style: TextStyle(color: Colors.white)),
              onPressed: () {
                String title = "";
                db.collection("group").doc("천년의_질문").get().then((DocumentSnapshot ds){
                  title = ds.data()['purchase?'].toString();
                  print(title);
                });
              }),
//클릭시 데이터를 읽어준다

          FlatButton(
            color: Colors.blue,
            child: Text("update button", style: TextStyle(color: Colors.white)),
            onPressed: () {
              db.collection("group").doc("천년의_질문").updateData({"page":543});
//클릭시 데이터를 갱신해준다.
            },
          ),
          FlatButton(
            color: Colors.blue,
            child: Text("delete button", style: TextStyle(color: Colors.white)),
            onPressed: () {
//클릭시 데이터를 삭제해 준다.
            },
          ),
        ]);
  }
}
