
import '../../domain/repositories/local/db_repository.dart';

class UserModel{
  int uid;
  String name;
  String email;
  String pass;
  
  UserModel({this.uid=0, required this.name, required this.email, required this.pass });
  
  
  //// model to map

  factory UserModel.fromMap(Map<String,dynamic> map){
    return UserModel(
      uid: map[DbConnection.TABLE_USER_ID],
      name: map[DbConnection.TABLE_USER_NAME],
      email: map[DbConnection.TABLE_USER_EMAIL],
      pass: map[DbConnection.TABLE_USER_PASS]
    );
  }



  //// map to model
  
  Map<String, dynamic> toMap(){
    return{
      DbConnection.TABLE_USER_NAME: name,
      DbConnection.TABLE_USER_EMAIL: email,
      DbConnection.TABLE_USER_PASS: pass
    };
  }
  
  
}