import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_record/models/group/group_class.dart';
import 'package:travel_record/models/users/user_class.dart';

class GroupProfile extends StatefulWidget {
  @override
  _GroupProfileState createState() => _GroupProfileState();
}

class _GroupProfileState extends State<GroupProfile> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  Users users;
  Group group;

  @override
  void initState() {
    super.initState();
    users = Get.find();
    group = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          RaisedButton(
            child: Text('그룹 탈퇴'),
            color: Colors.blueAccent,
            onPressed: () {
              withdrawal();
            },
          ),
        ],
      ),
    );
  }

  Future<void> withdrawal() async {
    var asked = await _asked();
    var temp;
    if (asked) {
      ///로그인한 users의 documentreference를 검색해서
      ///group doc의 member field에서 login 한 user의 reference 삭제.

      DocumentReference reference = db.collection('users').doc(users.uid);
      group.member.removeWhere((element) => element == reference);
      db.collection('group').doc(group.gid).update({'member': group.member});

      ///로그인한 group의 document reference를 검색해서
      ///users doc의 belong group field에서 현재 group의 reference 삭제.
      reference = db.collection('group').doc(group.gid);
      users.belongGroup.removeWhere((element) => element == reference);
      db
          .collection('users')
          .doc(users.uid)
          .update({'belong_group': users.belongGroup});
      Navigator.pop(context);
    } else {
      print('no');
    }
  }

  Future<bool> _asked() async {
    bool agree;
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('탈퇴하시겠습니까?'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: Row(
                  children: [
                    Icon(Icons.check),
                    Text('예, 탈퇴하겠습니다.'),
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: Row(
                  children: [
                    Icon(Icons.warning_amber_sharp),
                    Text('아니오, 좀더 생각해볼게요.'),
                  ],
                ),
              ),
            ],
          );
        })) {
      case true:
        return true;

        break;
      case false:
        return false;

        break;
      default:
        return false;
    }
  }
}
