import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_record/models/users/user_class.dart';

Future<void> fetchUsers(DocumentReference docRef) async {
  var a = await docRef.get();
  print(a.data());
}
