import 'package:flutter/material.dart';


import 'package:homestyle/roots/constant.dart';
import 'package:homestyle/roots/strings.dart';
import 'package:homestyle/screens/welcomeScreen.dart';
//GraphQLConfiguration config= GraphQLConfiguration();
void main() {

 // WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.




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
