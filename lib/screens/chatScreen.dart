import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:homestyle/roots/constant.dart';
import 'package:homestyle/roots/dataBase.dart';
import 'package:homestyle/roots/rootWidget.dart';
import 'package:homestyle/roots/strings.dart';
import 'package:homestyle/screens/productScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'favoriteScreen.dart';
import 'loginScreen.dart';
import 'package:homestyle/roots/notification.dart';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;


import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';



// final _cahtListController = ScrollController();
List messages = new List();
List isSender = new List();
List img=new List();
List <String>waitMessage=new List();
List <bool> waitIsSender=new List();
List <String> waitImage=new List();

final messageController = TextEditingController();
FocusNode messageFocusNode ;
final ItemScrollController itemScrollController = ItemScrollController();
final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

Future<Map<String, dynamic>> sendAndRetrieveMessage() async {
  await firebaseMessaging.requestNotificationPermissions(
    const IosNotificationSettings(
        sound: true, badge: true, alert: true, provisional: false),
  );

  await http.post(
    'https://fcm.googleapis.com/fcm/send',
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key=$fireBaseServerKey',
    },
    body: jsonEncode(
      <String, dynamic>{
        'notification': <String, dynamic>{
          'body': 'this is a body',
          'title': 'this is a title'
        },
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': '1',
          'status': 'done'
        },
        'to': curToken,
      },
    ),
  );
}


bool checkIsImage(int i,List list1,List list2){
  if(list1.length>0)
    {
      if(list1[i]==''){
        return false;
      }

      return true;
    }
  else {

    if(list2[i]==''){
      return false;
    }

    return true;
  }






}


class chatScreen extends StatefulWidget {
  @override
  _chatScreenState createState() => _chatScreenState();
}

class _chatScreenState extends State<chatScreen> {

  @override
  void initState() {

    super.initState();


  }



  @override
  Widget build(BuildContext context) {

    return
      MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
    child: Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: true,backgroundColor: clogoBlack,
      appBar: appBarWidget(() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('username');
        currentUser = null;
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => GraphQLProvider(
                child: loginScreen(),
                client: configuration.client,
              ),
            ));
      },
    Mutation(
          options: MutationOptions(

          documentNode: //isFavorite?
          gql(setUnreadMessagesZero)//
        // :gql(addToFavorite)
        ,
        update: (Cache cache, QueryResult result) {

          return cache;
        },
        onCompleted: (dynamic resultData)
        {
         //update current user messages to zero
        }
    ),


    builder: (RunMutation runMutation1,
    QueryResult result,) {

    return Query(
      options: QueryOptions(
      documentNode: gql(getAdminObjectId),
      ),
      builder:(QueryResult resultAppBar, { Refetch refetch,FetchMore fetchMore,}) {

         if(resultAppBar.data!=null){
         runMutation1({'objectId':curUserObjectId});
         curReceiverObjectId=resultAppBar.data["users"]["edges"][0]["node"]["objectId"];}



        return Text("");});},
    ),
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
          child: Mutation(
              options: MutationOptions(
                  documentNode: //isFavorite?
                      gql(mutationAddMessage) //
                  // :gql(addToFavorite)
                  ,
                  update: (Cache cache, QueryResult result) {
                    return cache;
                  },
                  onCompleted: (dynamic resultData) {

                   Timer(
                          Duration(
                             milliseconds:3500),
                             () {
                              waitIsSender.clear();
                              waitMessage.clear();
                              waitImage.clear();

                          } );

                  // MyNotification myNotification=MyNotification();
                  // myNotification.sendFcmMessage("FINALLY","send message");

                  }),
              builder: (
                RunMutation runMutation,
                QueryResult result,
              ) {
                return Column(
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
                      child: Query(
                          options: QueryOptions(
                            pollInterval: 4,
                            variables: {
                              'userId': currentUser,
                              'adminId':"admin"
                            },
                            documentNode: gql(getMessages),
                          ),
                          builder: (
                            QueryResult result, {
                            Refetch refetch,
                            FetchMore fetchMore,
                          }) {
                            if (result.data == null) {
                              return SpinKitFadingCircle(
                                color: cLogoColor,
                                size: 60,
                              );
                            } else {

                           //   messageFocusNode.requestFocus();

                              //get the admin message count to increase it
                              curAdminMessage=result.data["users"]["edges"][0]["node"]["unreadMessages"];
                              var tokenResult=result.data["sessions"]["edges"];
                              curToken=tokenResult[0]["node"]["sessionToken"];

                             List chat=result.data["chats"]["edges"];
                             messages.clear();
                            isSender.clear();
                            img.clear();

                             if(chat.length> 0) {
                               for (int i = 0; i < chat.length; i++) {
                                 messages.insert(i, chat[i]["node"]['message']) ;
                                 isSender.insert(i, chat[i]["node"]['isSender']) ;
                                 img.insert(i, chat[i]["node"]['image']);
                               }


                             }


                               return Column(
                                children: <Widget>[
                                  Expanded(
                                    child: ScrollablePositionedList.builder(

                                        physics: const AlwaysScrollableScrollPhysics (),

                                     initialScrollIndex:messages.length-1,

                                       // addAutomaticKeepAlives: true,
                                        itemScrollController: itemScrollController,
                                        itemPositionsListener: itemPositionsListener,
                                        itemCount: waitMessage.length>0? waitMessage.length:messages.length,
                                        // itemExtent:(MediaQuery.of(context).size.height-80)/5,
                                        itemBuilder:
                                            (BuildContext context, int index) {


                                          return ChatBubble(
                                            clipper: ChatBubbleClipper6(
                                              type:waitIsSender.length>0?(
                                              waitIsSender[index]
                                                  ? BubbleType.sendBubble
                                                  : BubbleType.receiverBubble):
                                              (
                                                  isSender[index]
                                                      ? BubbleType.sendBubble
                                                      : BubbleType.receiverBubble)
                                              ,
                                            ),
                                            alignment:waitIsSender.length>0?( waitIsSender[index]
                                                ? Alignment.topRight
                                                : Alignment.topLeft):( isSender[index]
                                                ? Alignment.topRight
                                                : Alignment.topLeft),
                                            margin: EdgeInsets.all(5),
                                            backGroundColor:

                                            waitIsSender.length>0?(waitIsSender[index]
                                                ? cCat123
                                                : Colors.grey[800]):
                                            (isSender[index]
                                                ? cCat123
                                                : Colors.grey[800]),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                maxWidth: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.7,
                                              ),

                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        14, 0, 8, 0),
                                                child: checkIsImage(index, waitImage, img)?
                                                Container(
                                                  color: Colors.transparent,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: <Widget>[
                                                      ClipRRect(
                                                        child: CachedNetworkImage(
                                                          imageUrl:waitImage.length>0?waitImage[index]:img[index],
                                                          fit: BoxFit.cover,
                                                          placeholder: (_,s)=>
                                                              SpinKitFadingCircle(
                                                                color: cLogoColor,
                                                                size: 30,
                                                              ),
                                                        ),
                                                        borderRadius:BorderRadius.circular(8) ,
                                                      ),
                                                      SizedBox(height: 3,),
                                                      Text( waitMessage.length>0?
                                                      waitMessage[index]:messages[index],
                                                        /*index < messages.length ?
                                                  messages[index]: wait[index-messages.length],*/
                                                        textAlign: TextAlign.right,
                                                        style: TextStyle(
                                                          color:waitIsSender.length>0?( waitIsSender[index]
                                                              ? clogoBlack
                                                              : Colors.white):( isSender[index]
                                                              ? clogoBlack
                                                              : Colors.white),
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w200,
                                                        ),)

                                                    ],
                                                  ),
                                                ):

                                                Text(
                                                  waitMessage.length>0?
                                                  waitMessage[index]:messages[index],
                                                  /*index < messages.length ?
                                                  messages[index]: wait[index-messages.length],*/
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                    color:waitIsSender.length>0?( waitIsSender[index]
                                                        ? clogoBlack
                                                        : Colors.white):( isSender[index]
                                                        ? clogoBlack
                                                        : Colors.white),
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w200,
                                                  ),
                                                )
                                                ,
                                              ),
                                            ),
                                          );

                                        }
                                        ),


                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: chatWriteMessage(MediaQuery.of(context).size.width,messageFocusNode,messageController,()async{
                                      setState(() {

                                    if (waitMessage.isEmpty && chat.length>0) {
                                          //todo
                                          for (int i = 0; i <
                                              chat.length; i++) {
                                            waitMessage.insert(i,
                                                chat[i]["node"]['message']);
                                            waitIsSender.insert(i,
                                                chat[i]["node"]['isSender']);
                                            waitImage.insert(i,
                                                chat[i]["node"]['image']);
                                            print("i in if condation $i");
                                          }
                                        }
                                    String curMessage=messageController.text;




                                     //add time because I had an exception when send first message with wait it disappear
                                     Timer(Duration(milliseconds:waitMessage.length>0?0:400),(){
                                        waitMessage.insert(
                                          waitMessage.length,
                                          curMessage
                                        // messageController.text
                                      );
                                      waitIsSender.insert(
                                          waitIsSender.length, true);
                                      waitImage.insert(waitImage.length,
                                          '');
                                      print("add this message ");

                                      print(waitIsSender[0]);
                                      })   ;


                                      });
                                      curAdminMessage++;

                                      runMutation({'message':messageController.text, 'userId':currentUser,'isSender':true,'img':'','objectId':curReceiverObjectId,'adminMessagesCount':curAdminMessage},);
                                      messageController.clear();
                                      messageFocusNode= FocusNode();
                                      messageFocusNode.requestFocus();
                                      await sendAndRetrieveMessage();

                                    })
                                  ),
                                ],
                              );
                            }
                          }),
                    )
                  ],
                );
              }),
        ),
      ),
    ));
  }
}
