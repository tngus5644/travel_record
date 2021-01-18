///flutter pub run build_runner build

Users parseUser(Map<String, dynamic> responseBody) {
  Users user = Users.fromJson(responseBody);
  return user;
}

class Users {
  String email;
  String name;
  String address;
  String age;
  String loginType;
  String sex;
  List belongGroup;
  String birthday;
  String joinDate;
  List friends;

  Users(
      {this.email,
      this.name,
      this.address,
      this.age,
      this.loginType,
      this.sex,
      this.belongGroup,
      this.birthday,
      this.joinDate,
      this.friends});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
        email: json['id'] as String,
        name: json['name'] as String,
        address: json['address'] as String,
        age: json['age'] as String,
        loginType: json['loginType'] as String,
        sex: json['sex'] as String,
        belongGroup: json['belong_group'] as List,
        birthday: json['birthday'] as String,
        joinDate: json['join_date'] as String,
        friends:json['friends'] as List
    );

  }
}
