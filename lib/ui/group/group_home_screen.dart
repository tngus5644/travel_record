import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_record/data/group/group_class.dart';
import 'package:travel_record/data/users/user_class.dart';
import 'package:travel_record/ui/group/group_hometab_widget.dart';
import 'package:travel_record/ui/group/group_profile_screen.dart';


class GroupHome extends StatefulWidget {
  Users users = Get.find();
  Group group ;

  GroupHome({Key key, this.group}) : super(key: key);
  @override
  _GroupHomeState createState() => _GroupHomeState();
}

class _GroupHomeState extends State<GroupHome> {
  Users users;
  Group group;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    users = widget.users;
    group = widget.group;
  }
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
                GroupHomeTab(user: users, group : group),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
                Tab(icon: Icon(Icons.directions_bike)),
                GroupProfile()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

