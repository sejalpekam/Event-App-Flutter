import 'package:event_app_flutter/Screens/HomeScreen.dart';
import 'package:event_app_flutter/Screens/SplashScreen.dart';
import 'package:event_app_flutter/Screens/auth/LoginScreen.dart';
import 'package:event_app_flutter/Screens/auth/RegisterScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Netverbatim'),
        home: HomeScreen(),
        //SplashPage(),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => HomeScreen(),
          //'/login': (BuildContext context) => LoginPage(),
          //'/register': (BuildContext context) => RegisterPage(),
        });
  }
}
