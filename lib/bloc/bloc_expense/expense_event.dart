import 'package:expense_tracker/data/model/expense_model.dart';

sealed class ExpenseEvent{}


class InitializationEvent extends ExpenseEvent{}

class AddEvent extends ExpenseEvent{
  ExpenseModel addExpenseModel;
  AddEvent({required this.addExpenseModel});
}

class UpdateEvent extends ExpenseEvent{
  ExpenseModel updateExpenseModel;
  
  UpdateEvent({required this.updateExpenseModel});
}

class DeleteEvent extends ExpenseEvent{}