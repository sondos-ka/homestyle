import 'package:flutter/material.dart';
import 'package:homestyle/roots/constant.dart';
import 'package:homestyle/screens/welcomeScreen.dart';
import 'file:///C:/Users/Dell/AndroidStudioProjects/homestyle/lib/roots/strings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          brightness: Brightness.dark,
        cursorColor: logoColor,
        buttonColor: logoColor,
        accentColor: logoColor,
        primaryColor:logoColor,
        textSelectionHandleColor: logoColor,
          canvasColor: logoColor,
        textSelectionColor: lightOrange

      ),
      title: appName,
      home: WelcomeScreen(),
    );

  }
}
