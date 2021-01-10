import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:travel_record/ui/widget/home_profile_userwidget.dart';
import 'package:travel_record/data/users/user_class.dart';
import 'package:hive/hive.dart';
import 'package:travel_record/ui/widget/home_profile_socialwidget.dart';

class HomeProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var box = Hive.box('box');
    User user = box.get('user');
    print(user.name);
    print(user.email);
    print('in profile');
    return Column(
      children: [
        Text(
          'Profile',
          style: TextStyle(
            fontSize: 40,
          ),
        ),
        SizedBox(height: 20),
        SizedBox(
          width: Get.width / 3, height: Get.width / 3,
          child: CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
                'https://drizzleanddip.com/wp-content/uploads/2018/03/7O6A0695-768x1152.jpg'),
          ),
          // NetworkImage('https://drizzleanddip.com/wp-content/uploads/2018/03/7O6A0695-768x1152.jpg')
        ),
        SizedBox(height: 20),
        Container(
          width: Get.width *9/10,
          child: homeProfileUserWidget(),
        ),



        homeProfileSocialWidget(),




      ],
    );
  }
}
