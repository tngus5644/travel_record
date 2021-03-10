import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:travel_record/models/group/group_class.dart';
import 'package:travel_record/models/users/user_class.dart';

class HomeHome extends StatefulWidget {
  Users users;
  List<Group> groups;

  HomeHome({Key key, this.users, this.groups}) : super(key: key);

  @override
  _HomeHomeState createState() => _HomeHomeState();
}

class _HomeHomeState extends State<HomeHome> {
  FirebaseStorage _storage = FirebaseStorage.instance;
  Users users;
  List<Group> groups;
  List<String> url;

  @override
  initState() {
    super.initState();
    users = widget.users;
    groups = widget.groups;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                      users.belongGroup.isNull ? 0 : users.belongGroup.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: Get.width / Get.height * 3),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Text('그룹장 : '),
                                ),
                                Text(groups[index].leader.toString()),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    width: Get.width / 2,
                                    height: Get.width / 2,
                                    child: Image.network(
                                      groups[index].imageUrl,
                                      fit: BoxFit.fill,
                                    )),
                                Spacer(),
                                Column(
                                  children: [
                                    Text(groups[index].introduce.toString()),
                                    Text('')
                                  ],
                                ),
                                Spacer(),
                              ],
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Get.put(groups[index]);
                        Get.put(users);
                        Get.toNamed('/GroupHome', arguments: groups[index])
                            .then((value) => setState(() {}));
                      },
                    );
                  }),
              RaisedButton(
                  onPressed: () {
                    Get.toNamed('/makeGroup', arguments: users);
                    Get.put(groups);
                  },
                  child: Icon(Icons.add))
            ],
          ),
        ),
      ),
    );
  }
}
