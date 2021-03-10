import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:homestyle/roots/strings.dart';

import 'constant.dart';



Widget appBarWidget(Function logout,Widget favorite,Widget chat,double width ){
  return  width<500? AppBar(  leading: BackButton(
      color: cLogoColor),
    titleSpacing: 0,
    title:Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
      child:   Container(
        width:450,
        height: 81,
        child: Row(
          children: <Widget>[
            Container(
              height: 50,
              width: 30,
              child: favorite,

            )

          ,SizedBox(width: 20,),
            Container(
                width:200,
                height: 81,
                child: Hero(
                    tag: 'logo',child: Image.asset('images/logoHomeScreen.png'))),
            SizedBox(width: 20,),
          Container(
            height: 50,
              width: 30,

              child: chat


      ),SizedBox(width: 10,),
            Container(
              height: 50,
              width: 30,
              child: IconButton(

                icon:Icon( Icons.power_settings_new,color: cLogoColor,size: 22,),
                onPressed:logout

            ),
            )

          ],
        ),
      ),
    ) ,

    backgroundColor: clogoBlack,
  ):appBarMenuWidget(logout, favorite, chat);
}


//AppBar Background and image
Widget appBarMenuWidget(Function logout,Widget favorite,Widget chat  ){
  return AppBar(   leading: BackButton(
      color: cLogoColor),
   title:Padding(
   padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
    child:   Container(
    width:250,
    height: 81,

    child: Hero(
      tag: 'logo',
        child: Image.asset('images/logoHomeScreen.png')),
  ),
) ,

  actions: <Widget>[
  Container(child: favorite


  ),
  Container(child: chat),

    Container(child: IconButton(
    icon:Icon( Icons.power_settings_new,color: cLogoColor,size: 22,),
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




Widget bottomSheet(String s){

     Container(
       height: 50,
      padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
      child: Text('bottom sheet $s',style: TextStyle(color: Colors.white),),

    );
}



Widget costumDialoge (String image,String message,String textButton,Function onPressed){
  return Dialog(shape:RoundedRectangleBorder(
    borderRadius:BorderRadius.circular(16),
      ),
      elevation: 0,
    backgroundColor: Colors.transparent,
    child:Container(

      height: 300,
      decoration: BoxDecoration(
        color:Color(0XFF232323),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(17),
        boxShadow: [BoxShadow(
          color: clightOrange,
          blurRadius: 5.0,
          offset: Offset(0.0,3.0),
        )]
      ),
      child: Center(
        child: Column(children: <Widget>[
          Container(
            height: 100,
            child: Image.asset(image),),

          Container(
            padding: EdgeInsets.fromLTRB(20,10,20,0),
            child: Text(

              message,
              textAlign:TextAlign.center,
              style:TextStyle(

              fontFamily: fArabicFont,


              fontSize: 25.0,

            ) ,),
          ),
          SizedBox(height: 15,)
          ,Align(
            alignment: Alignment.bottomCenter,
            child:RaisedButton(
              color: clightOrange,
              child: Text(textButton,style: TextStyle(fontWeight:FontWeight.w200,fontSize: 25,fontFamily: fArabicFont),),
              onPressed: () { onPressed();},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0)),)
          )


        ],
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,),
      ),

    ) ,
   );

}

//MediaQuery.of(context).size.width
//
//


Widget chatWriteMessage(width,messageFocusNode,messageController,Function onPressed){
  return Padding(
    padding: const EdgeInsets.fromLTRB(
        8, 0, 8, 10),
    child: Row(
      children: <Widget>[
        Container(
          width: width - 80,
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
              onPressed();
              },

          ),
        )
      ],
    ),
  );
}

