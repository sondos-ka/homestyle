import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:homestyle/roots/constant.dart';
import 'package:homestyle/roots/rootWidget.dart';


class loginScreen extends StatefulWidget {



  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
      body:Container(


        decoration: BoxDecoration(
         image: DecorationImage(image: AssetImage("images/backgroundWithGift.png"), fit: BoxFit.cover),
                 ),




                 child: Row(
                 // mainAxisAlignment: MainAxisAlignment.end,
                   crossAxisAlignment: CrossAxisAlignment.end,
                   children: <Widget>[
                     Column(

                   // crossAxisAlignment: CrossAxisAlignment.stretch,
                       children: <Widget>[
                         SizedBox(height: (MediaQuery.of(context).size.height/3)*2-30),

                         Container(
                           width:  (MediaQuery.of(context).size.width/3+100) ,
                           height: (MediaQuery.of(context).size.height/3)-30,
                           child: Padding(
                             padding: const EdgeInsets.only(left:25),
                             child: Column(
                               children: <Widget>[
                                  Container(
                                      height: 40,
                                      child: textInputDecoration)
                                ,
                                 SizedBox(height: 15,)
                                 ,
                                 Container(
                                   height: 40,
                                     child: textInputDecoration)
                                 ,
                                 SizedBox(height: 15,)
                                 ,
                                 awsomeButton,

                               ],
                             ),
                           ),
                         ),


                       ],



                     ),
                   SizedBox(width:MediaQuery.of(context).size.width/3 -70,),



                   Column(

                     children: <Widget>[
                       SizedBox(height: MediaQuery.of(context).size.height/2,),
                       Container(
                         height: MediaQuery.of(context).size.height/2,
                         width:  (MediaQuery.of(context).size.width/3-30 )
                         ,



                         child:TweenAnimationBuilder(
                             duration: Duration(seconds: 3),
                             tween: Tween<double>(begin:0 ,end:1 ),
                             builder:(_, value, a) {
                               return Opacity(
                                 opacity: value,
                                 child:
                                  Image.asset('images/lampIcon.png'),

                               );
                             },
                           ),
                         ),
                     ],
                   )

                   ],


                 ),






      ),

    );
  }
}
