import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:homestyle/roots/strings.dart';


int currentCategory=0;
String curUser="";
String curToken="";
String curReceiverObjectId="";
int curUnreadMessages=0;
int curAdminMessage=0;
String curUserObjectId="";

//logo
const Color cLogoColor= Color(0xFFf48e2c);
const Color clightOrange=Color(0xFFf4ae52);
const Color clogoBlack=Color(0xFF090909);
const Color croseBlue=Color(0xFF4d5b80);
const Color cchairBrown=Color(0xFF523e32);
const Color cBathroomGrey=Color(0xFF838377);
const Color cCat123=Color(0xFFdad1c8);
const Color cCat4=Color(0xFFbfb5b3);
const Color cCat5=Color(0xFFbfc0b8);
const Color cCat6=Color(0xFFc0c6d2);
const Color cCat7=Color(0xFFf2f0f1);
const Color cCat8=Color(0xFF93a1a4);
const Color cCat9=Color(0xFFe4e3e8);
const Color cCat10=Color(0xFFafb5b1);
const Color cCat11=Color(0xFFc7d9ef);
const Color cCat12=Color(0xFFefeff1);
const Color cCat13=Color(0xFFdceae0);


const String fLogoFont='Orbitron-Black';
const String fLogoDescrebtionFont= 'NothingYouCouldDo-Regular';
const String fArabicFont='Scheherazade-Regular';


////////////////////////////////////////Parse Server//////////////////////////////
String kParseApplicationId= "qFIHGyTUjOQnBYXTSgBCdY79XXVYd6Dh0JDgHrOx";
String kParseClientKey = "cxVMzfbQyUZj7cW5lEBGxMrI1mIZF6JMSzaBgmHD";
String kParseMasterKey = "Y9kvMgaL02oFJqf5xJywm6XSFcDN7jKjIv1Xe6BM";
String kUrl= "https://parseapi.back4app.com/graphql";
String fireBaseServerKey="AAAAggu222A:APA91bEDR1-PYD9peF8gcYk4iIKc61S9GvrGYi5abPivHg4JIVXj1JuGQZW86pgBybGp_0KwuutIMZb6NsQTjnqjvVcyFX-eDV80lBTXsHr6C8_h7ZXWCDXRySw0_ndofthVZCXjFOzY";
//////////////////////////////////////////////////////////////////////////////


class GraphQLConfiguration {
  static HttpLink httpLink = HttpLink(
    uri: kUrl,
    headers: {
      'X-Parse-Application-Id' : kParseApplicationId,
      'X-Parse-Client-Key' : kParseClientKey,
      'X-Parse-Master-Key': kParseMasterKey,
    },
  );


  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
    ),
  );


  GraphQLClient clientToQuery() {
    return GraphQLClient(
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
      link: httpLink,
    );
  }
}










Icon iPerson=Icon(Icons.person,color: clightOrange,);
Icon iPassword=Icon(Icons.lock_outline,color: clightOrange,);



/////////////////////////////menu Items////////////////////////////////
class menuItems{

  String title;
  String image;
  Alignment alignText;
  Alignment alignImage;
  Color Textcolor;
  double left=0;
  double right=0;



  menuItems({this.title,this.image,this.alignText,this.alignImage,this.Textcolor,this.right,this.left});

List<menuItems> createMenuItemList(){

List categories=List<menuItems>();


return categories
  ..add(menuItems(
  title: scat1,image: 'images/cat/cat1.png',alignImage: Alignment.centerLeft,alignText: Alignment.centerRight,Textcolor:Colors.black
      ,right: 80,left: 0
  ))
  ..add( menuItems(title: scat2,image:'images/cat/cat2.png',alignImage: Alignment.centerRight,alignText: Alignment.centerLeft,Textcolor:croseBlue,
      left: 20,right: 0
   ))
  ..add( menuItems(title: scat3,image: 'images/cat/cat3.png',alignImage: Alignment.centerRight,alignText: Alignment.bottomLeft,Textcolor:cchairBrown,
      left: 20,right: 0
     ))
  ..add( menuItems(title: scat4,image: 'images/cat/cat4.png',alignImage: Alignment.centerLeft,alignText: Alignment.centerRight,Textcolor: Colors.black,
    left: 0,right: 35
  ))
  ..add(menuItems(
      title: scat5,image: 'images/cat/cat5.png',alignImage: Alignment.centerRight,alignText: Alignment.centerLeft,Textcolor: croseBlue,
    left: 20,right: 0,
  ))
  ..add( menuItems(title: scat6,image:'images/cat/cat6.png',alignImage: Alignment.centerLeft,alignText: Alignment.centerRight,Textcolor: croseBlue,
    left: 0,right: 80
  ))
  ..add( menuItems(title: scat7,image: 'images/cat/cat7.png',alignImage: Alignment.centerRight,alignText: Alignment.centerLeft,Textcolor:cBathroomGrey,
    left: 50,right: 0
  ))
  ..add( menuItems(title: scat8,image: 'images/cat/cat8.png',alignImage: Alignment.centerLeft,alignText: Alignment.centerRight,Textcolor: Colors.white,
    left: 0,right: 50
  ))
  ..add(menuItems(
      title: scat9,image: 'images/cat/cat9.png',alignImage: Alignment.centerRight,alignText: Alignment.centerLeft,Textcolor: cBathroomGrey,
    left: 50,right: 0,
  ))
  ..add( menuItems(title: scat10,image:'images/cat/cat10.png',alignImage: Alignment.centerLeft,alignText: Alignment.centerRight,Textcolor: Colors.white,
    left: 0,right: 50
  ))
  ..add( menuItems(title: scat11,image: 'images/cat/cat11.png',alignImage: Alignment.centerRight,alignText: Alignment.centerLeft,Textcolor: Colors.black,
    left: 50,right: 0,
  ))
  ..add( menuItems(title: scat12,image: 'images/cat/cat12.png',alignImage: Alignment.centerLeft,alignText: Alignment.centerRight,Textcolor: croseBlue,
    left: 0,right: 80
  ))
  ..add( menuItems(title: scat13,image: 'images/cat/cat13.png',alignImage: Alignment.centerRight,alignText: Alignment.centerLeft,Textcolor:croseBlue,
    left: 60,right: 0,
  ));



}

}









