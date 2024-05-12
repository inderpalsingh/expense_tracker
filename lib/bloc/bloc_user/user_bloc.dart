
import 'package:expense_tracker/bloc/bloc_user/user_event.dart';
import 'package:expense_tracker/bloc/bloc_user/user_state.dart';
import 'package:expense_tracker/data/model/user_model.dart';
import 'package:expense_tracker/domain/repositories/local/db_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState>{

  DbConnection db;

  UserBloc({required this.db}):super(InitializationUserState()){

    on<InitializationUserEvent>((event, emit){
     emit(LoadingUserState());
     List<UserModel> mData = [];
     emit(SuccessfulUserState(getAllUserState: mData));
    });
    
    
    on<LoginUserEvent>((event, emit)async{
      emit(LoadingUserState());
      var checkLogin = await db.loginUser(email: event.email, pass: event.pass);
      if(checkLogin){
        var mData = await db.fetchUser();
        emit(SuccessfulUserState(getAllUserState: mData));
      }else{
        emit(FailureUserState(errorMsg: 'Not Logging'));
      }
    });

    on<AddUserEvent>((event, emit)async{
      emit(LoadingUserState());
      bool check = await db.signUpUser(userModel: event.userModel);
      if(check){
        List<UserModel> mData = [];
        emit(SuccessfulUserState(getAllUserState: mData));
      }else{
        emit(FailureUserState(errorMsg: 'Not added'));
      }
    });


  }



}