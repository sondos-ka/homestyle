import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homestyle/roots/constant.dart';
import 'package:homestyle/roots/strings.dart';
import 'package:homestyle/screens/welcomeScreen.dart';
//GraphQLConfiguration config= GraphQLConfiguration();
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

FirebaseMessaging fc= FirebaseMessaging();
void main()async {

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();


  }



  @override
  Widget build(BuildContext context) {
   return MaterialApp(
      theme: ThemeData.dark().copyWith(
          brightness: Brightness.dark,
        cursorColor: clightOrange,
        buttonColor:cLogoColor,
        accentColor: cLogoColor,
        primaryColor:cLogoColor,
        textSelectionHandleColor: Colors.transparent,
          canvasColor:  Colors.transparent,
        textSelectionColor: clightOrange

      ),
      title: sAppName,
      home: WelcomeScreen ()




    );

  }
}
