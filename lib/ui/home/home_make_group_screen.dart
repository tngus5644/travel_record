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
  List<String> _selectedFriends = [];

  final imgPicker = ImagePicker();
  File _image;
  @override
  void initState() {
    super.initState();
    users = widget.users;
  }


  getGalleryImage() async {
    var image = await imgPicker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image.path);
    });
    Navigator.of(context).pop();
  }

  getCameraImage() async {
    var image = await imgPicker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(image.path);
    });

    Navigator.of(context).pop();
  }

  Future<void> showOptionsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Options"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("카메라로 사진 찍기"),
                    onTap: () {
                      getCameraImage();
                    },
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  GestureDetector(
                    child: Text("갤러리에서 가져오기"),
                    onTap: () {
                      getGalleryImage();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
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
            SizedBox(height : 20),
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
            SizedBox(height : 20),
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
            SizedBox(height : 20),
            Row(
              children: [
                Text('멤버 초대'),
                SizedBox(width: 40),
                RaisedButton(
                  onPressed: () async {
                    await selectFriends(context, users);
                    _selectedFriends += Get.find();
                    _selectedFriends = _selectedFriends.toSet().toList();
                    print(_selectedFriends);
                    setState(() {});
                  },
                  child: Icon(Icons.add),
                  color: Colors.blueAccent,
                ),
              ],
            ),
            SizedBox(height : 20),
            Wrap(
              direction: Axis.horizontal,
              children: [
                Container(
                    width: Get.width,
                    height: 50,
                    child: _customListItem(context)),
                // Container(child: _myListView(context)),
              ],
            ),
            Center(child: Text('대표 사진 등록')),
            SizedBox(height: 20),
            Center(
                child: Column(
              children: [
                GestureDetector(
                  child: Container(
                    width: Get.width / 2,
                    height: Get.width / 2,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.0)),
                    child: _image.isNull
                        ? Icon(Icons.photo)
                        : Image.file(_image,
                            width: Get.width / 2, height: Get.width / 2),
                  ),
                  onTap: () {
                    showOptionsDialog(context);
                  },
                ),
              ],
            )),
            SizedBox(height : 20),
            RaisedButton(
              onPressed: () {

                Get.toNamed('makeGroup/image');
              },
              child: Text('완료'),
              color: Colors.blueAccent,
            )
          ],
        ),
      ),
    ));
  }

  Widget _customListItem(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: _selectedFriends.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Card(
              child: Container(
            color: Colors.blueAccent,
            width: 50,
            height: 50,
            child: Text(_selectedFriends[index]),
          )),
          onTap: () {
            setState(() {
              _selectedFriends.removeAt(index);
            });
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
