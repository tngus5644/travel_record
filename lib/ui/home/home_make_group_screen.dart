import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:travel_record/data/users/user_class.dart';
import 'package:travel_record/ui/widget/friends_select_widget.dart';

class HomeMakeGroup extends StatefulWidget {
  Users users;

  HomeMakeGroup({Key key, this.users}) : super(key: key);

  @override
  _HomeMakeGroupState createState() => _HomeMakeGroupState();
}

class _HomeMakeGroupState extends State<HomeMakeGroup> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _introduceController = TextEditingController();
  final release = true.obs;
  Users users;

  @override
  void initState() {
    super.initState();
    users = widget.users;
  }

  Future<void> _getUsers() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '새 여행 만들기',
              ),
              Row(
                children: [
                  Text('여행 이름'),
                  SizedBox(width: 40),
                  Container(
                    child: TextField(
                      controller: _nameController,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: '멋진 이름을 정해주세요 ',
                      ),
                    ),
                    width: Get.width * 2 / 3,
                  )
                ],
              ),
              Row(
                children: [
                  Text('여행 소개'),
                  SizedBox(width: 40),
                  Container(
                    child: TextField(
                      controller: _introduceController,
                      decoration: InputDecoration(
                        hintText: '어떤 여행인지 간략히 소개해주세요.',
                      ),
                    ),
                    width: Get.width * 2 / 3,
                  )
                ],
              ),
              Row(
                children: [
                  Text('공개 여부'),
                  SizedBox(width: 40),
                  Container(
                    child: Row(
                      children: [
                        Obx(
                          () => RaisedButton(
                              onPressed: () {
                                release.value = true;
                                print(release.value);
                              },
                              child: Text('공개'),
                              color: release.value
                                  ? Colors.blueAccent
                                  : Colors.white),
                        ),
                        Obx(
                          () => RaisedButton(
                              onPressed: () {
                                release.value = false;
                                print(release);
                              },
                              child: Text('비공개'),
                              color: !release.value
                                  ? Colors.blueAccent
                                  : Colors.white),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Text('멤버 초대'),
                  SizedBox(width: 40),
                  RaisedButton(
                    onPressed: () {
                      _selectFriends();
                    },
                    child: Icon(Icons.add),
                    color: Colors.blueAccent,
                  )
                ],
              ),
              Wrap(
                direction: Axis.horizontal,
                children: [
                  Container(
                      width: Get.width *2/3,
                      height: 200,
                      child: _customListItem(context)),
                  // Container(child: _myListView(context)),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }

  Widget _customListItem(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 20,
      itemBuilder: (context, index) {
        return Card(
            child: Container(
          color: Colors.blueAccent,
          width: 40,
          height: 50,
        ));
      },
    );
  }

  void _selectFriends() {
    List<bool> friendCheck = [];
    int i = 0;
    while (i < users.friends.length) {
      friendCheck.add(false);
      i++;
    }

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text("친구 초대"),
              content: SingleChildScrollView(
                  child: Container(
                width: Get.width * 2 / 3,
                height: Get.height,
                child: ListView.builder(
                    itemCount: users.friends.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Row(children: [
                          Checkbox(
                            value: friendCheck[index],
                            onChanged: (bool value) {
                              setState(() {
                                friendCheck[index] = value;
                              });
                            },
                          ),
                          Text(users.friends[index])
                        ]),
                      );
                    }),
              )),
              actions: <Widget>[
                FlatButton(
                  child: Text("select"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text("Close"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

// void _uploadImageToStorage(ImageSource source) async {
//   File image = await ImagePicker.pickImage(source: source);
//
//   if (image == null) return;
//   setState(() {
//     _image = image;
//   });
//
//   // // 프로필 사진을 업로드할 경로와 파일명을 정의. 사용자의 uid를 이용하여 파일명의 중복 가능성 제거
//   // StorageReference storageReference =
//   // _storage.ref().child("profile/${_user.uid}");
//   //
//   // // 파일 업로드
//   // StorageUploadTask storageUploadTask = storageReference.putFile(_image);
//   //
//   // // 파일 업로드 완료까지 대기
//   // await storageUploadTask.onComplete;
//   //
//   // // 업로드한 사진의 URL 획득
//   // String downloadURL = await storageReference.getDownloadURL();
//   //
//   // // 업로드된 사진의 URL을 페이지에 반영
//   // setState(() {
//   //   // _profileImageURL = downloadURL;
//   // });
// }
}
