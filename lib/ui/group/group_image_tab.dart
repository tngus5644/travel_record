import 'package:flutter/material.dart';
import 'package:travel_record/data/group/group_class.dart';
import 'package:travel_record/data/users/user_class.dart';

class GroupImageTab extends StatefulWidget {
  GroupImageTab({Key key, this.users, this.group}) : super(key: key);
  Users users;
  Group group;

  @override
  _GroupImageTabState createState() => _GroupImageTabState();
}

class _GroupImageTabState extends State<GroupImageTab> {

  Users users;
  Group group;
  @override
  void initState() {
    users = widget.users;
    group = widget.group;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Container();
  }
}
