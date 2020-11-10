import 'package:flutter/material.dart';
import 'package:homestyle/roots/rootWidget.dart';


class loginScreen extends StatefulWidget {
  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget,
      body: Center(
        child: Text('Login'),

      ),

    );
  }
}
