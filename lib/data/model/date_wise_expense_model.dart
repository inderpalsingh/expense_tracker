import 'expense_model.dart';

class DateWiseExpenseModel{
  String date;
  String totalAmt;
  List<ExpenseModel> eachDateAllExpenses;

  DateWiseExpenseModel({required this.date, required this.totalAmt, required this.eachDateAllExpenses});
}