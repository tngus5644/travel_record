import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_record/models/group/group_class.dart';
import 'package:travel_record/models/users/user_class.dart';

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
  List<Reference> refList;
  List<String> imageUrl = [];

  @override
  void initState() {
    users = widget.users;
    group = widget.group;
    refList = [];
    // TODO: implement initState
    super.initState();
    getDownload();
  }

  void getDownload() async {
    await _storage
        .ref()
        .child('group')
        .child('${group.gid}')
        .child('post')
        .listAll()
        .then((result) {
      print(result.items);
      refList = result.items;
    });
    List<String> tempList = [];
    for (int i = 0; i < refList.length; i++) {
      String tempStr;
      tempStr = await refList[i].getDownloadURL();
      imageUrl.add(tempStr);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: imageUrl.isNull ? 0 : imageUrl.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 1.0),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: Container(
                    color: Colors.redAccent,
                    child: imageUrl.isNull
                        ? CircularProgressIndicator()
                        : imageGridWidget(imageUrl[index]),

                    // child: Text(index.toString())
                  ),
                );
              }),
        ],
      ),
    );
  }
}

Widget imageGridWidget(String url) {
  print('imageGridWidget');
  return Container(
      child: Image.network(
    url,
    fit: BoxFit.cover,
  ));
}
