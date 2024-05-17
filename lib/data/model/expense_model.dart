import '../../domain/repositories/local/db_repository.dart';

class ExpenseModel {
  int eid;
  int userId;
  int catId;
  String title;
  String desc;
  String exTime;
  String amount;
  String balance;
  String type;

  ExpenseModel(
      {required this.eid,
      required this.userId,
      required this.catId,
      required this.title,
      required this.desc,
      required this.exTime,
      required this.amount,
      required this.balance,
      required this.type});

  /// model to map
  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
        eid: map[DbConnection.TABLE_EXPENSE_ID],
        userId: map[DbConnection.TABLE_USER_ID],
        title: map[DbConnection.TABLE_EXPENSE_TITLE],
        desc: map[DbConnection.TABLE_EXPENSE_DESC],
        exTime: map[DbConnection.TABLE_EXPENSE_TIMESTAMP],
        amount: map[DbConnection.TABLE_EXPENSE_AMOUNT],
        balance: map[DbConnection.TABLE_EXPENSE_BALANCE],
        type: map[DbConnection.TABLE_EXPENSE_TYPE],
        catId: map[DbConnection.TABLE_COLUMN_CATID]);
  }

  /// map to model

  Map<String, dynamic> toMap() {
    return {
      
      DbConnection.TABLE_EXPENSE_TITLE: title,
      DbConnection.TABLE_EXPENSE_DESC: desc,
      DbConnection.TABLE_EXPENSE_TIMESTAMP: exTime,
      DbConnection.TABLE_EXPENSE_AMOUNT: amount,
      DbConnection.TABLE_EXPENSE_BALANCE: balance,
      DbConnection.TABLE_EXPENSE_TYPE: type,
      DbConnection.TABLE_COLUMN_CATID: catId,
      DbConnection.TABLE_USER_ID: userId
    };
  }
}
