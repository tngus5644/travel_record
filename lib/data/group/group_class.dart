import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

///flutter pub run build_runner build
///
Group parseGroup(Map<String, dynamic> responseBody) {
  Group group = Group.fromMap(responseBody);
  return group;
}

class Group {
  String createAt;
  String name;
  String introduce;
  String leader;
  List member;
  bool allowOpen;
  String imageUrl;
  String gid;

  Group.fromMap(Map<dynamic, dynamic> data)
      : createAt = data['create_at'],
        name = data['name'],
        introduce = data['introduce'],
        leader = data['leader'],
        allowOpen = data['allowOpen'],
        imageUrl = data['imageURL'],
        gid = data['gid'],
        member = data['member'];

// final DocumentReference reference;

Group({this.createAt,
  this.name,
  this.introduce,
  this.leader,
  this.imageUrl,
  this.allowOpen,
  this.member,
  this.gid});
//
//
// factory Group.fromJson(Map<String, dynamic> json) {
//   return Group(
//       allowOpen: json['allowOpen'] as bool,
//       createAt: json['create_at'] as String,
//       name: json['name'] as String,
//       introduce: json['introduce'] as String,
//       leader: json['leader'] as String,
//       member: json['member'] as List,
//       imageUrl: json['imageURL'] as String,
//       document: json['document'] as String);
// }

}
