

import '../../domain/repositories/local/db_repository.dart';

class ExpenseModel{

  int uid;
  String title;
  String desc;
  String exTime;
  String amount;
  String balance;
  
  
  ExpenseModel({required this.uid, required this.title, required this.desc, required this.exTime, required this.amount, required this.balance});
  
  
  
  /// model to map
  factory ExpenseModel.fromMap(Map<String,dynamic> map){
    return ExpenseModel(
        uid: map[DbConnection.TABLE_EXPENSE_ID],
        title: map[DbConnection.TABLE_EXPENSE_TITLE],
        desc: map[DbConnection.TABLE_EXPENSE_DESC],
        exTime: map[DbConnection.TABLE_EXPENSE_TIMESTAMP],
        amount: map[DbConnection.TABLE_EXPENSE_AMOUNT],
        balance: map[DbConnection.TABLE_EXPENSE_BALANCE]
    );
  }
  

  /// map to model
  
  Map<String, dynamic> toMap(){
    return{
      DbConnection.TABLE_EXPENSE_ID: uid,
      DbConnection.TABLE_EXPENSE_TITLE: title,
      DbConnection.TABLE_EXPENSE_DESC: desc,
      DbConnection.TABLE_EXPENSE_TIMESTAMP: exTime,
      DbConnection.TABLE_EXPENSE_AMOUNT: amount,
      DbConnection.TABLE_EXPENSE_BALANCE: balance
    };
  }
  
}