import 'package:expense_tracker/bloc/bloc_expense/expense_bloc.dart';
import 'package:expense_tracker/domain/repositories/local/db_repository.dart';
import 'package:expense_tracker/presentation/screens/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(BlocProvider(create: (context) => ExpenseBloc(db: DbConnection.dbInstance),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      home: SplashPage(),
    );
  }
}
