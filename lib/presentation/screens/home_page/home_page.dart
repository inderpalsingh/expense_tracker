import 'package:expense_tracker/bloc/bloc_expense/expense_bloc.dart';
import 'package:expense_tracker/bloc/bloc_expense/expense_event.dart';
import 'package:expense_tracker/bloc/bloc_expense/expense_state.dart';
import 'package:expense_tracker/domain/repositories/local/db_repository.dart';
import 'package:expense_tracker/presentation/custom_ui/app_constant.dart';
import 'package:expense_tracker/presentation/screens/add_page/add_expense.dart';
import 'package:expense_tracker/presentation/screens/user_login/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ExpenseBloc>().add(FetchExpenseEvent());
  }

  @override
  Widget build(BuildContext context) {
    String dropValue = 'This month';

    var dropValueItems = [
      'This month',
      'Pre month',
      'Next month',
    ];

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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total expense',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
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
                        Text('\$3,734 ',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        Text('/ \$4000 per month',
                            style: TextStyle(
                                color: Color(0xff0afb7e7), fontSize: 15)),
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
                const Text('Expense Breakdown',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
            const SizedBox(
                width: double.infinity,
                child:
                    Text('Limit \$900 / week', style: TextStyle(fontSize: 18))),
            const SizedBox(height: 15),

            /// bar data
            ///
            BlocBuilder(builder: (_, state) {
              if (state is LoadingState) {
                return Center(child: CircularProgressIndicator());
              }

              if (state is FailureState) {
                return Center(
                  child: Text('Error: ${state.errorMsg}'),
                );
              }

              if (state is SuccessfulState) {
                return ListView.builder(itemBuilder: (_, parentIndex) {
                  return Container(
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(21)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 5),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tuesday, 14',
                                  style: TextStyle(fontSize: 15)),
                              Text('\$1380', style: TextStyle(fontSize: 15)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Divider(color: Colors.black38),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.blue.shade500,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Image.asset(
                                    'assets/icons/shopping_cart.png',
                                    width: 40,
                                    height: 30),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right:
                                        MediaQuery.of(context).size.width / 3),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Shop',
                                        style: TextStyle(fontSize: 15)),
                                    Text('Buy new clothes',
                                        style: TextStyle(fontSize: 15))
                                  ],
                                ),
                              ),
                              Container(
                                child: const Text('-\$90',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.red)),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.blue.shade500,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Image.asset('assets/icons/mortgage.png',
                                    width: 40, height: 30),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right:
                                        MediaQuery.of(context).size.width / 3),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Home',
                                        style: TextStyle(fontSize: 15)),
                                    Text('Buy new House',
                                        style: TextStyle(fontSize: 15))
                                  ],
                                ),
                              ),
                              Container(
                                child: const Text('-\$120',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.red)),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
              }
            return Container();
            }),

            const SizedBox(height: 15),
            Container(
              height: 200,
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(21)),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Tuesday, 14', style: TextStyle(fontSize: 15)),
                        Text('\$1380', style: TextStyle(fontSize: 15)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(color: Colors.black38),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.blue.shade500,
                              borderRadius: BorderRadius.circular(5)),
                          child: Image.asset('assets/icons/shopping_cart.png',
                              width: 40, height: 30),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width / 3),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Shop', style: TextStyle(fontSize: 15)),
                              Text('Buy new clothes',
                                  style: TextStyle(fontSize: 15))
                            ],
                          ),
                        ),
                        Container(
                          child: const Text('-\$90',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.red)),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.blue.shade500,
                              borderRadius: BorderRadius.circular(5)),
                          child: Image.asset('assets/icons/mortgage.png',
                              width: 40, height: 30),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width / 3),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Home', style: TextStyle(fontSize: 15)),
                              Text('Buy new House',
                                  style: TextStyle(fontSize: 15))
                            ],
                          ),
                        ),
                        Container(
                          child: const Text('-\$120',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.red)),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
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

// SizedBox(child: Image.asset('assets/images/bar.png')),
// Container(
//   margin: const EdgeInsets.only(right: 210),
//   child: const Text('Spending Details', style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold)),
// ),
// Container(
//   margin: const EdgeInsets.only(right: 60),
//   child: const Text('Your expenses are divided into 6 categories', style: TextStyle( fontSize: 15)),
// ),
// const SizedBox(height: 20),
// Row(
//   children: [
//     Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           height: 10,
//           width: MediaQuery.of(context).size.width * 0.30,
//           color: const Color(0xff0545fb7),
//
//         ),
//         const Text('40%', style: TextStyle( color: Colors.black)),
//       ],
//
//     ),
//
//     Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           height: 10,
//           width: MediaQuery.of(context).size.width * 0.20,
//           color: const Color(0xFF0e27fb4),
//         ),
//         const Text('25%', style: TextStyle( color: Colors.black)),
//       ],
//     ),
//     Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           height: 10,
//           width: MediaQuery.of(context).size.width * 0.15,
//           color: const Color(0xFF0e8be83),
//         ),
//         const Text('15%', style: TextStyle( color: Colors.black)),
//       ],
//     ),
//     Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           height: 10,
//           width: MediaQuery.of(context).size.width * 0.10,
//           color: const Color(0xFF05ab9d5),
//         ),
//         const Text('10%', style: TextStyle( color: Colors.black)),
//       ],
//     ),
//     Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           height: 10,
//           width: MediaQuery.of(context).size.width * 0.05,
//           color: const Color(0xff0d55959),
//         ),
//         const Text('5%', style: TextStyle( color: Colors.black)),
//       ],
//     ),
//     Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           height: 10,
//           width: MediaQuery.of(context).size.width * 0.05,
//           color: const Color(0xff059d589),
//         ),
//         const Text('5%', style: TextStyle( color: Colors.black)),
//       ],
//     )
//   ],
// ),
