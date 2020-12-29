import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:homestyle/roots/constant.dart';
import 'package:homestyle/roots/dataBase.dart';
import 'package:homestyle/roots/rootWidget.dart';
import 'package:homestyle/roots/strings.dart';
import 'package:homestyle/screens/productScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipedetector/swipedetector.dart';

import 'chatScreen.dart';
import 'loginScreen.dart';



class favoriteScreen extends StatefulWidget {
  @override
  _favoriteScreenState createState() => _favoriteScreenState();
}


class _favoriteScreenState extends State<favoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: clogoBlack,
        appBar: appBarWidget( ()async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('username');
      currentUser=null;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => GraphQLProvider(
            child:loginScreen(),
            client: configuration.client,),
          ));
    },
          Text(""),IconButton(
    icon:Icon( Icons.chat_bubble_outline,color: cLogoColor,size: 20),
    onPressed:(){

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => GraphQLProvider(
            child:chatScreen(),
            client: configuration.client,),
          ));
    }

    ),
    MediaQuery.of(context).size.width
    ),
    body: SafeArea(
      child:Mutation(
          options: MutationOptions(
              documentNode:
              gql(favoriteMutation)//
              // :gql(addToFavorite)
              ,
              update: (Cache cache, QueryResult result) {

                return cache;
              },
              onCompleted: (dynamic resultData)
              {
                print('completed');
              }
          ),

          builder: (RunMutation runMutation,
              QueryResult result,) {

            return GestureDetector(

              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    decoration: BoxDecoration(color: clogoBlack),
                    //the description code
                    child:  Center(
                      child: Text(sFavorite,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize:30,
                            fontFamily: fArabicFont,
                            fontWeight: FontWeight.w100),
                      ),
                    ),
                  ),


                 Container(
                    height: MediaQuery.of(context).size.height-136,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("images/background.jpg"),fit: BoxFit.cover),
                    ),

                    child: Query(
                      options: QueryOptions(
                        pollInterval: 10,
                        variables: {
                          'userId':currentUser,
                        },
                        documentNode: gql(getUserFavorite),
                      ),
                      builder:(QueryResult result, { Refetch refetch,FetchMore fetchMore,}) {
                        if (result.data == null) {
                          return SpinKitFadingCircle(
                            color: cLogoColor,
                            size: 60,
                          );
                        }

                        else {
                          List userFavorite= result.data["favorites"]["edges"];
                          List products=new List();
                          List objects=new List();
                          for(int i=0;i<userFavorite.length;i++){
                            products.insert(i, userFavorite[i]["node"]['productId']);
                            objects.insert(i, userFavorite[i]["node"]['objectId']);
                          }





                          return
                            Query(
                            options: QueryOptions(
                              pollInterval: 10,
                              variables: {
                                'productId': products

                              },
                              documentNode: gql(getProductFromId),
                            ),
                            builder: (QueryResult result2,
                                { Refetch refetch, FetchMore fetchMore,}) {
                              if (result2.data == null) {
                                return SpinKitFadingCircle(
                                  color: cLogoColor,
                                  size: 60,
                                );
                              }

                              else {
                                List productFavorite= result2.data["products"]["edges"];




                                return new StaggeredGridView.countBuilder(

                                  padding: EdgeInsets.all(16),
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  itemCount: productFavorite.length,
                                  itemBuilder: (BuildContext context,
                                      int index2) {
                                    return Stack(children: <Widget>[

                                      GestureDetector(

                                          child: ClipRRect(
                                            child: CachedNetworkImage(
                                              imageUrl: productFavorite[index2]["node"]['image'],


                                              fit: BoxFit.cover,
                                              placeholder: (_, s) =>
                                                  SpinKitFadingCircle(
                                                    color: cLogoColor,
                                                    size: 30,
                                                  ),
                                            ),
                                            borderRadius: BorderRadius
                                                .circular(8),
                                          ),

                                          onDoubleTap: () {
                                            //when upload the image is favorite return orange else return black

                                            showAnimatedDialog(
                                              context: context,
                                              builder: (_) {
                                                return StatefulBuilder(
                                                    builder: (
                                                        BuildContext context,
                                                        StateSetter setstate) {
                                                      return GestureDetector(
                                                        onLongPress: () {
                                                          showModalBottomSheet(
                                                              context: context,
                                                              builder: (
                                                                  context) {
                                                                return Text(
                                                                    '$index2');
                                                              }
                                                          );
                                                        },
                                                        child: SwipeDetector(


                                                          onSwipeRight: () {
                                                            setstate(() {
                                                              if (index2 >
                                                                  0) {
                                                                index2--;
                                                              }
                                                            });
                                                          },
                                                          onSwipeLeft: () {
                                                            setstate(() {
                                                              if (index2 <
                                                                  productFavorite
                                                                      .length -
                                                                      1) {
                                                                index2++;
                                                              }
                                                            });
                                                          },

                                                          child: Dialog(
                                                            backgroundColor: Colors
                                                                .transparent,
                                                            insetPadding: EdgeInsets
                                                                .only(
                                                                top: 60),
                                                            child: Stack(
                                                              alignment: Alignment
                                                                  .topLeft,
                                                              children: <
                                                                  Widget>[
                                                                ClipRRect(
                                                                  child: CachedNetworkImage(
                                                                    imageUrl:productFavorite[index2]["node"]['image'],
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    placeholder: (
                                                                        _,
                                                                        s) =>
                                                                        SpinKitFadingCircle(
                                                                          color: cLogoColor,
                                                                          size: 30,
                                                                        ),
                                                                  ),
                                                                  borderRadius: BorderRadius
                                                                      .circular(
                                                                      16),

                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                      10, 5,
                                                                      0, 0),
                                                                  child: Text(
                                                                    //need change this to item number
                                                                    productFavorite[index2]["node"]['productname'],
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight
                                                                            .bold,
                                                                        fontFamily: fLogoDescrebtionFont,
                                                                        fontSize: 20,
                                                                        color: cLogoColor,
                                                                        backgroundColor: Colors
                                                                            .transparent),),
                                                                ),Container(
                                                                  padding: EdgeInsets.fromLTRB(10,30,0,0),
                                                                    child: GestureDetector(

                                                                      child: Icon(
                                                                        Icons.delete,
                                                                        color: cLogoColor,
                                                                        size: 30,)
                                                                      ,
                                                                      onTap: (){
                                                                        showAnimatedDialog(
                                                                            context: context,
                                                                            builder: (_) {
                                                                              return costumDialoge('images/delete3.gif',sMessageRemoveAlert,sOk,(){
                                                                                Navigator.pop(context);
                                                                                Navigator.pop(context);
                                                                                int productIndex=products.indexOf(productFavorite[index2]["node"]['objectId']);
                                                                                var objectId = objects[productIndex];

                                                                                runMutation({'favoriteId':objectId,'productId':'', 'userId':'','cat':0});
                                                                                setState(() {
                                                                                  products.remove(productIndex);
                                                                                });
                                                                              }
                                                                              );
                                                                            });
                                                                      },))

                                                              ],
                                                            ),

                                                          ),
                                                        ),
                                                      );
                                                    });
                                              },
                                              animationType: DialogTransitionType
                                                  .slideFromRight,
                                              curve: Curves.fastOutSlowIn,
                                              duration: Duration(
                                                  seconds: 1),
                                            );
                                          }

                                      ),
                                    Container(
                                    child: GestureDetector(

                                    child: Icon(
                                    Icons.cancel,
                                    color: cLogoColor,
                                    size: 20,)
                                    ,
                                    onTap: (){
                                      showAnimatedDialog(
                                          context: context,
                                          builder: (_) {
                                            return costumDialoge('images/delete3.gif',sMessageRemoveAlert,sOk,(){
                                              Navigator.pop(context);
                                              int productIndex=products.indexOf(productFavorite[index2]["node"]['objectId']);
                                              var objectId = objects[productIndex];

                                              runMutation({'favoriteId':objectId,'productId':'', 'userId':'','cat':0});
                                              setState(() {
                                                products.remove(productIndex);
                                              });
                                            }
                                            );
                                          });
                                    },))

                                    ],
                                    );
                                  },
                                  staggeredTileBuilder: (int index) =>
                                  new StaggeredTile.fit(1),
                                );
                              }
                            },

                          );
                        }
                      } )

                  ),


                ],
              ),
            );
          }
      ),
    ));
  }
}
