import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:travel_record/data/group/group_class.dart';
import 'package:travel_record/data/users/user_class.dart';

class GroupHomeTab extends StatefulWidget {

  GroupHomeTab({Key key, this.users, this.group}) : super(key : key);
  Users users;
  Group group;

  @override
  _GroupHomeTabState createState() => _GroupHomeTabState();
}

class _GroupHomeTabState extends State<GroupHomeTab> with AutomaticKeepAliveClientMixin<GroupHomeTab>{

  @override
  bool get wantKeepAlive => true;

  Group group;
  Users users;

  @override
  void initState() {
    super.initState();
    group = widget.group;
    users = widget.users;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    FirebaseFirestore db = FirebaseFirestore.instance;
    return Tab(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: Get.height / 5,
                width: Get.width,
                child: Image.network(
                  'https://drizzleanddip.com/wp-content/uploads/2018/03/7O6A0695-768x1152.jpg',
                  fit: BoxFit.fill,

                )),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(group.name),
                      Text('Test'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('그룹 공개 '),
                          Text('멤버 : 10'),
                          Icon(Icons.add)
                        ],)

                    ],
                  ),
                  RaisedButton(onPressed: (){
                    Get.put(group);
                    Get.put(users);
                    Get.toNamed('/groupWrite');
                  }, child: Text('글쓰기'),color: Colors.blueAccent,)
                ],
              ),
            ),
            Container(
              width: Get.width,
              child: Image.network(
                'https://drizzleanddip.com/wp-content/uploads/2018/03/7O6A0648.jpg',
                height: Get.height / 2,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: Get.width,
              child: Image.network(
                'https://drizzleanddip.com/wp-content/uploads/2018/03/7O6A0648.jpg',
                height: Get.height / 2,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }


}
