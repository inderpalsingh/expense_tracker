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

  var selectedCategoryIndex = -1;

  List<DateWiseExpenseModel> listDateWiseExpModel = [];
  List<MonthWiseExpenseModel> listMonthWiseExpModel = [];
  List<FilterExpenseModel> listFilterExpModel = [];

  DateTime expenseDate = DateTime.now();

  Future<void> selectedDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022, 1, 1),
        lastDate: DateTime.now(),
    );
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
                          Image.asset(AppConstants.mCategories[selectedCategoryIndex].catImgPath, width: 30,height: 30),
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
                      catId: AppConstants.mCategories[selectedCategoryIndex].catId,
                        title: titleController.text,
                        desc: descController.text,
                        exTime: expenseDate.millisecondsSinceEpoch.toString(),
                        amount: amountController.text.toString(),
                        type: transactionType,
                        userId: 0,
                        eid: 0,
                        balance: widget.balance.toString(),
                    ),
                ));
                Navigator.pop(context);
              },
              child: const Text('Save'),
            )
          ],
        ),
      ),
    );
  }

}
