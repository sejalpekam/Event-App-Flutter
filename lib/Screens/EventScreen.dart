import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app_flutter/Modules/Data.dart';
import 'package:event_app_flutter/Modules/Event.dart';
import 'package:event_app_flutter/Widgets/LoadingWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EventScreen extends StatefulWidget {
  final Event event;
  final String category;

  const EventScreen({this.event, this.category});
  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection(widget.category)
              .doc(widget.event.eventId)
              .snapshots(),
          builder: (_, snapshot) {
            if (snapshot.data == null ||
                snapshot.connectionState == ConnectionState.waiting) {
              return LoadingWidget();
            }

            final snapshotDoc = snapshot.data;

            return ListView(
              children: [
                Container(
                  transform: Matrix4.translationValues(0, -25, 0),
                  child: Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 2,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.event.image),
                        )),
                      ),
                      Positioned(
                        right: 10,
                        left: 10,
                        top: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.keyboard_backspace,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            CircleAvatar(
                              radius: 45,
                              backgroundColor: KAppColor,
                              child: Text(
                                widget.event.date.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        left: 10,
                        right: 10,
                        bottom: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.event.name.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                // Icon(
                                //   widget.event.category,
                                //   color: Colors.white,
                                // ),
                                Text(
                                  widget.event.category.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 15,
                              ),
                              Text(
                                widget.event.location.toString(),
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                          // Text(
                          //   widget.event.fromTo,
                          //   style: TextStyle(
                          //     fontSize: 15,
                          //   ),
                          // )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            snapshotDoc.get('attendees').toString() +
                                ' Attendees',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          // Text(
                          //   widget.event.duration.toString() + ' days duration',
                          //   style: TextStyle(
                          //     fontSize: 15,
                          //   ),
                          // )
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: Material(
                          color: KAppColor,
                          child: MaterialButton(
                              child: Text(
                                'ATTEND',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection(widget.category)
                                    .doc(widget.event.eventId)
                                    .update({
                                  'attendees': snapshotDoc.get('attendees') + 1
                                });

                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(FirebaseAuth.instance.currentUser.uid)
                                    .collection('attending')
                                    .doc(widget.event.eventId)
                                    .set({
                                  'eventId': widget.event.eventId,
                                  'eventName': snapshotDoc.get('eventName'),
                                });
                              }),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'About',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        widget.event.about.toString(),
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }
}
