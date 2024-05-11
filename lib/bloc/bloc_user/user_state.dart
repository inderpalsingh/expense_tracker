
import '../../data/model/user_model.dart';

sealed class UserState{}

class InitializationUserState extends UserState{}

class LoadingUserState extends UserState{}

class SuccessfulUserState extends UserState{
  List<UserModel> getAllUserState = [];
  SuccessfulUserState({required this.getAllUserState});
  
}

class FailureUserState extends UserState{
  String errorMsg;

  FailureUserState({required this.errorMsg});
}