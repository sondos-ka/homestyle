import 'package:graphql_flutter/graphql_flutter.dart';
import 'constant.dart';
class DataBase{
  String userId;
  String userName;
  String password;
  DataBase({this.userId,this.userName,this.password});

  Future<QueryResult> sendData() async{
    String addData='''
     mutation create_User(\$username: String!, \$password: String!) {
  create_User( username: \$username, password: password) {
   objectId
    createdAt
  }
}
      ''';
    final variable ={
      "input":{
        "id" : userId,
        "username" : userName,
      }
    };


    GraphQLConfiguration configuration = GraphQLConfiguration();
    GraphQLClient client = configuration.clientToQuery();

    QueryResult queryResult = await client.query(
      QueryOptions(documentNode: gql(addData), variables: variable),
    );
    return queryResult;
  }

  }




const queryAddUser = '''
  mutation signUp( \$name:String!,\$password:String! ){
 objects{
  
  create_User(
    fields:{
    username:\$name
    password:\$password
   
    }
  )
 
  {
    objectId
    createdAt
  }
 
   
}
}
''';



const mutationLogInUser = '''
  mutation login( \$name:String!,\$password:String! ){
users{
  logIn(username:\$name,password:\$password){
    sessionToken
  }
  }  
}
''';


const findProductCategory="""
query (\$cat:Float!){
  objects{
    findproduct(where:{category:{_eq:\$cat}}){
      count
      results{
        productname
        image        
       
      }
    }
    
  }
  
}


""";


