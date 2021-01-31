import 'package:hive/hive.dart';

///flutter pub run build_runner build
///
Group parseGroup(Map<String, dynamic> responseBody) {
  Group group = Group.fromJson(responseBody);
  return group;
}

class Group extends HiveObject {
  String createAt;
  String name;
  String introduce;
  String leader;
  List member;
  bool allowOpen;
  String imageUrl;

  Group(
      {this.createAt,
      this.name,
      this.introduce,
      this.leader,
      this.imageUrl,
      this.allowOpen,
      this.member});

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      allowOpen: json['allowOpen'] as bool,
      createAt: json['create_at'] as String,
      name: json['name'] as String,
      introduce: json['introduce'] as String,
      leader: json['leader'] as String,
      member: json['member'] as List,
      imageUrl: json['imageURL'] as String
    );
  }
}
