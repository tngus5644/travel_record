import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:travel_record/ui/widget/home_gridview.dart';
import 'package:travel_record/ui/widget/navigation_bar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(child: Text('Test')),
            GestureDetector(
                child: homeGridView(),
                onTap: () {


                  Get.toNamed("/GroupHome");
                }),
          ],
        ),
      ),
      bottomNavigationBar: navigationBar(),
    );
  }
}
