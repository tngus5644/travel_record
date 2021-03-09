import 'package:firebase_auth/firebase_auth.dart';
import 'file:///E:/Flutter/travel_record/lib/models/group/group_class.dart';
import 'file:///E:/Flutter/travel_record/lib/models/users/user_class.dart';

class AppState {
  bool loading;
  User user;
  Users users;
  Group group;

  AppState(this.loading, this.user, this.users, this.group);
}
