import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_record/data/group/group_class.dart';
import 'package:travel_record/data/users/user_class.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:travel_record/ui/home/home_home_screen.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController;
  TextEditingController pwController;
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseStorage fs = FirebaseStorage.instance;
  bool doRemember = false;

  Users user;
  Group group = Group();
  List<Group> groups = [];

  Future<void> logIn() async {
    DocumentSnapshot ds = await db.collection('users').doc('tngus5644').get();

    user = parseUser(ds.data());

    for (int i = 0; i < user.belongGroup.length; i++) {
      ds = await db.collection("group").doc(user.belongGroup[i]).get();
      group = parseGroup(ds.data());
      groups.add(group);
      print(groups.length);
    }

    Get.put(groups);
    Get.put(user);

    print('firebase auth start');
    print(emailController.value.toString());
    print(emailController.text.toString());
    print(pwController.text.toString());
    // FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: pwController.text);
    // FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: pwController.text);
    // print(FirebaseAuth.instance.currentUser.emailVerified.toString());
    Get.offAllNamed('home');
  }

  @override
  void initState() {
    super.initState();
    getRememberInfo();
  }

  @override
  void dispose() {
    setRememberInfo();
    pwController.dispose();
    emailController.dispose();

    super.dispose();
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
                    width: (Get.width - 40),
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
                    width:( Get.width - 40),
                    child: TextField(
                      controller: pwController,
                      obscureText: true,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    )),

                Row(
                  children: <Widget>[
                    Checkbox(
                      value: doRemember,
                      onChanged: (newValue) {
                        setState(() {
                          doRemember = newValue;
                        });
                      },
                    ),
                    Text("Remember Me")
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: Get.width / 3,
                    ),
                    RaisedButton(
                      onPressed: () {

                        String email = 'tngus5644@gmail.com';
                        FocusScope.of(context).requestFocus(new FocusNode());
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

  getRememberInfo() async {
    print(doRemember);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      doRemember = (prefs.getBool("doRemember") ?? false);
    });
    if (doRemember) {
      setState(() {
        emailController.text = (prefs.getString("userEmail") ?? "");
        pwController.text = (prefs.getString("userPasswd") ?? "");
      });
    }
  }

  setRememberInfo() async {
    print(doRemember);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("doRemember", doRemember);
    if (doRemember) {
      prefs.setString("userEmail", emailController.text);
      prefs.setString("userPasswd", pwController.text);
    }
  }
}
