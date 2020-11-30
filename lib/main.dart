import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:homestyle/roots/constant.dart';
import 'package:homestyle/roots/strings.dart';
import 'package:homestyle/screens/loginScreen.dart';
import 'package:homestyle/screens/testScreen.dart';
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
        cursorColor: cLogoColor,
        buttonColor:cLogoColor,
        accentColor: cLogoColor,
        primaryColor:cLogoColor,
        textSelectionHandleColor: cLogoColor,
          canvasColor: cLogoColor,
        textSelectionColor: clightOrange

      ),
      title: sAppName,
      home: WelcomeScreen ()




    );

  }
}
