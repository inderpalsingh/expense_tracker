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

  String dropValue = 'This month';

  var dropValueItems = [
    'This month',
    'Pre month',
    'Next month',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ExpenseBloc>().add(FetchExpenseEvent());
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
                  const Text('Monety',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                  IconButton(
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        var logOut =
                            await prefs.remove(DbConnection.loginCheckLoginID);
                        if (logOut) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginUser()));
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
                  items: dropValueItems.map((String dropValueItems) {
                    return DropdownMenuItem(
                        value: dropValueItems,
                        child: Text(dropValueItems,
                            style: const TextStyle(fontSize: 15)));
                  }).toList(),
                  onChanged: (value) {},
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
                DropdownButton(
                  value: dropValue,
                  items: dropValueItems.map((String dropValueItems) {
                    return DropdownMenuItem(
                        value: dropValueItems,
                        child: Text(dropValueItems, style: const TextStyle(fontSize: 15)));
                  }).toList(),
                  onChanged: (value) {},
                ),
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
                  if (state is LoadingState) {
                    print('loading  $state');
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is FailureState) {
                    print('Failure $state');
                    return Center(
                      child: Text('Error ${state.errorMsg}'),
                    );
                  }
                  if (state is SuccessfulState) {
                    print('Success $state');
                    return ListView.builder(
                        itemCount: listFilterExpModel.length,
                        itemBuilder: (_, parentIndex) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            width: 450,
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
                                      Text(listFilterExpModel[parentIndex].title,style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                                      Text('-\$${listFilterExpModel[parentIndex].totalAmt}',style: const TextStyle( fontSize: 22,fontWeight: FontWeight.w700)),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                                    child: Container(
                                      color: Colors.grey,
                                      width: 450,
                                      height: 3,
                                    ),
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics:  const NeverScrollableScrollPhysics(),
                                      itemCount: listFilterExpModel[parentIndex].allExpenses.length,
                                      itemBuilder: (_, index) {
                                        var filteredList = AppConstants.mCategories.where((element) => element.catId == listFilterExpModel[parentIndex].allExpenses[index].title).toList();
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
}

//// Container(
//               height: 200,
//               decoration: BoxDecoration(
//                   color: Colors.grey.shade100,
//                   borderRadius: BorderRadius.circular(21)),
//               child: Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 5),
//                     const Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('Tuesday, 14', style: TextStyle(fontSize: 15)),
//                         Text('\$1380', style: TextStyle(fontSize: 15)),
//                       ],
//                     ),
//                     const SizedBox(height: 10),
//                     const Divider(color: Colors.black38),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           width: 50,
//                           height: 50,
//                           decoration: BoxDecoration(
//                               color: Colors.blue.shade500,
//                               borderRadius: BorderRadius.circular(5)),
//                           child: Image.asset('assets/icons/shopping_cart.png',
//                               width: 40, height: 30),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(
//                               right: MediaQuery.of(context).size.width / 3),
//                           child: const Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text('Shop', style: TextStyle(fontSize: 15)),
//                               Text('Buy new clothes',
//                                   style: TextStyle(fontSize: 15))
//                             ],
//                           ),
//                         ),
//                         Container(
//                           child: const Text('-\$90',
//                               style:
//                                   TextStyle(fontSize: 15, color: Colors.red)),
//                         )
//                       ],
//                     ),
//                     const SizedBox(height: 10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           width: 50,
//                           height: 50,
//                           decoration: BoxDecoration(
//                               color: Colors.blue.shade500,
//                               borderRadius: BorderRadius.circular(5)),
//                           child: Image.asset('assets/icons/mortgage.png',
//                               width: 40, height: 30),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(
//                               right: MediaQuery.of(context).size.width / 3),
//                           child: const Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text('Home', style: TextStyle(fontSize: 15)),
//                               Text('Buy new House',
//                                   style: TextStyle(fontSize: 15))
//                             ],
//                           ),
//                         ),
//                         Container(
//                           child: const Text('-\$120',
//                               style:
//                                   TextStyle(fontSize: 15, color: Colors.red)),
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
