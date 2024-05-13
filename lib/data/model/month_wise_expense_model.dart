import 'expense_model.dart';

class MonthWiseExpenseModel{
  String month;
  String totalAmt;
  List<ExpenseModel> eachDateAllExpenses;

  MonthWiseExpenseModel({required this.month, required this.totalAmt, required this.eachDateAllExpenses});
}