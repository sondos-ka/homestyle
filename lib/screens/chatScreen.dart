import 'dart:async';



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
import 'package:flutter/services.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';


final messageController = TextEditingController();
// final _cahtListController = ScrollController();
List messages = new List();
List waitMessage=new List();
List waitIsSender=new List();
List isSender = new List();
FocusNode messageFocusNode ;
final ItemScrollController itemScrollController = ItemScrollController();
final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();


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

                          } );
                        print('completed');

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
                            pollInterval: 3,
                            variables: {
                              'userId': currentUser,
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
                             List chat=result.data["chats"]["edges"];
                             messages.clear();
                            isSender.clear();

                             if(chat.length> 0) {
                               for (int i = 0; i < chat.length; i++) {
                                 messages.insert(i, chat[i]["node"]['message']) ;
                                 isSender.insert(i, chat[i]["node"]['isSender']) ;

                               }


                             }


                               return Column(
                                children: <Widget>[
                                  Expanded(
                                    child: ScrollablePositionedList.builder(
                                     /*  ,
                                        ,

                                        */


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
                                            backGroundColor: waitIsSender.length>0?(waitIsSender[index]
                                                ? cCat123
                                                : clightOrange):
                                            (isSender[index]
                                                ? cCat123
                                                : clightOrange),
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
                                                        6, 0, 6, 0),
                                                child: Text(
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
                                                ),
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
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8, 0, 8, 10),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            // height:50,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                80,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Padding(
                                              padding: const EdgeInsets.all(4),
                                              child: TextField(

                                                focusNode: messageFocusNode,
                                                  keyboardType:TextInputType.multiline,
                                                  maxLines: null,
                                                  textAlign: TextAlign.right,
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
                                                        EdgeInsets.fromLTRB(
                                                            16, 6, 16, 0),
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent),
                                                    ),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent),
                                                    ),

                                                  )
                                              ,
                                              ),
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



                                          setState(() {
                                            if (waitMessage.isEmpty) {
                                              for (int i = 0; i <
                                                  chat.length; i++) {
                                                waitMessage.insert(i,
                                                    chat[i]["node"]['message']);
                                                waitIsSender.insert(i,
                                                    chat[i]["node"]['isSender']);

                                              }

                                            }    waitMessage.insert(
                                                waitMessage.length,
                                                messageController.text);
                                            waitIsSender.insert(
                                                waitIsSender.length, true);



                                          });
                                                runMutation({'message':messageController.text, 'userId':currentUser,'isSender':true},);
                                             messageController.clear();
                                           messageFocusNode= FocusNode();
                                           messageFocusNode.requestFocus();
                                        /*  Timer(
                                              Duration(microseconds:2000),(){
                                                print("timer");
                                                print(waitMessage.length);
                                                itemScrollController.scrollTo(
                                                    index:waitMessage.length-1,
                                                    duration: Duration(milliseconds: 2000),
                                                    curve: Curves.easeInOutCubic);  //waitMessage.length>0?waitMessage.length-1:messages.length-1
                                          }
                                          );*/



                                              },

                                            ),
                                          )
                                        ],
                                      ),
                                    ),
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
    );
  }
}
