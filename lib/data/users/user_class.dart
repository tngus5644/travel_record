
///flutter pub run build_runner build

User parseUser(Map<String, dynamic> responseBody) {
  User user = User.fromJson(responseBody);
  return user;
}

class User  {
  String email;
  String name;
  String address;
  String age;
  String loginType;
  String sex;
  List belongGroup;
  String birthday;
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
