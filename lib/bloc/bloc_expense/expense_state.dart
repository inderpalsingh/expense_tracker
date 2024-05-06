import '../../data/model/expense_model.dart';

sealed class ExpenseState{}


class InitializationState extends ExpenseState{}

class LoadingState extends ExpenseState{}

class SuccessfulState extends ExpenseState{
  List<ExpenseModel> allExpenseState = [];
  SuccessfulState({required this.allExpenseState});
}

class FailureState extends ExpenseState{
  String errorMsg;
  
  FailureState({required this.errorMsg});
}