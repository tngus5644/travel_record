import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'file:///E:/Flutter/travel_record/lib/models/group/group_class.dart';
import 'file:///E:/Flutter/travel_record/lib/models/users/user_class.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class GroupWrite extends StatefulWidget {
  Group group;
  Users users;

  GroupWrite({Key key, this.group, this.users}) : super(key: key);

  @override
  _GroupWriteState createState() => _GroupWriteState();
}

class _GroupWriteState extends State<GroupWrite> {
  TextEditingController _controller;
  ImagePicker imgPicker;
  File _image;
  FirebaseStorage _storage = FirebaseStorage.instance;
  Group group;
  Users users;
  File file;
  String markDownText;
  List<int> imageBytes;
  String base64Image;
  DateTime now;

  @override
  void initState() {
    super.initState();
    group = widget.group;
    users = widget.users;
    imgPicker = ImagePicker();
    _controller = TextEditingController();
    now = DateTime.now();
    markDownText = ' ';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> saveData() async {
    ///파일을 저장하기 위해 path 설정, saveFile 생성, 그 안에 Text 입력
    await _localPath;
    File saveFile = await _localFile;
    saveFile = await writeText(_controller.text);
    print(saveFile);

    ///Storage에 저장.
    String docID = group.gid;
    print(users.uid);
    Reference ref = _storage
        .ref()
        .child('group/$docID/post/${users.uid}+${now.toString()}text');
    await ref.putFile(saveFile);
  }

  Future<void> saveImage() async {
    print(_image.path);
    String docID = group.gid;
    Reference ref = _storage
        .ref()
        .child('group/$docID/post/${users.uid}+${now.toString()}');
    await ref.putFile(_image);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/post.txt');
  }

  Future<File> writeText(String _string) async {
    final file = await _localFile;
    print(file);
    // 파일 쓰기
    return file.writeAsString('$_string');
  }

  Future<String> readText(File _file) async {
    try {
      // 파일 읽기.
      String contents = await _file.readAsString();
      print(contents.toString());
      return contents.toString();
    } catch (e) {
      // 에러가 발생할 경우 0을 반환.
      return 'error';
    }
  }

  writeComplete() async {
    await saveData();
    if (_image != null) await saveImage();
    Get.back();
  }

  getGalleryImage() async {
    var image = await imgPicker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image.path);
    });
  }

  getCameraImage() async {
    var image = await imgPicker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [Text('글쓰기'), Text(group.name)],
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              print('go back');
              Get.back();
            }),
        actions: [
          TextButton(
              onPressed: () {
                writeComplete();
              },
              child: Text(
                '완료',
                style: TextStyle(color: Colors.white, fontSize: 20),
              )),
        ],
      ),
      body: Stack(
        children: [
          Center(
              child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  textInputAction: TextInputAction.go,
                  decoration:
                      InputDecoration(hintText: "여기를 눌러 새로운 소식을 남겨보세요."),
                  scrollPadding: EdgeInsets.all(20),
                  keyboardType: TextInputType.multiline,
                  minLines: 35,
                  maxLines: null,
                  autofocus: true,
                  onChanged: (text) {
                    setState(() {
                      markDownText = text;
                    });
                  },
                ),
                Container(
                    child: MarkdownBody(
                  data: markDownText,
                )),
              ],
            ),
          )),
          Positioned(
              bottom: Get.bottomBarHeight,
              // bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 0,
              right: 0,
              child: Container(
                height: 50,
                child: Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.photo),
                        onPressed: () {
                          getGalleryImage();
                          print('gallery select');
                        }),
                    IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: () {
                          getCameraImage();
                          print('camera select');
                        }),
                    IconButton(
                        icon: Icon(Icons.photo),
                        onPressed: () {
                          setState(() {
                            print(group.name);
                          });
                        }),
                    IconButton(icon: Icon(Icons.photo), onPressed: () {}),
                    IconButton(icon: Icon(Icons.photo), onPressed: () {}),
                  ],
                ),
                decoration: BoxDecoration(color: Colors.pink),
              )),
          // Positioned(
          //     top: 0,
          //     left: 0,
          //     right: 0,
          //     child: Container(
          //       height: 50,
          //       child: Row(
          //         children: [
          //           IconButton(
          //               icon: Icon(Icons.text_fields),
          //               onPressed: () {
          //                 print('gallery select');
          //               }),
          //           IconButton(
          //               icon: Icon(Icons.format_bold),
          //               onPressed: () {
          //                 print('camera select');
          //               }),
          //           IconButton(
          //               icon: Icon(Icons.text_format),
          //               onPressed: () {
          //                 setState(() {});
          //               }),
          //           IconButton(icon: Icon(Icons.photo), onPressed: () {}),
          //           IconButton(icon: Icon(Icons.photo), onPressed: () {}),
          //         ],
          //       ),
          //       decoration: BoxDecoration(color: Colors.pink),
          //     ))
        ],
      ),
      resizeToAvoidBottomInset: true,
      //flutter 2.0 업뎃하면서 아래 함수가 빨간줄 그어져서 대체해봄.
      // resizeToAvoidBottomPadding: true,
    );
  }

  void loadData() async {
    String docID = group.gid;

    ///docID폴더의 post 폴더 내의 test파일 get.
    Reference ref = _storage.ref().child('group/$docID/post/test');
    Directory tempDir = Directory.systemTemp;
    File tempFile = File('${tempDir.path}/samplefilepath');
    File loadFile;
    DownloadTask _downloadTask = ref.writeToFile(tempFile);
    await _downloadTask.then((snapshot) => setState(() {
          loadFile = tempFile;
        }));
    _controller.text = await readText(loadFile);
  }
}
