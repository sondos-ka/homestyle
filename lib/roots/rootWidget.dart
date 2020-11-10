import 'package:flutter/material.dart';
import 'constant.dart';


//AppBar Background and image
Widget appBarWidget= AppBar(
  flexibleSpace: Image(
    image: AssetImage('images/logoAppBar.png'),
    fit: BoxFit.cover,
  ),
  centerTitle: true,
  backgroundColor: logoColor,
);


