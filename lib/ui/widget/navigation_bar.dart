import 'package:flutter/material.dart';

BottomNavigationBar navigationBar() {
  BottomNavigationBar myBar = new BottomNavigationBar(items: [
    BottomNavigationBarItem(icon: Icon(Icons.home_sharp), title: Text("Home"), ),

    BottomNavigationBarItem(icon: Icon(Icons.search), title: Text("Search")),

    BottomNavigationBarItem(icon: Icon(Icons.settings), title: Text("Profile")),
  ]);

  return myBar;
}
