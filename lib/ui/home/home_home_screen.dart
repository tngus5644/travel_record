import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:travel_record/data/group/group_class.dart';
import 'package:travel_record/data/users/user_class.dart';

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
  String url;

  @override
  initState() {
    super.initState();
    users = widget.users;
    groups = widget.groups;
    url =
        'https://firebasestorage.googleapis.com/v0/b/travel-record-93fbe.appspot.com/o/group%2F9SMCZKNmvyqhwlZAg0Ug%2Fmain?alt=media&token=481fd200-e4ef-4110-b992-edf36cb15c3c';
  }

  getImageUrl() async {
    url = await _storage
        .ref()
        .child('group')
        .child('송우리')
        .child('main.jpg')
        .getDownloadURL();
    print(url);
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
                  itemCount: users.belongGroup.length,
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
                                    child: Image.network(url)),
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
                        Get.delete();
                        Get.put(groups[index]);
                        Get.put(users);
                        Get.toNamed('/GroupHome', arguments: groups[index]);
                      },
                    );
                  }),
              RaisedButton(
                  onPressed: () {
                    Get.toNamed('/makeGroup', arguments: users);
                  },
                  child: Icon(Icons.add))
            ],
          ),
        ),
      ),
    );
  }
}
