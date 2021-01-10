import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_record/ui/widget/home_home_widget.dart';

class HomeHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        homeHomeWidget(),
        RaisedButton(
            onPressed: () {
              // Get.toNamed('/makeGroup');
            },
            child: Icon(Icons.add))
      ],
    );
  }
}
