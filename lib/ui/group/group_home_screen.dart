import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_record/data/group/group_class.dart';
import 'package:travel_record/data/users/user_class.dart';
import 'package:travel_record/ui/group/group_hometab_widget.dart';
import 'package:travel_record/ui/group/group_image_tab.dart';
import 'package:travel_record/ui/group/group_profile_screen.dart';

class GroupHome extends StatefulWidget {
  Users users = Get.find();
  Group group;

  GroupHome({Key key, this.group}) : super(key: key);

  @override
  _GroupHomeState createState() => _GroupHomeState();
}

class _GroupHomeState extends State<GroupHome>
    with SingleTickerProviderStateMixin {
  Users users;
  Group group;
  TabController _controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 5, vsync: this);
    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
    });
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
            appBar: AppBar(
              title: TabBar(controller: _controller, tabs: [
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
            ),
            body: TabBarView(
              controller: _controller,
              children: [
                GroupHomeTab(users: users, group: group),
                GroupImageTab(users: users, group: group),
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
