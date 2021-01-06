import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_record/ui/widget/group_hometab_widget.dart';

class GroupHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
              GroupHomeTab(),
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.directions_bike)),
              Tab(icon: Icon(Icons.directions_bike)),
              Tab(icon: Icon(Icons.directions_bike))
            ],
          ),
        ),
      ),
    );
  }
}
