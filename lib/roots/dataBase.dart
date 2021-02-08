import 'package:graphql_flutter/graphql_flutter.dart';
import 'constant.dart';
class DataBase{
  String userId;
  String userName;
  String password;
  DataBase({this.userId,this.userName,this.password});


  }




const queryAddUser = '''
 mutation Createuser(\$name:String!,\$password:String!){
        createUser(input:
          {
            fields:
            {username:\$name
             password:\$password
              
            }
          
          }) {
   user{
      objectId
    }
  }
  
          }
      
      

''';


const loginMutation="""
mutation LogIn(\$name:String!,\$password:String!){
  logIn(input: {
    username: \$name
    password: \$password
  }){
    viewer{
      
      sessionToken
    }
  }
}

""";







const mutationLogInUser = '''
mutation Createuser(\$name:String!,\$password:String!){
        createUser(input:
          {
            fields:
            {username:\$name
             password:\$password
              
            }
          
          }) {
   user{
      objectId
    }
  }
  
          }
      
      
''';




const query="""
query Favorite(\$userId:String!,\$cat:Float!){
  products(where:{category:{equalTo:\$cat}}
){
     count,
	    edges{
	      node{
	 objectId
	 productname
	  image
	      }
	    }
    
  }
  
  
  
  favorites(where:{userId:{equalTo: \$userId},category:{equalTo:\$cat}
  }){
	    count,
	    edges{
	      node{
	 objectId
	 productId
	 
	      }
	    }
	  }
}
""";

const addToFavorite='''

mutation CreateObject(\$productId:String!,\$userId:String!,\$cat:Float!){
        createFavorite(input:
          {
            fields:
            {userId:\$userId
              category:\$cat
              productId:\$productId
              
            }
          
          }) {
    favorite{
      objectId
    }
  }
  
          }
      
''';
const removeFromFavorite="""
mutation deleteFavorite(\$favoriteId:ID!){ 
  deleteFavorite (input:{id:\$favoriteId})     
  { 
    clientMutationId
  }
}

""";



const favoriteMutation="""

mutation CreateObject(\$productId:String!,\$userId:String!,\$cat:Float!,\$favoriteId:ID!
,\$message:String!,\$isSender:Boolean!,\$img:String!){
       
  deleteFavorite (input:{id:\$favoriteId})     
  { 
    clientMutationId
  }
  
  createFavorite(input:
          {
            fields:
            {userId:\$userId
              category:\$cat
              productId:\$productId
              
            }
          
          }) {
    favorite{
      objectId
    }
  }
  
  createChat(input:
          {
            fields:
            {userId:\$userId
           message:\$message
          isSender:\$isSender
          image:\$img            }
          
          }) {
    chat{
      objectId
      
    }
  }
  
  
}


  


""";

const getUserFavorite="""
query (\$userId:String!){
  favorites(where:{userId:{equalTo: \$userId}}){
	    count,
	    edges{
	      node{
	 objectId
	 productId	 
	   }
	  }	   
  }  
}

""";



const getProductFromId="""


query  (\$productId:[ID!]!){  
  products(where:{objectId:{in:\$productId}}, order: category_ASC
){
     count,
	    edges{
	      node{
	 objectId
	 productname
	image
	category
	      }
	    }
    
  }
  
  
  
  
}

""";

const getMessages="""
query (\$userId:String!){
  chats(where:{userId:{equalTo:\$userId}},order:createdAt_ASC){
     count,
	    edges{
	      node{
          userId
          createdAt
          message
          isSender
          isRead
          image
          
        }
        } 
      }
}""";

const mutationAddMessage="""
mutation CreateChat(\$userId:String!,\$message:String!,\$isSender:Boolean!,\$img:String!){
       
 
  createChat(input:
          {
            fields:
            {userId:\$userId
           message:\$message
          isSender:\$isSender
          image:\$img
              
            }
          
          }) {
    chat{
      objectId
      
    }
  }
  
  
  
}

  
          

  




""";
/*mutation delete_all_articles {
  objects{
    deleteFavorite(
    where: {productId:"nwV0PoSM1m" }
    )
    {
    affected_rows
    }
    */