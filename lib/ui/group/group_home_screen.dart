import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_record/data/group/group_class.dart';
import 'package:travel_record/data/users/user_class.dart';
import 'package:travel_record/ui/widget/group_hometab_widget.dart';

class GroupHome extends StatelessWidget {
  User user = Get.find();
  Group group ;

  GroupHome({this.group});

  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 5,
          child: Scaffold(
            appBar: TabBar(tabs: [
              Tab(
                  child: Icon(
                Icons.home,
                color: Colors.black,
                size: 40,
              )),
              Tab(
                child: Icon(
                  Icons.photo,
                  color: Colors.black,
                  size: 40,
                ),
              ),
              Tab(
                  child: Icon(
                Icons.assignment_turned_in,
                color: Colors.black,
                size: 40,
              )),
              Tab(
                child: Icon(
                  Icons.chat,
                  color: Colors.black,
                  size: 40,
                ),
              ),
              Tab(
                child: Icon(
                  Icons.settings,
                  color: Colors.black,
                  size: 40,
                ),
              ),
            ]),
            body: TabBarView(
              children: [
                GroupHomeTab(user, group),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
                Tab(icon: Icon(Icons.directions_bike)),
                Tab(icon: Icon(Icons.directions_bike))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
