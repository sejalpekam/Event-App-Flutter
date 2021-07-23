# event_app_flutter

A new Flutter project.

## Getting Started

This is an Events app created using Flutter, Firebase, Firestore and FireStorage.

## Features
The app contains following functionality:
● Login and Register screen
○ Users should be able to login or register themself in order to attend an event.
○ User attributes:
■ User name
■ User Password
■ Image (Optional)
■ Date of birth (user calendar to select the date)

● Events screen: Shows the list of events stored in firestore
○ Each item should contain the name of the event and the image (If the image is
not present, then shows a default image).

○ A floating action button to add an event

● Event screen: On click of a particular event, the details of the event are shown.
Each event has the following properties:
■ Event name
■ Event description
■ Date and time
■ Image
■ Number of users that are attending
■ Attend event button

Validate the email and password fields.
If the user is logged in and the app is closed, on reopen of the app, the user must see the
events list screen. 

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
