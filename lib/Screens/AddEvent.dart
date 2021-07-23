import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({Key key}) : super(key: key);

  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final formKey = GlobalKey<FormState>();

  String eventName = '';
  String about = '';
  String location = '';
  String category = 'Music';
  int attendees = 0;
  String imageUrl = "";
  File _imageFile;

  DateTime eventDateTime;
  DateTime date;
  TimeOfDay time;

  String getTimeText() {
    if (time == null) {
      return 'Select Time';
    } else {
      final hours = time.hour.toString().padLeft(2, '0');
      final minutes = time.minute.toString().padLeft(2, '0');

      return '$hours:$minutes';
    }
  }

  String getDateText() {
    if (date == null) {
      return 'Select Date';
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
      // return '${date.month}/${date.day}/${date.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Add Event Form',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(height: 13),
                  InkWell(
                      onTap: _selectAndPickImage,
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.15,
                        backgroundColor: Colors.white,
                        backgroundImage:
                            _imageFile == null ? null : FileImage(_imageFile),
                        child: _imageFile == null
                            ? Icon(
                                Icons.add_photo_alternate,
                                size: MediaQuery.of(context).size.width * 0.15,
                                color: Colors.grey,
                              )
                            : null,
                      )),
                  const SizedBox(height: 13),
                  buildTitle(),
                  const SizedBox(height: 13),
                  buildDesc(),
                  const SizedBox(height: 13),
                  buildCategory(),
                  const SizedBox(height: 13),
                  buildLocation(),
                  const SizedBox(height: 13),
                  buildDate(),
                  const SizedBox(height: 13),
                  buildTime(),
                  const SizedBox(height: 13),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildResetButton(),
                      buildSubmitButton(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTitle() => TextFormField(
        decoration: InputDecoration(
          labelText: 'Event Name',
          border: OutlineInputBorder(),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value.length < 4) {
            return 'Enter at least 4 characters';
          } else {
            return null;
          }
        },
        onSaved: (value) => setState(() => eventName = value),
      );

  Widget buildLocation() => TextFormField(
        decoration: InputDecoration(
          labelText: 'Location',
          alignLabelWithHint: true,
          border: OutlineInputBorder(),
        ),
        maxLines: 2,
        keyboardType: TextInputType.multiline,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value.length < 2) {
            return 'Enter at least 2 characters';
          } else {
            return null;
          }
        },
        maxLength: 40,
        onSaved: (value) => setState(() => location = value),
      );

  Widget buildDesc() => TextFormField(
        decoration: InputDecoration(
          labelText: 'About Event',
          alignLabelWithHint: true,
          border: OutlineInputBorder(),
        ),
        minLines: 3,
        maxLines: 5,
        keyboardType: TextInputType.multiline,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value.length < 5) {
            return 'Enter at least 5 characters';
          } else {
            return null;
          }
        },
        onSaved: (value) => setState(() => about = value),
      );

  Widget buildDate() => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Event Date'),
            TextButton(
              child: Text(getDateText()),
              onPressed: () async {
                final initialDate = DateTime.now();
                final newDate = await showDatePicker(
                  context: context,
                  initialDate: date ?? initialDate,
                  firstDate: DateTime(DateTime.now().year - 1),
                  lastDate: DateTime(DateTime.now().year + 1),
                );

                if (newDate == null) return;
                if (newDate.isBefore(DateTime.now())) return;

                setState(() => date = newDate);
              },
            ),
          ],
        ),
      );

  Widget buildCategory() => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Category'),
            Container(
              padding: const EdgeInsets.all(0.0),
              child: DropdownButton<String>(
                value: category,
                //elevation: 5,
                style: TextStyle(color: Colors.black),

                items: <String>['Music', 'Sport', 'Food', 'Art', 'Other']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value == null) {
                    category = 'Music';
                  }
                  setState(() {
                    category = value;
                  });
                },
              ),
            ),
          ],
        ),
      );

  Widget buildTime() => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Event Time'),
            TextButton(
                child: Text(getTimeText()),
                onPressed: () async {
                  final initialTime = TimeOfDay(hour: 16, minute: 0);
                  final newTime = await showTimePicker(
                    context: context,
                    initialTime: time ?? initialTime,
                  );

                  if (newTime == null) return;
                  setState(() => time = newTime);
                }),
          ],
        ),
      );

  Widget buildResetButton() => Builder(
        builder: (context) => ElevatedButton(
          child: Text('Reset'),
          onPressed: () {
            formKey.currentState.reset();
          },
        ),
      );

  Widget buildSubmitButton() => Builder(
        builder: (context) => ElevatedButton(
          child: Text('Submit'),
          onPressed: () async {
            final isValid = formKey.currentState.validate();
            FocusScope.of(context).unfocus();

            if (isValid) {
              formKey.currentState.save();

              // if (date!.isBefore(DateTime.now())) {
              //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //     duration: Duration(milliseconds: 500),
              //     content: Text('Enter a Valid Date'),
              //   ));
              //   return;
              // }

              eventDateTime = new DateTime(
                date.year,
                date.month,
                date.day,
                time.hour,
                time.minute,
              );

              print(eventDateTime);
              uploadAndSaveImage();
              // String str = '';
              // if (category == 'Music') {
              //   str = 'music';
              // } else if (category == 'Sport') {
              //   str = 'sport';
              // } else if (category == 'Food') {
              //   str = 'food';
              // } else if (category == 'Art') {
              //   str = 'art';
              // } else {
              //   str = 'other';
              // }
              // await FirebaseFirestore.instance.collection(str).add({
              //   'eventName': eventName,
              //   'about': about,
              //   'Location': location,
              //   'category': category,
              //   'eventDateTime': eventDateTime,
              //   'attendees': attendees,
              // });

              //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //       duration: Duration(milliseconds: 500),
              //       content: Text('Event Added'),
              //     ));

              //     setState(() {
              //       date = null;
              //       time = null;
              //     });
              //     formKey.currentState.reset();
            }
          },
        ),
      );

  Future<void> _selectAndPickImage() async {
    _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  Future<void> uploadAndSaveImage() async {
    if (_imageFile == null) {
      addData();
    } else {
      uploadToStorage();
    }
  }

  Future<void> uploadToStorage() async {
    String imageFileName = DateTime.now().microsecondsSinceEpoch.toString();
    firebase_storage.Reference storageReference = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('event/$imageFileName');
    firebase_storage.UploadTask storageUploadTask =
        storageReference.putFile(_imageFile);

    storageUploadTask.then((res) async {
      imageUrl = await res.ref.getDownloadURL();
      print("Url event is " + imageUrl);

      String str = '';
      if (category == 'Music') {
        str = 'music';
      } else if (category == 'Sport') {
        str = 'sport';
      } else if (category == 'Food') {
        str = 'food';
      } else if (category == 'Art') {
        str = 'art';
      } else {
        str = 'other';
      }
      await FirebaseFirestore.instance.collection(str).add({
        'eventName': eventName,
        'about': about,
        'Location': location,
        'category': category,
        'eventDateTime': eventDateTime,
        'attendees': attendees,
        'imageUrl': imageUrl,
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(milliseconds: 500),
        content: Text('Event Added'),
      ));

      setState(() {
        date = null;
        time = null;
      });
      formKey.currentState.reset();
    });
  }

  Future<void> addData() async {
    String str = '';
    if (category == 'Music') {
      str = 'music';
    } else if (category == 'Sport') {
      str = 'sport';
    } else if (category == 'Food') {
      str = 'food';
    } else if (category == 'Art') {
      str = 'art';
    } else {
      str = 'other';
    }
    await FirebaseFirestore.instance.collection(str).add({
      'eventName': eventName,
      'about': about,
      'Location': location,
      'category': category,
      'eventDateTime': eventDateTime,
      'attendees': attendees,
      'imageUrl': "https://firebasestorage.googleapis.com/v0/b/event-app-db683.appspot.com/o/event%2F1627045394884004?alt=media&token=f8433298-15f0-40ff-b360-44a08c15c3a8",
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(milliseconds: 500),
      content: Text('Event Added'),
    ));

    setState(() {
      date = null;
      time = null;
    });
    formKey.currentState.reset();
  }
}
