import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constant.dart';


//AppBar Background and image
Widget appBarWidget(Function logout){
  return AppBar(
title:Padding(
  padding: const EdgeInsets.only(bottom: 15),
  child:   Container(
    width:250,

    child: Image.asset('images/logoHomeScreen.png'),
  ),
) ,

  actions: <Widget>[
    Container(child: IconButton(
    icon:Icon( Icons.power_settings_new,color: cLogoColor),
      onPressed:logout

    ),
    )
  ],




  centerTitle: true,
  backgroundColor: clogoBlack,
);
}


//text field
Widget textInputDecoration(
    String hint ,Icon icon ,type,bool obscure, controller){
  return TextFormField(
    controller: controller,
  textAlign: TextAlign.center,
    keyboardType: type,
  obscureText: obscure,
  style: TextStyle(fontFamily: fArabicFont,fontSize: 25 ,color: Colors.white),
  decoration: InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(fontFamily: fArabicFont,),
    contentPadding: EdgeInsets.only(top: 5),
    border: OutlineInputBorder(),
    suffixIcon: icon,

  ),
);
}





//awsome button

Widget awsomeButton(String buttonText,Function onpressed) {
  return Container(
    height: 50.0,
    margin: EdgeInsets.all(20),
    child: RaisedButton(
      onPressed: () { onpressed();},
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80.0)),
      padding: EdgeInsets.all(0.0),
      child: Ink(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, clightOrange],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(30.0)),
        child: Container(
          constraints:
          BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
          alignment: Alignment.center,
          child: Text(buttonText,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontSize:20, fontFamily: fArabicFont),
          ),
        ),
      ),
    ),
  );
}





