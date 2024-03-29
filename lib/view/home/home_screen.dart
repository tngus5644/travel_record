import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:travel_record/models/group/group_class.dart';
import 'package:travel_record/models/users/user_class.dart';
import 'package:travel_record/view/home/home_home_screen.dart';
import 'package:travel_record/view/home/home_profile_screen.dart';
import 'home_search_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  List<Widget> _pages = [
    HomeHome(users: Get.find(), groups: Get.find()),
    HomeSearch(),
    HomeProfile(users: Get.find())
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_sharp),
              title: Text("Home"),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), title: Text("Search")),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), title: Text("Profile")),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blueAccent[800],
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped),
    );
  }
}
