import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_record/data/appstate.dart';
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
  static final app = AppState(false, null, null, null);
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool doRemember = false;
  Users users;
  Group group;
  List<Group> groups = [];

  void _signInWithGoogle() async {
    setState(() {
      app.loading = true;
    });
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    setState(() {
      app.loading = false;
      app.user = user;
    });
    // assert(!user.isAnonymous);
    // assert(await user.getIdToken() != null);
    // currentUser = await _auth.currentUser;
    // assert(user.uid == currentUser.uid);
    if (app.user != null)
      logIn();
    else
      print('login failed');
  }

  Future<void> logIn() async {
    // FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: pwController.text);
    db.collection('users').doc(app.user.uid).update({
      "name": app.user.displayName,
      "uid": app.user.uid,
      "email": app.user.email,
      "photoURL": app.user.photoURL,
      "join_date": app.user.metadata.creationTime,
      "lastSignInTime": app.user.metadata.lastSignInTime
    });

    DocumentReference _docRef = db.collection('users').doc(app.user.uid);
    DocumentSnapshot ds = await _docRef.get();
    users = parseUser(ds.data());


    setState(() {
      app.users = users;

    });
    if (!users.belongGroup.isNull) {
      await _getUsersBelongGroup(users.belongGroup);
      _putAndGo();

    } else
      _putAndGo();
  }

  _getUsersBelongGroup(List ref) async {
    for (int i = 0; i < ref.length; i++) {
      DocumentSnapshot ds = await ref[i].get();
      group = parseGroup(ds.data());
      groups.add(group);
    }
  }

  _putAndGo() {
    Get.put(groups);
    Get.put(users);
    Get.put(app.user);
    Get.offAllNamed('home');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Login',
              style: TextStyle(fontSize: 50),
            ),
            Center(
              child: RaisedButton(
                onPressed: () {
                  _signInWithGoogle();
                },
                child: Text('SignInWithGoogle'),
                color: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
