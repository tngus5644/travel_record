import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';



class test extends StatefulWidget {
  @override
  _testState createState() => _testState();
}

class _testState extends State<test> {
  ImagePicker imgPicker = ImagePicker();
  File _image;

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
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
