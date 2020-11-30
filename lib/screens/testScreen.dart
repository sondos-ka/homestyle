import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:homestyle/roots/rootWidget.dart';

class testSceen extends StatefulWidget {
  @override
  _testSceenState createState() => _testSceenState();
}

class _testSceenState extends State<testSceen> {


  String query='''
  query getAGameScore {
  gameScore(id: "73pAQyx4gV") {
    id
    score
    playerName
    score
    cheatMode
    ACL {
      public {
        read
        write
      }
    }
  }
}
  ''';

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: appBarWidget((){}),
      body:  Query(
          options: QueryOptions(
            documentNode: gql(query),
          ),
          builder:(QueryResult result, { Refetch refetch,FetchMore fetchMore,})
          {
            if(result.data==null){
              return Center(child: Text("Loading...",style: TextStyle(fontSize: 20.0),));
            }
            else{
              return Text('done');
            }
          },
      ),
    );
  }
}
