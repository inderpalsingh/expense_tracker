import 'package:expense_tracker/bloc/bloc_expense/expense_bloc.dart';
import 'package:expense_tracker/bloc/bloc_expense/expense_event.dart';
import 'package:expense_tracker/data/model/date_wise_expense_model.dart';
import 'package:expense_tracker/data/model/expense_model.dart';
import 'package:expense_tracker/data/model/month_wise_expense_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../data/model/filter_expense_model.dart';
import '../../custom_ui/app_constant.dart';
import '../../custom_ui/custom_button.dart';

class AddExpensePage extends StatefulWidget {
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
  DateFormat monthFormat = DateFormat.LLLL();
  DateFormat yearFormat = DateFormat.y();
  DateTime expenseDate = DateTime.now();

  var selectedCategoryIndex = -1;

  List<DateWiseExpenseModel> listDateWiseExpModel = [];
  List<MonthWiseExpenseModel> listMonthWiseExpModel = [];
  List<FilterExpenseModel> listFilterExpModel = [];

  Future<void> selectedDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022, 1, 1),
        lastDate: DateTime.now());
    if (selectedDate != null) {
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
                  labelText: 'Title', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: descController,
              decoration: const InputDecoration(
                  labelText: 'Desc', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(
                  labelText: 'Amount', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton(
                      value: transactionType,
                      onChanged: (value) {
                        setState(() {
                          transactionType = value!;
                        });
                      },
                      items: ["Debit", "Credit"].map((type) {
                        return DropdownMenuItem(value: type, child: Text(type));
                      }).toList()),
                ],
              ),
            ),
            Center(
              child: CustomButton(
                name: "Choose Expense",
                mWidget: selectedCategoryIndex != -1
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppConstants.mCategories[selectedCategoryIndex].catTitle,
                            style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ) : null,
                onTap: () {
                  showModalBottomSheet(
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
                      context: context,
                      builder: (context) {
                        return GridView.builder(
                            itemCount: AppConstants.mCategories.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                            itemBuilder: (context, index) {
                              var eachCategory = AppConstants.mCategories[index];
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedCategoryIndex = index;
                                    //eachCat.catId;
                                    //select id instead
                                  });
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.cyan.shade100,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Image.asset(eachCategory.catImgPath),
                                  ),
                                ),
                              );
                            });
                      });
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                selectedDate(context);
              },
              child: Text(DateFormat.yMMMMd().format(expenseDate)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                context.read<ExpenseBloc>().add(AddExpenseEvent(
                    addExpenseModel: ExpenseModel(
                        title: titleController.text,
                        desc: descController.text,
                        exTime: expenseDate.microsecondsSinceEpoch.toString(),
                        amount: amountController.text.toString(),
                        type: transactionType,
                        userId: 0,
                        uid: 0,
                        balance: widget.balance.toString())));
                Navigator.pop(context);
              },
              child: const Text('Save'),
            )
          ],
        ),
      ),
    );
  }

  void filterExpenseDateWise({required List<ExpenseModel> allExpense}) {
    listDateWiseExpModel.clear();

    List<String> uniqueDates = [];

    for (ExpenseModel expenseModel in allExpense) {
      var createdAt = expenseModel.exTime;
      var mDateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(createdAt));
      var eachExpenseDate = dateFormat.format(mDateTime);

      print(eachExpenseDate);

      if (uniqueDates.contains(eachExpenseDate)) {
        uniqueDates.add(eachExpenseDate);
      }
      print(uniqueDates);
    }

    for (String eachDate in uniqueDates) {
      num totalExpAmt = 0.0;
      List<ExpenseModel> eachDateExpenses = [];

      for (ExpenseModel expenseModel in allExpense) {
        var createdAt = expenseModel.exTime;
        var mDateTime =
            DateTime.fromMillisecondsSinceEpoch(int.parse(createdAt));
        var eachExpenseDate = dateFormat.format(mDateTime);

        if (eachExpenseDate == eachDate) {
          eachDateExpenses.add(expenseModel);

          if (expenseModel.type == "Debit") {
            totalExpAmt -= int.parse(expenseModel.amount);
          } else {
            totalExpAmt += int.parse(expenseModel.amount);
          }
        }
      }
      listDateWiseExpModel.add(DateWiseExpenseModel(
          date: eachDate,
          totalAmt: totalExpAmt.toString(),
          eachDateAllExpenses: eachDateExpenses));
    }
  }

  void filterExpenseMonthWise({required List<ExpenseModel> allExpense}) {
    List<String> uniqueMonth = [];
    

    for (ExpenseModel expenseModel in allExpense) {
      var createdAt = expenseModel.exTime;
      var mMonth = DateTime.fromMillisecondsSinceEpoch(int.parse(createdAt));
      var eachExpenseMonth = monthFormat.format(mMonth);

      if (uniqueMonth.contains(eachExpenseMonth)) {
        uniqueMonth.add(eachExpenseMonth);
      }
    }

    for (String eachMonth in uniqueMonth) {
      num monthTotalExpAmt = 0.0;
      List<ExpenseModel> eachMonthExpense = [];
      

      for (ExpenseModel expenseModel in allExpense) {
        var createdAt = expenseModel.exTime;
        var mMonth = DateTime.fromMillisecondsSinceEpoch(int.parse(createdAt));
        var eachExpenseMonth = monthFormat.format(mMonth);
        

        if (eachExpenseMonth == eachMonth) {
          eachMonthExpense.add(expenseModel);
          if (expenseModel.type == "Debit") {
            monthTotalExpAmt -= int.parse(expenseModel.amount);
          } else {
            monthTotalExpAmt += int.parse(expenseModel.amount);
          }
        }
      }
      listMonthWiseExpModel.add(MonthWiseExpenseModel(
          month: eachMonth,
          totalAmt: monthTotalExpAmt.toString(),
          eachDateAllExpenses: eachMonthExpense));
    }
  }

  void filterExpenseYearWise({required List<ExpenseModel> allExpense}) {
    List<String> uniqueYear = [];

    for (ExpenseModel expenseModel in allExpense) {
      var createdAt = expenseModel.exTime;
      var mDateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(createdAt));
      var eachExpenseYear = monthFormat.format(mDateTime);
      var eachExpenseMonth = monthFormat.format(mDateTime);

      var eachExpenseMonthYear = "$eachExpenseMonth-$eachExpenseYear";

      if (!uniqueYear.contains(eachExpenseMonthYear)) {
        uniqueYear.add(eachExpenseMonthYear);
      }
    }

    for (String eachYear in uniqueYear) {
      num yearTotalExpAmt = 0.0;
      List<ExpenseModel> eachYearExpense = [];

      for (ExpenseModel expenseModel in allExpense) {
        var createdAt = expenseModel.exTime;
        var mDateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(createdAt));
        var eachExpenseMonth = monthFormat.format(mDateTime);
        var eachExpenseYear = yearFormat.format(mDateTime);

        var eachExpenseMonthYear = "$eachExpenseMonth-$eachExpenseYear";

        if (eachExpenseMonthYear == eachYear) {
          eachYearExpense.add(expenseModel);
          if (expenseModel.type == "Debit") {
            yearTotalExpAmt -= int.parse(expenseModel.amount);
          } else {
            yearTotalExpAmt += int.parse(expenseModel.amount);
          }
        }
      }
      listFilterExpModel.add(FilterExpenseModel(
          title: eachYear,
          totalAmt: yearTotalExpAmt.toString(),
          allExpenses: eachYearExpense,
      ));
    }
  }
}
