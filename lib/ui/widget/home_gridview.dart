import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

GridView homeGridView() {
  GridView homeGridView = new GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, childAspectRatio: Get.width / Get.height * 4),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Icon(Icons.map),
              Spacer(),
              Text("Item $index"),
              Spacer(),

            ],
          ),
          color: index % 2 == 0 ? Colors.blueAccent : Colors.blueGrey,
        );
      });

  return homeGridView;
}
