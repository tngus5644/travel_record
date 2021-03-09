import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'file:///E:/Flutter/travel_record/lib/models/users/user_class.dart';

class GroupProfile extends StatefulWidget {
  @override
  _GroupProfileState createState() => _GroupProfileState();
}

class _GroupProfileState extends State<GroupProfile> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  Users users;

  @override
  void initState() {
    super.initState();
    users = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        child: Text('회원 탈퇴'),
        color: Colors.blueAccent,
        onPressed: () {
          withdrawal();
        },
      ),
    );
  }

  void withdrawal() {
    print(users.belongGroup);
    users.belongGroup.removeAt(3);
    db
        .collection('users')
        .doc('tngus5644')
        .update({'belong_group': users.belongGroup});
  }
}
