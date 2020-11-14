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


var textInputDecoration=TextFormField(

  textAlign: TextAlign.center,
  textAlignVertical:TextAlignVertical(y: -1.0),

  initialValue: 'البريد الالكتروني',
  style: TextStyle(fontFamily: arabicFont,fontSize: 20 ,color: Colors.grey)
  ,
  decoration: InputDecoration(
    border: OutlineInputBorder(),
    suffixIcon: Icon(
      Icons.mail  ,color: logoColor,
    ),
  ),
);

var awsomeButton=Container(
  height: 50.0,
  margin: EdgeInsets.all(10),
  child: RaisedButton(
    onPressed: () {},
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(80.0)),
    padding: EdgeInsets.all(0.0),
    child: Ink(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ logoColor,lightOrange ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(30.0)),
      child: Container(
        constraints:
        BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
        alignment: Alignment.center,
        child: Text(
          "تسجيل الدخول",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontSize: 25,fontFamily: arabicFont),
        ),
      ),
    ),
  ),
);