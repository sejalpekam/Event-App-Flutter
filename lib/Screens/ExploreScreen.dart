import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app_flutter/Modules/Event.dart';
import 'package:event_app_flutter/Screens/EventScreen.dart';
import 'package:event_app_flutter/Widgets/HomeEventContainer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:event_app_flutter/Widgets/LoadingWidget.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({Key key, this.category}) : super(key: key);
  final String category;
  @override
  _ExploreTabState createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection(widget.category).snapshots(),
        builder: (_, snapshot) {
          if (snapshot.data == null ||
              snapshot.connectionState == ConnectionState.waiting) {
            return LoadingWidget();
          }

          final eventDocs = snapshot.data.docs;
          return eventDocs.length == 0
              ? Center(child: Text('Events Coming Up Soon ... Stay Tuned'))
              : ListView.builder(
                  itemCount: eventDocs.length,
                  itemBuilder: (_, index) {
                    return HomeEventContainer(
                      event: Event(
                        name: eventDocs[index]['eventName'],
                        image: eventDocs[index]['imageUrl'],
                        date: eventDocs[index]['eventDateTime'].toString(),
                        about: eventDocs[index]['about'],
                        location: eventDocs[index]['Location'],
                        participants: eventDocs[index]['attendees'],
                        category: eventDocs[index]['category'],
                      ),
                    );
                    // return InkWell(
                    //   onTap: () {
                    //     setState(() {
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => HomeEventContainer(
                    //             event: Event(
                    //               name: eventDocs[index]['eventName'],
                    //               image: eventDocs[index]['imageUrl'],
                    //               date: eventDocs[index]['eventDateTime'],
                    //               about: eventDocs[index]['about'],
                    //               location: eventDocs[index]['Location'],
                    //               participants: eventDocs[index]['attendees'],
                    //               category: eventDocs[index]['category'],
                    //             ),
                    //           ),
                    //         ),
                    //       );
                    //     });
                    //   },

                    // );
                  });
        });
  }
}
