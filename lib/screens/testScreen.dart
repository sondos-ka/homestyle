import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:homestyle/roots/dataBase.dart';
import 'package:homestyle/roots/rootWidget.dart';

class testSceen extends StatefulWidget {
  @override
  _testSceenState createState() => _testSceenState();
}

class _testSceenState extends State<testSceen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWidget(() {},Text(''),Text('')),
        body:
        Text("objectId")

    );
  }
}
