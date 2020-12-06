import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:homestyle/roots/constant.dart';
import 'package:homestyle/roots/dataBase.dart';
import 'package:homestyle/roots/rootWidget.dart';
import 'package:homestyle/roots/strings.dart';
import 'package:homestyle/screens/menuScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class loginScreen extends StatefulWidget {
  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen>   with TickerProviderStateMixin{

  String username;
  String password;
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  DataBase dataBase;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: true,

      body:SingleChildScrollView(
        child:Container(

        decoration: BoxDecoration(
         image: DecorationImage(image: AssetImage("images/backgroundWithGift.png"), fit: BoxFit.cover),
                 ),




                 child: Row(
                   crossAxisAlignment: CrossAxisAlignment.end,
                   children: <Widget>[
                     Column(

                       children: <Widget>[
                         SizedBox(height: (MediaQuery.of(context).size.height/3)*2-70),
                         TweenAnimationBuilder(
                           duration: Duration(seconds: 2),
                           tween:AlignmentGeometryTween(begin: Alignment.bottomLeft,end: Alignment.topLeft),
                           builder:(_, align, a) {
                             return Container(
                               alignment: align,
                               decoration: BoxDecoration(color: clogoBlack),
                               height:(MediaQuery.of(context).size.height/3)+70,
                               child: Container(
                                 height:(MediaQuery.of(context).size.height/3+50),
                                 width:  (MediaQuery.of(context).size.width/3+100) ,
                              
                                 child: Padding(
                                   padding: const EdgeInsets.only(left:15),
                                   child: Column(
                                     children: <Widget>[

                                       Container(

                                           child: Image.asset('images/logoHomeScreen.png'))
                                       ,
                                       SizedBox(height: 40,)
                                       ,
                                       Container(
                                           height: 40,
                                           child: textInputDecoration(sUserName,iPerson,TextInputType.text,false,nameController
                                          ))
                                       ,
                                       SizedBox(height: 20,)
                                       ,
                                       Container(
                                           height: 40,
                                           child: textInputDecoration(sPassword,iPassword,TextInputType.number,true,passwordController))
                                       ,
                                       SizedBox(height: 10,)
                                       ,
                                       Mutation(
                                        options: MutationOptions(
                                        documentNode: gql(queryAddUser), // this is the mutation string you just created
                                        ),
                                        builder: (
                                        RunMutation runMutation,
                                        QueryResult result,
                                        ) {
                                        return awsomeButton(sLogin,()async{
                                         username=nameController.text;
                                         password=passwordController.text;
                                         if(username!=null&& password!=null){
                                           runMutation({'name':username,'password':password});
                                           SharedPreferences prefs = await SharedPreferences.getInstance();
                                           prefs.setString('username', username);
                                           if(result.data!=null){
                                             print('success');}
                                         }


                                         Navigator.pushReplacement(
                                           context,
                                           MaterialPageRoute(builder: (context) => menuScreen()),
                                         );

                                       });}
    )
                                     ],
                                   ),
                                 ),
                               ),
                             );
                           },
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
                             duration: Duration(seconds: 1),
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
      ),
    );
  }
}
