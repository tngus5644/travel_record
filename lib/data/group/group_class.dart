import 'package:hive/hive.dart';

part 'group_class.g.dart';

///flutter pub run build_runner build
///
Group parseGroup(Map<String, dynamic> responseBody) {
  Group group = Group.fromJson(responseBody);
  return group;
}

@HiveType(typeId: 1)
class Group extends HiveObject {
  @HiveField(10)
  String createAt;
  @HiveField(11)
  dynamic mainImage;
  @HiveField(12)
  String name;
  @HiveField(13)
  String introduce;
  @HiveField(14)
  String leader;
  @HiveField(15)
  List member;

  Group(
      {this.createAt,
      this.name,
      this.introduce,
      this.leader,
      this.mainImage,
      this.member});

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      createAt: json['create_at'] as String,
      name: json['name'] as String,
      introduce: json['introuduce'] as String,
      leader: json['leader'] as String,
      member: json['member'] as List,
      mainImage: json['image'] as dynamic,
    );
  }
}
