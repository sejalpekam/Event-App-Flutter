import 'dart:io';

import 'package:event_app_flutter/Dialogs/ErrorHandler.dart';
import 'package:event_app_flutter/Services/AuthServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = new GlobalKey<FormState>();

  TextEditingController userNameInputController;
  String userImageUrl = "";
  File _imageFile;

  @override
  initState() {
    userNameInputController = new TextEditingController();

    super.initState();
  }

  String email, password, dob;
 

  Color greenColor = Color(0xFF00AF19);

  //To check fields during submit
  checkFields() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  //To Validate email
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Form(key: formKey, child: _buildSignupForm())));
  }

  _buildSignupForm() {
    return Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: ListView(children: [
          SizedBox(height: 75.0),
          Container(
              height: 125.0,
              width: 200.0,
              child: Stack(
                children: [
                  Text('Signup',
                      style: TextStyle(fontFamily: 'Trueno', fontSize: 60.0)),
                  //Dot placement
                  Positioned(
                      top: 62.0,
                      left: 200.0,
                      child: Container(
                          height: 10.0,
                          width: 10.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: greenColor)))
                ],
              )),
          SizedBox(height: 25.0),
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
          SizedBox(height: 25.0),
          TextFormField(
            decoration: InputDecoration(labelText: 'User Name'),
            controller: userNameInputController,
            validator: (value) {
              if (value.length < 3) {
                return "Please enter a valid Username.";
              }
            },
          ),
          TextFormField(
              decoration: InputDecoration(
                  labelText: 'EMAIL',
                  labelStyle: TextStyle(
                      fontFamily: 'Trueno',
                      fontSize: 12.0,
                      color: Colors.grey.withOpacity(0.5)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: greenColor),
                  )),
              onChanged: (value) {
                this.email = value;
              },
              validator: (value) =>
                  value.isEmpty ? 'Email is required' : validateEmail(value)),
          TextFormField(
              decoration: InputDecoration(
                  labelText: 'PASSWORD',
                  labelStyle: TextStyle(
                      fontFamily: 'Trueno',
                      fontSize: 12.0,
                      color: Colors.grey.withOpacity(0.5)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: greenColor),
                  )),
              obscureText: true,
              onChanged: (value) {
                this.password = value;
              },
              validator: (value) =>
                  value.length < 6 ? 'Minimum 6 characters required.' : null),
          FormBuilderDateTimePicker(
            name: "Date Of Birth",
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.0), //Theme.of(context).textTheme.body1,
            inputType: InputType.date,
            validator: FormBuilderValidators.compose(
                [FormBuilderValidators.required(context)]),
            format: DateFormat("dd-MM-yyyy"),
            decoration: InputDecoration(
              labelText: "Date of Birth",
              labelStyle: TextStyle(color: Colors.black, fontSize: 16.0),
            ),
            onChanged: (value) {
              dob = value.toString();
            },
          ),
         
          SizedBox(height: 50.0),
          GestureDetector(
            onTap: () {
              if (checkFields())
                // AuthService()
                //     .signUp(email, password)
                uploadAndSaveImage();
              // FirebaseAuth.instance
              //     .createUserWithEmailAndPassword(
              //         email: email, password: password)
              //     .then((userCreds) => FirebaseFirestore.instance
              //         .collection('users')
              //         .doc(userCreds.user.uid)
              //         .set({
              //           "uid": userCreds.user.uid,
              //           "username": userNameInputController.text,
              //           "email": email,
              //           "dob": dob,
              //           "imageUrl": userImageUrl,
              //         })
              //         .then((result) => {Navigator.of(context).pop()})
              //         .catchError((e) {
              //           ErrorHandler().errorDialog(context, e);
              //         }));
            },
            child: Container(
                height: 50.0,
                child: Material(
                    borderRadius: BorderRadius.circular(25.0),
                    shadowColor: Colors.greenAccent,
                    color: greenColor,
                    elevation: 7.0,
                    child: Center(
                        child: Text('SIGN UP',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Trueno'))))),
          ),
          SizedBox(height: 20.0),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text('Go back',
                    style: TextStyle(
                        color: greenColor,
                        fontFamily: 'Trueno',
                        decoration: TextDecoration.underline)))
          ])
        ]));
  }

  Future<void> _selectAndPickImage() async {
    _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  Future<void> uploadAndSaveImage() async {
    if (_imageFile == null) {
      _registeruser();
    } else {
      uploadToStorage();
    }
  }

  Future<void> uploadToStorage() async {
    String imageFileName = DateTime.now().microsecondsSinceEpoch.toString();
    firebase_storage.Reference storageReference = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('profile/$imageFileName');
    firebase_storage.UploadTask storageUploadTask =
        storageReference.putFile(_imageFile);
    // var imageUrl = await storageReference.getDownloadURL();
    // userImageUrl = imageUrl.toString();

    // await storageReference.getDownloadURL().then((fileURL) {
    //   userImageUrl =  fileURL;
    // });

    storageUploadTask.then((res) async {
      userImageUrl = await res.ref.getDownloadURL();
      print("Url profile is " + userImageUrl);

      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((userCreds) => FirebaseFirestore.instance
              .collection('users')
              .doc(userCreds.user.uid)
              .set({
                "uid": userCreds.user.uid,
                "username": userNameInputController.text,
                "email": email,
                "dob": dob,
                "imageUrl": userImageUrl,
              })
              //.then((result) => {Navigator.of(context).pop()})
              .then((result) =>
                  {Navigator.popUntil(context, ModalRoute.withName('/home'))})
              .catchError((e) {
                ErrorHandler().errorDialog(context, e);
              }));
              
    });
  }

  Future<void> _registeruser() async {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((userCreds) => FirebaseFirestore.instance
            .collection('users')
            .doc(userCreds.user.uid)
            .set({
              "uid": userCreds.user.uid,
              "username": userNameInputController.text,
              "email": email,
              "dob": dob,
              "imageUrl":
                  "https://firebasestorage.googleapis.com/v0/b/event-app-db683.appspot.com/o/event%2F1627022301157100?alt=media&token=7b716b04-03f9-4bbe-a077-3893a1166f90", //"gs://event-app-db683.appspot.com/event/event1.jpg",
            })
            .then((result) => {Navigator.of(context).pop()})
            .catchError((e) {
              ErrorHandler().errorDialog(context, e);
            }));
  }
}
