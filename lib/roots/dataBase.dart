import 'package:graphql_flutter/graphql_flutter.dart';
import 'constant.dart';
class DataBase{
  String userId;
  String userName;
  String password;
  DataBase({this.userId,this.userName,this.password});


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


//check favorite
const checkProductFavorite=

""" query (\$userId: String! ,\$productId:String!) {
objects{
findFavorite(where:{userId:{_eq:\$userId},
productId:{_eq:\$productId}
}){
count
results{
objectId

}
}

}

}
""";