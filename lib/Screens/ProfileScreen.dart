import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app_flutter/Modules/Data.dart';
import 'package:event_app_flutter/Modules/Event.dart';
import 'package:event_app_flutter/Services/AuthServices.dart';
import 'package:event_app_flutter/Widgets/LoadingWidget.dart';
import 'package:event_app_flutter/Widgets/ProfileEventContainer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selected = 0;

  Widget build(BuildContext context) {
    final currUser = FirebaseAuth.instance.currentUser;

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(currUser.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data.data() as Map<String, dynamic>;
          return Scaffold(
            body: ListView(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 100,
                      padding: EdgeInsets.all(30),
                      color: Colors.black,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 45,
                            foregroundImage: NetworkImage(data['imageUrl']),
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${data['username']}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: 20,
                      child: IconButton(
                        icon: Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          FirebaseAuth.instance
                              .signOut()
                              .then((result) => Navigator.pushReplacementNamed(
                                  context, "/login"))
                              .catchError((err) => print(err));
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          child: Text(
                            'Attending',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color:
                                  _selected == 0 ? Colors.black : Colors.grey,
                              fontSize: 17,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _selected = 0;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: profileEvents.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    Event event = profileEvents[index];
                    return ProfileEventContainer(
                      event: event,
                    );
                  },
                ),
              ],
            ),
          );
        }

        return LoadingWidget();
      },
    );
  }
}

//     return SafeArea(
//         child: Scaffold(
//       body: ListView(
//         children: [
//           Stack(
//             children: [
//               Container(
//                 height: 150,
//                 padding: EdgeInsets.all(30),
//                 color: Colors.black,
//                 child: Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 35,
//                       backgroundImage: AssetImage(
//                         'assets/pp.jpg',
//                       ),
//                     ),
//                     SizedBox(width: 30),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           //'Marwan Pablo',
//                           user['userName'],
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 25,
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//               Positioned(
//                 right: 10,
//                 bottom: 20,
//                 child: IconButton(
//                   icon: Icon(
//                     Icons.logout,
//                     color: Colors.white,
//                   ),
//                   onPressed: () {
//                     FirebaseAuth.instance
//                         .signOut()
//                         .then((result) =>
//                             Navigator.pushReplacementNamed(context, "/login"))
//                         .catchError((err) => print(err));
//                   },
//                 ),
//               ),
//             ],
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(vertical: 25),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: GestureDetector(
//                     child: Text(
//                       'Attending',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: _selected == 0 ? Colors.black : Colors.grey,
//                         fontSize: 17,
//                       ),
//                     ),
//                     onTap: () {
//                       setState(() {
//                         _selected = 0;
//                       });
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           ListView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: profileEvents.length,
//             scrollDirection: Axis.vertical,
//             itemBuilder: (context, index) {
//               Event event = profileEvents[index];
//               return ProfileEventContainer(
//                 event: event,
//               );
//             },
//           ),
//         ],
//       ),
//     ));
//   }
// }
