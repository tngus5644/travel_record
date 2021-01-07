import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_record/data/users/user_class.dart';
import 'package:hive/hive.dart';
Widget profileColumn() {
  var box = Hive.box('userBox');
User user = box.get('user');
print(user.name);
print(user.email);
print('in profile');
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text('Profile'),
      SizedBox(
        width: Get.width / 3, height: Get.width / 3,
        child: CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage('https://drizzleanddip.com/wp-content/uploads/2018/03/7O6A0695-768x1152.jpg'),
        ),

        // NetworkImage('https://drizzleanddip.com/wp-content/uploads/2018/03/7O6A0695-768x1152.jpg')
      ),
      Row(
        children: [Text('email'), Text(user.email,)],
      ),
      Row(
        children: [Text('이름'), Text(user.name)],
      ),
      Row(
        children: [],
      ),
      Row(
        children: [],
      ),
      RaisedButton(
          onPressed: () {

            print('in Profiile screen');
          },
          child: Text('회원 정보 수정')),
      Row(
        children: [Column(), Column(), Column()],
      )
    ],
  );
}
