
import 'package:expense_tracker/bloc/bloc_expense/expense_bloc.dart';
import 'package:expense_tracker/bloc/bloc_expense/expense_event.dart';
import 'package:expense_tracker/data/model/date_wise_expense_model.dart';
import 'package:expense_tracker/data/model/expense_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddExpensePage extends StatefulWidget{
  num balance;

  AddExpensePage({required this.balance});
  
  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  
  
  String transactionType = 'Debit';
  
  DateFormat dateFormat = DateFormat.yMMMEd();
  DateTime expenseDate = DateTime.now();

  List<DateWiseExpenseModel> listDateWiseExpModel = [];
  
  
  
  Future<void> selectedDate(BuildContext context) async{
    final DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022, 1, 1),
        lastDate: DateTime.now()
    );
    if(selectedDate !=null){
      setState(() {
        expenseDate = selectedDate;
      });
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Exp'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder()
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: descController,
              decoration: const InputDecoration(
                labelText: 'Desc',
                  border: OutlineInputBorder()
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder()
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              child: DropdownButton(
                value: transactionType,
                onChanged: (value) {
                  setState(() {
                    transactionType = value!;
                  });
                },
                items: ["Debit", "Credit"].map((type) {
                  return DropdownMenuItem(
                    value: type,
                      child: Text(type,
                        style: const TextStyle(color: Colors.amber),
                      )
                  );
                }).toList()
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white
              ),
                onPressed: (){
                  context.read<ExpenseBloc>().add(
                      AddExpenseEvent(addExpenseModel: ExpenseModel(
                        title: titleController.text,
                        desc: descController.text,
                        exTime: expenseDate.microsecondsSinceEpoch.toString(),
                        amount: amountController.text.toString(),
                        type: transactionType,
                        userId: 0,
                        uid: 0,
                        balance: widget.balance.toString()
                        
                      )));
                }, 
                child: const Text('Save')
            )
          ],
        ),
      ),
    );
  }
  
  void filterExpenseDateWise({required List<ExpenseModel>allExpense} ){
    listDateWiseExpModel.clear();
    
    List<String> uniqueDates = [];
    
    for(ExpenseModel expenseModel in allExpense ){
      var createdAt = expenseModel.exTime;
      var mDateTime = DateTime.fromMicrosecondsSinceEpoch(int.parse(createdAt));
      var eachExpenseDate = dateFormat.format(mDateTime);
      
      print(eachExpenseDate);
      
      
      if(uniqueDates.contains(eachExpenseDate)){
        uniqueDates.add(eachExpenseDate);
      }
      print(uniqueDates);
    }
    
    
    for(String eachDate in uniqueDates){
      num totalExpAmt = 0.0;
      List<ExpenseModel> eachDateExpenses = [];
      
      for(ExpenseModel expenseModel in allExpense){
        var createdAt = expenseModel.exTime;
        var mDateTime = DateTime.fromMicrosecondsSinceEpoch(int.parse(createdAt));
        var eachExpenseDate = dateFormat.format(mDateTime);
        
        if(eachExpenseDate == eachDate){
          eachDateExpenses.add(expenseModel);
          
          if (expenseModel.type == "Debit"){
            totalExpAmt -= int.parse(expenseModel.amount);
          }else{
            totalExpAmt += int.parse(expenseModel.amount);
          }
        }
      }
      listDateWiseExpModel.add(DateWiseExpenseModel(
          date: eachDate,
          totalAmt: totalExpAmt.toString(),
          eachDateAllExpenses: eachDateExpenses
      ));
    }
  }
  
}