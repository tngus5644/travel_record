import 'package:flutter/material.dart';
import 'package:get/get.dart';

Container homeProfileSocialWidget() {
  return Container(
      child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Column(
        children: [
          Container(
            width: Get.width * 1 / 6,
            height: Get.width * 1 / 6,
            decoration: BoxDecoration(
              // Circle shape
              shape: BoxShape.circle,
              color: Colors.white,
              // The border you want
              border: Border.all(
                width: 1.0,
                color: Colors.blueAccent,
              ),
              // The shadow you wan
            ),
            child: Icon(Icons.vpn_key),
          ),
          SizedBox(height: 10),
          Text('비밀번호 변경')
        ],
      ),
      Column(
        children: [
          Container(
            width: Get.width * 1 / 6,
            height: Get.width * 1 / 6,
            decoration: BoxDecoration(
              // Circle shape
              shape: BoxShape.circle,
              color: Colors.white,
              // The border you want
              border: Border.all(
                width: 1.0,
                color: Colors.blueAccent,
              ),
              // The shadow you wan
            ),
            child: Icon(Icons.power_settings_new_outlined),
          ),
          SizedBox(height: 10),
          Text('로그아웃')
        ],
      ),
      Column(
        children: [
          Container(
            width: Get.width * 1 / 6,
            height: Get.width * 1 / 6,
            decoration: BoxDecoration(
              // Circle shape
              shape: BoxShape.circle,
              color: Colors.white,
              // The border you want
              border: Border.all(
                width: 1.0,
                color: Colors.blueAccent,
              ),
              // The shadow you wan
            ),
            child: Icon(Icons.account_circle_outlined),
          ),
          SizedBox(height: 10),
          Text('회원탈퇴')
        ],
      )
    ],
  ));
}
