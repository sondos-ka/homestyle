import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:homestyle/roots/dataBase.dart';
import 'package:homestyle/roots/rootWidget.dart';

class testSceen extends StatefulWidget {
  @override
  _testSceenState createState() => _testSceenState();
}

class _testSceenState extends State<testSceen> {


  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: appBarWidget((){}),
      body:  Query(
          options: QueryOptions(
            variables: {'userId':'HnQKXFmH2y',
            'productId':'WdePSF7GsK'},
            documentNode: gql(checkProductFavorite),
          ),
          builder:(QueryResult result, { Refetch refetch,FetchMore fetchMore,})
          {
            if(result.data==null){
              return Center(child: Text("Loading...",style: TextStyle(fontSize: 20.0),));
            }
            else{
              final List results=result.data["objects"]["findFavorite"]["results"];
              return Text(results[0]["objectId"]);
            }
          },
      ),
    );
  }
}
