
User parseUser(Map<String, dynamic> responseBody) {
  User user = User.fromJson(responseBody);
  return user;
}

class User {
  String email;
  String name;
  String address;
  String age;
  String loginType;
  String sex;
  List belongGroup;

  User(
      {this.email,
      this.name,
      this.address,
      this.age,
      this.loginType,
      this.sex,
      this.belongGroup});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      age: json['age'] as String,
      loginType: json['loginType'] as String,
      sex: json['sex'] as String,
      belongGroup: json['belong_group'] as List,
    );
  }
}
