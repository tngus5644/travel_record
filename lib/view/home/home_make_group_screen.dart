import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:travel_record/models/group/get_group_from_firebase.dart';

import 'package:travel_record/models/group/group_class.dart';
import 'package:travel_record/models/users/user_class.dart';
import 'package:travel_record/view/home/home_home_screen.dart';

import 'package:travel_record/view/widget/friends_select_widget.dart';
import 'package:flutter/services.dart' show rootBundle;

class HomeMakeGroup extends StatefulWidget {
  Users users;

  HomeMakeGroup({Key key, this.users}) : super(key: key);

  @override
  _HomeMakeGroupState createState() => _HomeMakeGroupState();
}

class _HomeMakeGroupState extends State<HomeMakeGroup> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _introduceController = TextEditingController();
  bool release = true;
  bool checked = false;

  Users users;
  Group group;
  List belongGroup = [];
  List<Group> groups;
  List<String> _selectedFriends = [];

  ImagePicker imgPicker = ImagePicker();
  File _image;

  String url;

  @override
  void initState() {
    super.initState();
    users = widget.users;
    group = Group();
    groups = Get.find();
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

  ///Assets의 Image를 File로 저장.
  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');
    // final file = File('${(await getTemporaryDirectory()).path}/$path');
    final file =
        File('${(await getTemporaryDirectory()).path}/group_main_basic.jpg');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return file;
  }

  ///입력한 field들이 채워졌는지 확인하고 Image가 비어있으면 기본이미지 생성.
  checkInputFields() async {
    (_nameController.text.isBlank || _introduceController.text.isBlank)
        ? Get.snackbar('경고', '이름, 소개를 모두 채워주세요')
        : checked = true;
    if (_image == null)
      _image = await getImageFileFromAssets('group/group_main_basic.jpg');
  }

  makeGroupComplete() async {
    final date = DateFormat('yyyyMMdd').format(DateTime.now());
    String docID;

    DocumentReference userRef = db.collection('users').doc(users.uid);

    group.createAt = date;
    group.name = _nameController.text;
    group.member = [userRef];
    group.introduce = _introduceController.text;
    group.allowOpen = release;
    group.leader = users.name;

    ///group컬렉션의 documentID는 auto create 하고 입력한 필드 생성.
    ///생성후에는 Image를 Storage의 docID에 저장하고 url에 downloadUrl 저장.
    await db.collection('group').add({
      'create_at': group.createAt,
      'introduce': group.introduce,
      'leader': group.leader,
      'allowOpen': release,
      'name': group.name,
      'member': group.member
    }).then((value) {
      docID = value.id;
      DocumentReference groupRef = db.collection('group').doc(docID);
      users.belongGroup.add(groupRef);
      Reference ref = _storage.ref().child('group/$docID/main');

      UploadTask uploadTask = ref.putFile(_image);
      uploadTask.whenComplete(() async {
        group.imageUrl = await ref.getDownloadURL();
        groupRef.update({'imageURL': group.imageUrl, 'gid': docID});
        userRef.update({'belong_group': users.belongGroup});
        groups.add(group);

        Get.put(users);
        Get.put(groups);
        Get.offAllNamed('home');
      });
    });
  }

  Future<void> showOptionsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Options"),
            content: Container(
                child: Column(
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
                width: Get.width * 2 / 3,
                height: Get.height / 7),
            actions: <Widget>[
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'close',
                    style: TextStyle(fontSize: 20),
                  ))
            ],
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
            SizedBox(height: 20),
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
            SizedBox(height: 20),
            Row(
              children: [
                Text('공개 여부'),
                SizedBox(width: 40),
                Container(
                  child: Row(
                    children: [
                      RaisedButton(
                          onPressed: () {
                            setState(() {
                              release = true;
                            });

                            print(release);
                          },
                          child: Text('공개'),
                          color: release ? Colors.blueAccent : Colors.white),
                      RaisedButton(
                          onPressed: () {
                            setState(() {
                              release = false;
                            });
                            print(release);
                          },
                          child: Text('비공개'),
                          color: !release ? Colors.blueAccent : Colors.white),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
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
            SizedBox(height: 20),
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
                    decoration: BoxDecoration(border: Border.all(width: 1.0)),
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
            SizedBox(height: 20),
            RaisedButton(
              onPressed: () async {
                await checkInputFields();

                if (checked) await makeGroupComplete();
                invitation(_selectedFriends);

                // Get.toNamed('makeGroup/home');
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

  ///초대를 하면 friends(users doc에 invitation reference 추가.
  void invitation(List<String> selectedFriends) {
    for (String i in _selectedFriends) {
      // db.collection('users').doc()
    }
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
