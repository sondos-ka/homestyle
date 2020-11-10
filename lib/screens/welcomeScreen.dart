import 'package:animated_text/animated_text.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:homestyle/roots/constant.dart';
import 'package:homestyle/screens/loginScreen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation _sizeAnimation;


      @override
  void initState() {
    super.initState();

    new Future.delayed(
        const Duration(seconds: 6),
            () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => loginScreen()),
        ));





    _animationController = AnimationController(
       vsync:this, duration: Duration(seconds:2))
      ..addStatusListener((status) {
      });
    _sizeAnimation = Tween<double>(begin: 0.0, end:700).animate(_animationController);

   _animationController.forward();

  }

  @override
  Widget build(BuildContext context) {

  return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: logoBlack),
        child: Center(
          child: Column(

            crossAxisAlignment :CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Container(
               child: Column(

                  children: <Widget>[
                    Column(

                      children: <Widget>[
                        SizedBox(height: 200,),

                        AnimatedBuilder(
                          animation: _sizeAnimation,
                          builder: (context, child) => Container(
                            width: _sizeAnimation.value,
                            height:100,
                            child: Container(
                                child:Image.asset('images/logoHomeScreen.png')),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          decoration: BoxDecoration(color: logoBlack),
                          //the description code
                          child: AnimatedText(
                            alignment: Alignment.center,
                            speed: Duration(milliseconds: 2000),
                            controller: AnimatedTextController.play,
                            displayTime: Duration(milliseconds: 1000),
                            wordList: ['the best idea', 'for your home'],
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontFamily: logoDescrebtionFont,
                                fontWeight: FontWeight.w100),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),


                    TweenAnimationBuilder(
                      duration: Duration(seconds: 2),
                      tween:AlignmentGeometryTween(begin: Alignment.bottomLeft,end: Alignment.topLeft),
                        builder:(_, align, a) {
                          return Container(
                            alignment: align,
                            decoration: BoxDecoration(color: logoBlack),
                            height:200,

                            child: Image.asset('images/logoOrangeLine.png'),
                          );
                        },
                    ),
                  ],

                ),


              ),
              //SizedBox(height:100,)



            ],
          ),



        ),


      ),

    );
  }
}
