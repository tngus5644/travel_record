
///flutter pub run build_runner build
///
Group parseGroup(Map<String, dynamic> responseBody) {
  Group group = Group.fromJson(responseBody);
  return group;
}

class Group  {
  String createAt;
  dynamic mainImage;
  String name;
  String introduce;
  String leader;
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
