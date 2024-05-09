import 'package:expense_tracker/bloc/bloc_expense/expense_event.dart';
import 'package:expense_tracker/bloc/bloc_expense/expense_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_tracker/data/model/expense_model.dart';
import 'package:expense_tracker/domain/repositories/local/db_repository.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState>{
  
  DbConnection db;
  
  ExpenseBloc({required this.db}): super(InitializationState()){
    
    on<FetchExpenseEvent>((event, emit)async{
      emit(LoadingState());
      List<ExpenseModel> mData = await db.fetchExpense();
      emit(SuccessfulState(allExpenseState: mData));
      
    });
    
    on<AddExpenseEvent>((event, emit)async {
      emit(LoadingState());
      bool check = await db.addExpense(expenseModel: event.addExpenseModel);
      
      if(check){
        List<ExpenseModel> mData = await db.fetchExpense();
        emit(SuccessfulState(allExpenseState: mData));
      }else{
        emit(FailureState(errorMsg: 'Something went wrong !!'));
      }
    });
    
  }
  
  
}