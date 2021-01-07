import 'package:hive/hive.dart';

part 'user_class.g.dart';

User parseUser(Map<String, dynamic> responseBody) {
  User user = User.fromJson(responseBody);
  return user;
}


@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String email;
  @HiveField(1)
  String name;
  @HiveField(2)
  String address;
  @HiveField(3)
  String age;
  @HiveField(4)
  String loginType;
  @HiveField(5)
  String sex;
  @HiveField(6)
  List belongGroup;

  User({this.email,
    this.name,
    this.address,
    this.age,
    this.loginType,
    this.sex,
    this.belongGroup});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      age: json['age'] as String,
      loginType: json['loginType'] as String,
      sex: json['sex'] as String,
      belongGroup: json['belong_group'] as List,
    );
  }
}
