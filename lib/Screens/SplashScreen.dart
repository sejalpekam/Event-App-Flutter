// import 'package:event_app_flutter/Screens/HomeScreen.dart';
// import 'package:event_app_flutter/Widgets/LoadingWidget.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class SplashPage extends StatefulWidget {
//   SplashPage({Key key}) : super(key: key);

//   @override
//   _SplashPageState createState() => _SplashPageState();
// }

// class _SplashPageState extends State<SplashPage> {
//   @override
//   initState() {
//     final currUser = FirebaseAuth.instance.currentUser;

//     if (currUser == null) {
//       Navigator.pushReplacementNamed(context, "/login");
//     } else {
//       FirebaseFirestore.instance
//           .collection('users')
//           .doc(currUser.uid)
//           .get()
//           .then((DocumentSnapshot result) => Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => HomeScreen(
//                         uid: currUser.uid,
//                       ))))
//           .catchError((err) => print(err));
//     }

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: LoadingWidget(),
//     );
//   }
// }
