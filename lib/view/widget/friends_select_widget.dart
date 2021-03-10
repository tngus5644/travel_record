import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:travel_record/models/users/user_class.dart';
import 'package:get/get.dart';
import 'package:travel_record/models/users/fetchUsers.dart';

Future<void> selectFriends(BuildContext context, Users users) async {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  List<String> _selectedFriends = [];
  List<bool> friendCheck = [];
  List<Users> friends = [];
  int i = 0;

  // fetchUsers(users.friends[0]);
  while (i < users.friends.length) {
    friendCheck.add(false);
    var temp = await users.friends[i].get();
    Users tempUser = Users.fromMap(temp.data());
    friends.add(tempUser);
    i++;
  }

  await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: Text("친구 초대"),
            // content: Container(),
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
                              value
                                  ? _selectedFriends.add(friends[index].name)
                                  : _selectedFriends.removeAt(index);
                            });
                          },
                        ),
                        Text(friends[index].name)
                      ]),
                    );
                  }),
            )),
            actions: <Widget>[
              FlatButton(
                child: Text("select"),
                onPressed: () {
                  Get.delete<List<String>>();
                  Get.put(_selectedFriends);
                  Navigator.pop(context, _selectedFriends);
                },
              ),
              FlatButton(
                child: Text("Close"),
                onPressed: () {
                  setState(() {});
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
