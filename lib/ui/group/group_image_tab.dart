import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:travel_record/data/group/group_class.dart';
import 'package:travel_record/data/users/user_class.dart';

class GroupImageTab extends StatefulWidget {
  GroupImageTab({Key key, this.users, this.group}) : super(key: key);
  Users users;
  Group group;

  @override
  _GroupImageTabState createState() => _GroupImageTabState();
}

class _GroupImageTabState extends State<GroupImageTab> {
  Users users;
  Group group;
  FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  void initState() {
    users = widget.users;
    group = widget.group;
    // TODO: implement initState
    super.initState();
  }

  void getFirebaseImageFolder() {
    final Reference storageRef =
        _storage.ref().child('group').child('${group.gid}').child('post');
    storageRef.listAll().then((result) {
      print(result.items);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          RaisedButton(
            onPressed: getFirebaseImageFolder,
          ),
          GridView.builder(gridDelegate: null, itemBuilder: null)
        ],
      ),
    );
  }
}
