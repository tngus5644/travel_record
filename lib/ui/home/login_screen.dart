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
  Group group = new Group();
  List<Group> groups = List();

  Future<void> logIn() async {
    DocumentSnapshot ds = await db.collection('users').doc('tngus5644').get();

    user = parseUser(ds.data());

    int index = 0;
    user.belongGroup.forEach((e) async {
      ds = await db.collection("group").doc(e).get();
      print(ds.data().toString());
      group = parseGroup(ds.data());

      print(group.introduce.toString());
      // print(group.introduce.toString());
      groups.insert(index, group);
      print(index);
      // print(groups[index].introduce.toString());

      index++;
    });

    Get.put(user);
    Get.put(groups);
    Get.offAllNamed('home');
  }

  // await db
  //     .collection("users")
  //     .doc("tngus5644")
  //     .get()
  //     .then((DocumentSnapshot ds)  {
  //   user = parseUser(ds.data());
  //   Get.put(user);
  //   print(user.name.toString());
  //   user.belongGroup.asMap().forEach((index, e) => db
  //           .collection("group")
  //           .doc(e.toString())
  //           .get()
  //           .then((DocumentSnapshot ds) async {
  //         group = parseGroup(ds.data());
  //         groups.add(group);
  //         Get.put(groups);
  //       }));
  // });

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
