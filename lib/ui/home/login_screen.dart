import 'package:travel_record/data/group/group_class.dart';
import 'package:travel_record/data/users/user_class.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:travel_record/ui/home/home_home_screen.dart';

class Login extends StatelessWidget {
  TextEditingController emailController;
  TextEditingController pwController;
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseStorage fs = FirebaseStorage.instance;

  User user;
  Group group = Group();
  List<Group> groups =  [];

  Future<void> logIn() async {
    DocumentSnapshot ds = await db.collection('users').doc('tngus5644').get();

    user = parseUser(ds.data());

    for(int i = 0 ; i<user.belongGroup.length; i++){
      ds = await db.collection("group").doc(user.belongGroup[i]).get();
      group = parseGroup(ds.data());
      groups.add(group);
      print(groups.length);
    }

    Get.put(groups);
    Get.put(user);

    Get.offAllNamed('home');
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 90),
                Text(
                  'Login',
                  style: TextStyle(fontSize: 50),
                ),
                SizedBox(height: 90),
                Text('Email'),
                SizedBox(height: 10),
                Container(
                    width: Get.width - 40,
                    child: TextField(
                      autofocus: true,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: 'example@email.com',
                          border: OutlineInputBorder()),
                    )),
                SizedBox(height: 20),
                Text('password'),
                SizedBox(height: 10),
                Container(
                    width: Get.width - 40,
                    child: TextField(
                      controller: pwController,
                      obscureText: true,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    )),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: Get.width / 3,
                    ),
                    RaisedButton(
                      onPressed: () {
                        String email = 'tngus5644@gmail.com';
                        logIn();
                      },
                      child: Text('Login'),
                      color: Colors.blueAccent,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
