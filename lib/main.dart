import 'package:travel_record/models/appstate.dart';
import 'package:travel_record/models/group/group_class.dart';
import 'package:travel_record/models/users/user_class.dart';
import 'package:travel_record/view/home/home_home_screen.dart';
import 'package:travel_record/view/home/home_screen.dart';
import 'view/group/group_home_screen.dart';

import 'package:travel_record/view/home/home_make_group_screen.dart';
import 'package:travel_record/view/home/home_home_screen.dart';
import 'package:travel_record/view/home/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:travel_record/view/group/group_write_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebase_core.Firebase.initializeApp();
  await Firebase.initializeApp();
  await getApplicationDocumentsDirectory();

  // Hive
  //   ..init(directory.path)
  //   ..registerAdapter(UserAdapter())
  //   ..initFlutter();
  //
  // Hive.deleteBoxFromDisk('userBox');
  // Hive.deleteBoxFromDisk('groupBox');
  // await Hive.openBox('userBox');
  // await Hive.openBox('groupBox');

  runApp(GetMaterialApp(
    // It is not mandatory to use named routes, but dynamic urls are interesting.
    initialRoute: '/login',
    defaultTransition: Transition.native,
    theme: ThemeData(),
    getPages: [
      //Simple GetPage
      GetPage(
        name: '/login',
        page: () => Login(),
      ),
      GetPage(
        name: '/home',
        page: () => Home(),
      ),
      // GetPage with custom transitions and bindings
      GetPage(
        name: '/homeHome',
        page: () => HomeHome(users: Get.find(), groups: Get.find()),
      ),

      GetPage(
        name: '/GroupHome',
        page: () => GroupHome(group: Get.arguments),
      ),
      GetPage(
        name: '/makeGroup',
        page: () => HomeMakeGroup(users: Get.arguments),
      ),
      GetPage(
        name: '/groupWrite',
        page: () => GroupWrite(),
      ),
    ],
  ));
}

// class Controller extends GetxController {
//   int count = 0;
//   void increment() {
//     count++;
//     // use update method to update all count variables
//     update();
//   }
// }
//
// class First extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.add),
//           onPressed: () {
//             Get.snackbar("Hi", "I'm modern snackbar");
//           },
//         ),
//         title: Text("title".trArgs(['John'])),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             GetBuilder<Controller>(
//                 init: Controller(),
//                 // You can initialize your controller here the first time. Don't use init in your other GetBuilders of same controller
//                 builder: (_) => Text(
//                   'clicks: ${_.count}',
//                 )),
//             RaisedButton(
//               child: Text('Next Route'),
//               onPressed: () {
//                 Get.toNamed('/second');
//               },
//             ),
//             RaisedButton(
//               child: Text('Change locale to English'),
//               onPressed: () {
//                 Get.updateLocale(Locale('en', 'UK'));
//               },
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//           child: Icon(Icons.add),
//           onPressed: () {
//             Get.find<Controller>().increment();
//           }),
//     );
//   }
// }
//
// class Second extends GetView<ControllerX> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('second Route'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             GetX<ControllerX>(
//               // Using bindings you don't need of init: method
//               // Using Getx you can take controller instance of "builder: (_)"
//               builder: (_) {
//                 print("count1 rebuild");
//                 return Text('${_.count1}');
//               },
//             ),
//             GetX<ControllerX>(
//               builder: (_) {
//                 print("count2 rebuild");
//                 return Text('${controller.count2}');
//               },
//             ),
//             GetX<ControllerX>(builder: (_) {
//               print("sum rebuild");
//               return Text('${_.sum}');
//             }),
//             GetX<ControllerX>(
//               builder: (_) => Text('Name: ${controller.user.value.name}'),
//             ),
//             GetX<ControllerX>(
//               builder: (_) => Text('Age: ${_.user.value.age}'),
//             ),
//             RaisedButton(
//               child: Text("Go to last page"),
//               onPressed: () {
//                 Get.toNamed('/third', arguments: 'arguments of second');
//               },
//             ),
//             RaisedButton(
//               child: Text("Back page and open snackbar"),
//               onPressed: () {
//                 Get.back();
//                 Get.snackbar(
//                   'User 123',
//                   'Successfully created',
//                 );
//               },
//             ),
//             RaisedButton(
//               child: Text("Increment"),
//               onPressed: () {
//                 Get.find<ControllerX>().increment();
//               },
//             ),
//             RaisedButton(
//               child: Text("Increment"),
//               onPressed: () {
//                 Get.find<ControllerX>().increment2();
//               },
//             ),
//             RaisedButton(
//               child: Text("Update name"),
//               onPressed: () {
//                 Get.find<ControllerX>().updateUser();
//               },
//             ),
//             RaisedButton(
//               child: Text("Dispose worker"),
//               onPressed: () {
//                 Get.find<ControllerX>().disposeWorker();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class Third extends GetView<ControllerX> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(onPressed: () {
//         controller.incrementList();
//       }),
//       appBar: AppBar(
//         title: Text("Third ${Get.arguments}"),
//       ),
//       body: Center(
//           child: Obx(() => ListView.builder(
//               itemCount: controller.list.length,
//               itemBuilder: (context, index) {
//                 return Text("${controller.list[index]}");
//               }))),
//     );
//   }
// }
//
// class SampleBind extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<ControllerX>(() => ControllerX());
//   }
// }
//
// class User {
//   User({this.name = 'Name', this.age = 0});
//   String name;
//   int age;
// }
//
// class ControllerX extends GetxController {
//   final count1 = 0.obs;
//   final count2 = 0.obs;
//   final list = [56].obs;
//   final user = User().obs;
//
//   updateUser() {
//     user.update((value) {
//       value.name = 'Jose';
//       value.age = 30;
//     });
//   }
//
//   /// Once the controller has entered memory, onInit will be called.
//   /// It is preferable to use onInit instead of class constructors or initState method.
//   /// Use onInit to trigger initial events like API searches, listeners registration
//   /// or Workers registration.
//   /// Workers are event handlers, they do not modify the final result,
//   /// but it allows you to listen to an event and trigger customized actions.
//   /// Here is an outline of how you can use them:
//
//   /// made this if you need cancel you worker
//   Worker _ever;
//
//   @override
//   onInit() {
//     /// Called every time the variable $_ is changed
//     _ever = ever(count1, (_) => print("$_ has been changed (ever)"));
//
//     everAll([count1, count2], (_) => print("$_ has been changed (everAll)"));
//
//     /// Called first time the variable $_ is changed
//     once(count1, (_) => print("$_ was changed once (once)"));
//
//     /// Anti DDos - Called every time the user stops typing for 1 second, for example.
//     debounce(count1, (_) => print("debouce$_ (debounce)"),
//         time: Duration(seconds: 1));
//
//     /// Ignore all changes within 1 second.
//     interval(count1, (_) => print("interval $_ (interval)"),
//         time: Duration(seconds: 1));
//   }
//
//   int get sum => count1.value + count2.value;
//
//   increment() => count1.value++;
//
//   increment2() => count2.value++;
//
//   disposeWorker() {
//     _ever.dispose();
//     // or _ever();
//   }
//
//   incrementList() => list.add(75);
// }
//
// class SizeTransitions extends CustomTransition {
//   @override
//   Widget buildTransition(
//       BuildContext context,
//       Curve curve,
//       Alignment alignment,
//       Animation<double> animation,
//       Animation<double> secondaryAnimation,
//       Widget child) {
//     return Align(
//       alignment: Alignment.center,
//       child: SizeTransition(
//         sizeFactor: CurvedAnimation(
//           parent: animation,
//           curve: curve,
//         ),
//         child: child,
//       ),
//     );
//   }
// }
