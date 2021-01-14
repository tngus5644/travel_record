import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_record/data/users/user_class.dart';
import 'package:travel_record/ui/home/home_home_screen.dart';
import 'package:travel_record/ui/home/home_profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  List<Widget> _pages = [HomeHome(), Text('page2'), HomeProfile()];


  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: _pages[_selectedIndex],
          ),
        ),
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
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
        onTap: _onItemTapped);
  }
}
