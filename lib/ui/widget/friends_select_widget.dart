import 'package:flutter/material.dart';
import 'package:travel_record/data/users/user_class.dart';
import 'package:get/get.dart';

Future<void> selectFriends(BuildContext context, Users users) async {
  List<String> _selectedFriends = [];
  List<bool> friendCheck = [];
  int i = 0;
  while (i < users.friends.length) {
    friendCheck.add(false);
    i++;
  }
  await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: Text("친구 초대"),
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
                                  ? _selectedFriends.add(users.friends[index])
                                  : _selectedFriends.removeAt(index);
                            });
                          },
                        ),
                        Text(users.friends[index])
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
