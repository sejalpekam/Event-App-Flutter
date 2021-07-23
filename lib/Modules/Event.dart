import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  String name;
  String image;
  String date;
  String category;
  String location;
  String eventId;
  int participants;
  // String cost;
  // int duration;
  String about;

  Event({
    this.name,
    this.image,
    this.date,
    this.category,
    this.location,
    this.eventId,
    this.participants,
    // this.cost,
    // this.duration,
    this.about,
  });
}
