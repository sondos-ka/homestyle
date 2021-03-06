import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:homestyle/roots/constant.dart';
import 'package:homestyle/roots/dataBase.dart';
import 'package:homestyle/roots/rootWidget.dart';
import 'package:homestyle/screens/loginScreen.dart';
import 'package:homestyle/screens/productScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';



class menuScreen extends StatefulWidget {
  @override
  _menuScreenState createState() => _menuScreenState();
}

class _menuScreenState extends State<menuScreen> {
  List<menuItems> categories = List<menuItems>();
  double screenWidth;
  GraphQLConfiguration configuration = GraphQLConfiguration();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenWidth = MediaQuery.of(context).size.width;
  }

  @override
  void initState() {
    super.initState();
    categories = menuItems().createMenuItemList();




  }
  @override
  void dispose() {


    super.dispose();
  }

  //for next screen
  void getUserName() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentUser=prefs.get('username');
    print(currentUser);


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: appBarMenuWidget( ()async{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('username');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => GraphQLProvider(
            child:loginScreen(),
            client: configuration.client,),
          ));

      },Text(""),Text("")),
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context,orientation){
          return ListView.builder(
                itemCount: categories.length,
                itemExtent:orientation==Orientation.portrait ? (MediaQuery.of(context).size.height-80)/5:(MediaQuery.of(context).size.height-80)/2 ,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: Hero(
                      tag: 'title' + categories[index].title,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            alignment: categories[index].alignImage,
                            image: AssetImage(categories[index].image,),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          alignment: categories[index].alignText,
                            padding:EdgeInsets.fromLTRB(categories[index].left,0, categories[index].right, 0),
                            child: Text(categories[index].title,textScaleFactor: 1.0,style: TextStyle(fontSize: 27,fontFamily: fArabicFont,color:categories[index].Textcolor),),), /* add child content here */
                      ),
                    ),
                    onDoubleTap: () {

                      currentCategory=index;
                      getUserName();
                      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown,DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]);
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              GraphQLProvider(
                                child: productScreen(),
                                client: configuration.client,),
                          ));
                    }
                    ,
                  );
                }
                ,
          );}
        ),


      ),
    );
  }
}
