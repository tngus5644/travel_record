import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_record/models/users/user_class.dart';

import 'package:travel_record/models/group/group_class.dart';

Future<List<Group>> getGroupFromFirebase(Users users) async {
  Group group;
  List<Group> groups = [];
  FirebaseFirestore db = FirebaseFirestore.instance;

  // DocumentSnapshot ds = await db.collection('users').doc(users.email).get();

  for (int i = 0; i < users.belongGroup.length; i++) {
    // DocumentSnapshot ds =
    //     await db.collection("group").doc(users.belongGroup[i]).get();
    // group = parseGroup(ds.data());
    // groups.add(group);
  }
  return groups;
}
