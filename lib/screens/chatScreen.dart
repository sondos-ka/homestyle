import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:homestyle/roots/constant.dart';
import 'package:homestyle/roots/rootWidget.dart';
import 'package:homestyle/roots/strings.dart';
import 'package:homestyle/screens/productScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'favoriteScreen.dart';
import 'loginScreen.dart';

final messageController = TextEditingController();


class chatScreen extends StatefulWidget {
  @override
  _chatScreenState createState() => _chatScreenState();
}

class _chatScreenState extends State<chatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: true,
      backgroundColor: clogoBlack,
      appBar: appBarWidget(() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('username');
        currentUser = null;
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => GraphQLProvider(
                child: loginScreen(),
                client: configuration.client,
              ),
            ));
      },
          Text(""),
          IconButton(
              icon: Icon(Icons.favorite_border, color: cLogoColor, size: 20),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GraphQLProvider(
                        child: favoriteScreen(),
                        client: configuration.client,
                      ),
                    ));
              }),
          MediaQuery.of(context).size.width),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 55,
                decoration: BoxDecoration(color: clogoBlack),
                //the description code
                child: Center(
                  child: Text(
                    sChat,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: fArabicFont,
                        fontWeight: FontWeight.w100),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height - 136,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/background.jpg"),
                      fit: BoxFit.cover),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 10),
                    child: Row(
                      children: <Widget>[
                        Container(

                       // height:50,
                          width: MediaQuery.of(context).size.width - 80,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: TextField(
                              // expands: true,
                                keyboardType: TextInputType.multiline,
                                maxLines:null,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: fArabicFont,
                                    fontSize: 25,
                                    color: clogoBlack),
                                controller: messageController,
                                decoration: InputDecoration(
                                  hintText: sHintWriteMessage,
                                  hintStyle: TextStyle(
                                      fontFamily: fArabicFont,
                                      color: clightOrange),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(16, 6, 16, 0),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: clightOrange,
                          child: IconButton(
                            icon: Icon(
                              Icons.send,
                              color: clogoBlack,
                            ),
                            iconSize: 30,
                            onPressed: () {
                              messageController.clear();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
