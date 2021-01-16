import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:travel_record/data/group/group_class.dart';
import 'package:travel_record/data/users/user_class.dart';

class HomeHome extends StatelessWidget {
  // User user ;
  // HomeHome({Key key, this.user}) : super(key:key);
  User user ;
  List<Group> groups ;


  void updateData(){
    user = Get.find();
    groups = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    updateData();
    print(groups.length);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: user.belongGroup.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1, childAspectRatio: Get.width / Get.height * 3),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Text('그룹장 : '),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  width: Get.width / 2,
                                  height: Get.width / 2,
                                  child: Image.network(
                                      'http://travel.chosun.com/site/data/img_dir/2017/06/30/2017063001239_0.jpg')),
                              Spacer(),
                              Column(
                                children: [Text('송우리 여행자들의 모임'), Text('')],
                              ),
                              Spacer(),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
              RaisedButton(
                  onPressed: () {
// Get.toNamed('/makeGroup');
                  },
                  child: Icon(Icons.add))
            ],
          ),
        ),
      ),
    );
  }
}
