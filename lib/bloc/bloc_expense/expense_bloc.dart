import 'package:expense_tracker/bloc/bloc_expense/expense_event.dart';
import 'package:expense_tracker/bloc/bloc_expense/expense_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_tracker/data/model/expense_model.dart';
import 'package:expense_tracker/domain/repositories/local/db_repository.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState>{
  
  DbConnection db;
  
  ExpenseBloc({required this.db}): super(ExpenseInitialState()){
    
    on<FetchExpenseInitialEvent>((event, emit)async{
      emit(ExpenseLoadingState());
      var mData = await db.fetchExpense();
      emit(ExpenseSuccessfulState(allExpenseState: mData));
      
    });
    
    on<AddExpenseEvent>((event, emit)async {
      emit(ExpenseLoadingState());
      bool check = await db.addExpense(expenseModel: event.addExpenseModel);
      
      if(check){
        var mData = await db.fetchExpense();
        emit(ExpenseSuccessfulState(allExpenseState: mData));
      }else{
        emit(ExpenseFailureState(errorMsg: 'Expense not added'));
      }
    });
    
  }
  
  
}