import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_record/models/group/group_class.dart';
import 'package:travel_record/models/users/user_class.dart';

class AppState {
  bool loading;
  User user;
  Users users;
  Group group;

  AppState(this.loading, this.user, this.users, this.group);
}
