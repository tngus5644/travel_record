import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_record/data/group/group_class.dart';

///flutter pub run build_runner build

Users parseUser(Map<String, dynamic> responseBody) {
  Users users = Users.fromMap(responseBody);
  return users;
}

class Users {
  String uid;
  String email;
  String name;
  String address;
  String age;
  String loginType;
  String sex;
  String birthday;
  String photoURL;

  List belongGroup;
  List friends;

  DateTime joinDate;
  DateTime lastSignIn;

  Users.fromMap(Map<dynamic, dynamic> data)
      : uid = data['uid'],
        email = data['email'],
        name = data['name'],
        address = data['address'],
        age = data['age'],
        loginType = data['loginType'],
        sex = data['sex'],
        birthday = data['birthday'],
        photoURL = data['photoURL'],

        joinDate = data['join_date'].toDate(),
        lastSignIn = data['lastSignInTime'].toDate(),

        friends = data['friends'],
        belongGroup = data['belong_group'];

}
// Users(
//     {this.email,
//     this.name,
//     this.address,
//     this.age,
//     this.loginType,
//     this.sex,
//     this.belongGroup,
//     this.birthday,
//     this.joinDate,
//     this.friends,
//     this.uid,
//     this.lastSignIn,
//       this.photoURL
//     });
//
// factory Users.fromJson(Map<String, dynamic> json) {
//   return Users(
//       email: json['email'] as String,
//       name: json['name'] as String,
//       address: json['address'] as String,
//       age: json['age'] as String,
//       loginType: json['loginType'] as String,
//       sex: json['sex'] as String,
//       birthday: json['birthday'] as String,
//       friends: json['friends'] as List,
//       uid: json['uid'] as String,
//       joinDate: json['join_date'].toDate(),
//       lastSignIn: json['lastSignInTime'].toDate(),
//       photoURL : json['photoURL'] as String,
//       belongGroup: json['belong_group'] as List
//   );
// }


