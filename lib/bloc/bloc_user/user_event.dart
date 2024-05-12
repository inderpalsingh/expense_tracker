import 'package:expense_tracker/data/model/user_model.dart';

sealed class UserEvent{}

class InitializationUserEvent extends UserEvent{}

class AddUserEvent extends UserEvent{
  UserModel userModel;
  AddUserEvent({required this.userModel});


}
class LoginUserEvent extends UserEvent{
  String email;
  String pass;
  LoginUserEvent({required this.email, required this.pass});
}



