
import 'expense_model.dart';

class FilterExpenseModel{
  String title;
  String totalAmt;
  List<ExpenseModel> allExpenses;

  FilterExpenseModel({required this.title, required this.totalAmt, required this.allExpenses});
}