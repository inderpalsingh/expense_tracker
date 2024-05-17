import '../../data/model/expense_model.dart';

sealed class ExpenseState{}


class ExpenseInitialState extends ExpenseState{}

class ExpenseLoadingState extends ExpenseState{}

class ExpenseSuccessfulState extends ExpenseState{
  List<ExpenseModel> allExpenseState;
  ExpenseSuccessfulState({required this.allExpenseState});
}

class ExpenseFailureState extends ExpenseState{
  String errorMsg;

  ExpenseFailureState({required this.errorMsg});
}