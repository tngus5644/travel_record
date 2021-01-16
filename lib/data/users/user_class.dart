import 'package:hive/hive.dart';

// part 'user_class.g.dart';

///flutter pub run build_runner build

User parseUser(Map<String, dynamic> responseBody) {
  User user = User.fromJson(responseBody);
  return user;
}

// @HiveType(typeId: 0)
class User extends HiveObject {
  // @HiveField(0)
  String email;
  // @HiveField(1)
  String name;
  // @HiveField(2)
  String address;
  // @HiveField(3)
  String age;
  // @HiveField(4)
  String loginType;
  // @HiveField(5)
  String sex;
  // @HiveField(6)
  List belongGroup;
  // @HiveField(7)
  String birthday;
  // @HiveField(8)
  String joinDate;

  User(
      {this.email,
      this.name,
      this.address,
      this.age,
      this.loginType,
      this.sex,
      this.belongGroup,
      this.birthday,
      this.joinDate});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        email: json['id'] as String,
        name: json['name'] as String,
        address: json['address'] as String,
        age: json['age'] as String,
        loginType: json['loginType'] as String,
        sex: json['sex'] as String,
        belongGroup: json['belong_group'] as List,
        birthday: json['birthday'] as String,
        joinDate: json['join_date'] as String);
  }
}
