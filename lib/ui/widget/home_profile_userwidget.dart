import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:travel_record/data/users/user_class.dart';
import 'package:travel_record/ui/home/login_screen.dart';

Widget homeProfileUserWidget(Users user) {

  final sex = true.obs;
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: Get.width * 2 / 7,
            child: Text(
              '이메일계정',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.black, width: 0.5))),
            width: Get.width * 3 / 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  user.email,
                  style: TextStyle(fontSize: 15),
                ),
                user.loginType == 'email'
                    ? CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            AssetImage('assets/social/kakao_logo.png'),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ],
      ),
      SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: Get.width * 2 / 7,
            child: Text(
              '사용자이름',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 6),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.black, width: 0.5))),
            width: Get.width * 3 / 5,
            child: Text(
              user.name,
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
      SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: Get.width * 2 / 7,
            child: Text(
              '생년월일',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 5),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.black, width: 0.5))),
            width: Get.width * 3 / 5,
            child: Text(
              user.birthday,
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: Get.width * 2 / 7,
            child: Text(
              '성별(선택)',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            width: Get.width * 3 / 5,
            child: Row(
              children: [
                Obx(
                  () => RaisedButton(
                      onPressed: () {
                        sex.value = true;
                        print(sex.value);
                      },
                      child: Text('남'),
                      color: sex.value ? Colors.blueAccent : Colors.white),
                ),
                Obx(() => RaisedButton(
                    onPressed: () {
                      sex.value = false;
                    },
                    child: Text('여'),
                    color: !sex.value ? Colors.blueAccent : Colors.white)
                )
              ],
            ),
          ),
        ],
      ),
      SizedBox(
        height: 20,
      ),

      Container(
        width: Get.width * 8 / 10,
        height: Get.height * 1 / 20,
        child: RaisedButton(
          onPressed: () {
            print('in Profiile screen');
          },
          child: Text('회원 정보 수정'),
          color: Colors.blueAccent,
          textColor: Colors.white,
        ),
      ),
      SizedBox(
        height: 30,
      ),

    ],
  );
}
