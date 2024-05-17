import 'package:expense_tracker/bloc/bloc_expense/expense_bloc.dart';
import 'package:expense_tracker/bloc/bloc_expense/expense_event.dart';
import 'package:expense_tracker/bloc/bloc_expense/expense_state.dart';
import 'package:expense_tracker/data/model/expense_model.dart';
import 'package:expense_tracker/data/model/filter_expense_model.dart';
import 'package:expense_tracker/domain/repositories/local/db_repository.dart';
import 'package:expense_tracker/presentation/screens/add_page/add_expense.dart';
import 'package:expense_tracker/presentation/screens/user_login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../custom_ui/app_constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FilterExpenseModel> listFilterExpModel = [];
  List<ExpenseModel> listOfExpenses = [];

  DateFormat dateFormat = DateFormat.yMMMMd();
  DateFormat monthFormat = DateFormat.LLLL();
  DateFormat yearFormat = DateFormat.y();
  DateTime expenseDate = DateTime.now();
  
  
  String dropValue = 'This month';

  var dropValueItems = [
    'This month',
    'Date Wise',
    'Year Wise',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ExpenseBloc>().add(FetchExpenseInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Monety', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                  IconButton(
                      onPressed: () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        var logOut = await prefs.remove(DbConnection.loginCheckLoginID);
                        if (logOut) {  
                          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const LoginUser()));
                        }
                      },
                      icon: const Icon(
                        Icons.logout_outlined,
                        size: 30,
                      ))
                ],
              ),
            ),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const CircleAvatar(
                  child: Icon(Icons.person_outline),
                ),
                const SizedBox(width: 10),
                const Padding(
                  padding: EdgeInsets.only(right: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Morning'),
                      Text('Inderpal Singh'),
                    ],
                  ),
                ),
                DropdownButton(
                  value: dropValue,
                  onChanged: (newValue) {
                    if(newValue=='This Month'){
                      filterExpenseMonthWise(allExpense: listOfExpenses);
                    }else if(newValue=='Date Wise'){
                      filterExpenseDateWise(allExpense: listOfExpenses);
                    } else if(newValue=='Year Wise'){
                      filterExpenseYearWise(allExpense: listOfExpenses);
                    }
                    
                    setState(() {
                      dropValue=newValue!;
                    });
                  },
                  items: dropValueItems.map((String dropValueItems) {
                    return DropdownMenuItem(
                        value: dropValueItems,
                        child: Text(dropValueItems,
                            style: const TextStyle(fontSize: 15)));
                  }).toList(),
                  
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: 100,
              width: 800,
              decoration: BoxDecoration(
                  color: const Color(0xFF5a68cc),
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total expense', style: TextStyle(color: Colors.white, fontSize: 16)),
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: Color(0xFF7984d6),
                          foregroundColor: Colors.white,
                          child: Icon(Icons.more_horiz_rounded),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Text('\$3,734 ', style: TextStyle(color: Colors.white, fontSize: 20)),
                        Text('/ \$4000 per month', style: TextStyle(color: Color(0xff0afb7e7), fontSize: 15)),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 10,
                          width: 250,
                          decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        Container(
                          height: 10,
                          width: 50,
                          decoration: BoxDecoration(
                              color: const Color(0xFF04e5bb3),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Expense Breakdown', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                //// DropDown
              ],
            ),
            const SizedBox(
                width: double.infinity,
                child: Text('Limit \$900 / week', style: TextStyle(fontSize: 18))),

            /// bar data
            ///


            Expanded(
              child: BlocBuilder<ExpenseBloc, ExpenseState>(
                builder: (context, state) {
                  if (state is ExpenseLoadingState) {
                    // print('loading  $state');
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is ExpenseFailureState) {
                    // print('Failure $state');
                    return Center(
                      child: Text('Error ${state.errorMsg}'),
                    );
                  }

                  if (state is ExpenseSuccessfulState) {
                     // filterExpenseMonthWise(allExpense: state.allExpenseState);
           
                    listOfExpenses = state.allExpenseState;
                    
                    return ListView.builder(
                        itemCount: listFilterExpModel.length,
                        itemBuilder: (_, parentIndex) {
                          return Container(
                            // padding: EdgeInsets.zero,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: 2),
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(listFilterExpModel[parentIndex].title,style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                                      Text('-\$${listFilterExpModel[parentIndex].totalAmt}',style: const TextStyle( fontSize: 20,fontWeight: FontWeight.w700)),
                                    ],
                                  ),
                                  const Divider(thickness: 3,color: Colors.grey,),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics:  const NeverScrollableScrollPhysics(),
                                      itemCount: listFilterExpModel[parentIndex].allExpenses.length,
                                      itemBuilder: (_, index) {
                                        var filteredList = AppConstants.mCategories.where((element) => element.catId == listFilterExpModel[parentIndex].allExpenses[index].title).toList();
                                        
                                        
                                        print('filteredList - $filteredList');
                                        print("imgPath - '$filteredList[0]'");
                                        String imgPath = filteredList[0].catImgPath;
                                        

                                        return ListTile(
                                          leading: Container(
                                            width: double.infinity,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.blue.shade200,
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Image.asset(imgPath),
                                            ),
                                          ),
                                          title: Text(
                                            listFilterExpModel[parentIndex].allExpenses[index].title,
                                            style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w700),
                                          ),
                                          subtitle: Text(
                                            listFilterExpModel[parentIndex].allExpenses[index].desc,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey),
                                          ),
                                          trailing: Text('-\u{20B9}${listFilterExpModel[parentIndex].allExpenses[index].amount}',
                                            style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.pinkAccent),
                                          ),
                                        );
                                      })
                                ],
                              ),
                            ),
                          );
                        });
                  }
                  return Container();
                },
              ),
            ),

            ///
            ///
            ///
            ///
            const SizedBox(height: 15),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_outlined), label: 'Notify'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddExpensePage(balance: 0)));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void filterExpenseDateWise({required List<ExpenseModel> allExpense}) {
    listFilterExpModel.clear();

    List<String> uniqueDates = [];

    for (ExpenseModel expenseModel in allExpense) {
      var createdAt = expenseModel.exTime;
      var mDateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(createdAt));
      var eachExpenseDate = dateFormat.format(mDateTime);

      print(eachExpenseDate);

      if (!uniqueDates.contains(eachExpenseDate)) {
        uniqueDates.add(eachExpenseDate);
      }
      print(uniqueDates);
    }

    for (String eachDate in uniqueDates) {
      num totalExpAmt = 0.0;
      List<ExpenseModel> eachDateExpenses = [];

      for (ExpenseModel expenseModel in allExpense) {
        var createdAt = expenseModel.exTime;
        var mDateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(createdAt));
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
      listFilterExpModel.add(FilterExpenseModel(
          title: eachDate,
          totalAmt: totalExpAmt.toString(),
          allExpenses: eachDateExpenses
      ));
    }
  }

  void filterExpenseMonthWise({required List<ExpenseModel> allExpense}) {
    listFilterExpModel.clear();
    List<String> uniqueMonth = [];


    for (ExpenseModel expenseModel in allExpense) {
      var createdAt = expenseModel.exTime;
      var mMonth = DateTime.fromMillisecondsSinceEpoch(int.parse(createdAt));
      var eachExpenseMonth = monthFormat.format(mMonth);

      if (!uniqueMonth.contains(eachExpenseMonth)) {
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
      listFilterExpModel.add(FilterExpenseModel(
          title: eachMonth,
          totalAmt: monthTotalExpAmt.toString(),
          allExpenses: eachMonthExpense
      ));
    }
  }

  void filterExpenseYearWise({required List<ExpenseModel> allExpense}) {
    listFilterExpModel.clear();
    List<String> uniqueYear = [];

    for (ExpenseModel expenseModel in allExpense) {
      var createdAt = expenseModel.exTime;
      var yDateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(createdAt));
      var eachExpenseYear = yearFormat.format(yDateTime);
      // var eachExpenseMonth = monthFormat.format(mDateTime);

      var eachExpenseYearNew = eachExpenseYear;

      if (!uniqueYear.contains(eachExpenseYearNew)) {
        uniqueYear.add(eachExpenseYearNew);
      }
    }

    for (String eachYear in uniqueYear) {
      num yearTotalExpAmt = 0.0;
      List<ExpenseModel> eachYearExpense = [];

      for (ExpenseModel expenseModel in allExpense) {
        var createdAt = expenseModel.exTime;
        var yDateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(createdAt));
        // var eachExpenseMonth = monthFormat.format(yDateTime);
        var eachExpenseYear = yearFormat.format(yDateTime);

        // var eachExpenseMonthYear = "$eachExpenseMonth-$eachExpenseYear";
        var eachExpenseMonthYear = eachExpenseYear;

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












