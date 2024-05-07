import '../data/model/user_model.dart';

sealed class UserState{}

class InitializationUserState extends UserState{}

class LoadingUserState extends UserState{}

class SuccessfulUserState extends UserState{
  List<UserModel> getAllUserState = [];
  SuccessfulUserState({required this.getAllUserState});
  
}

class FailerUserState extends UserState{
  String errorMsg;

  FailerUserState({required this.errorMsg});
}