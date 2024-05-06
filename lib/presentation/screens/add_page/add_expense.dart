import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpense extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Exp'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 30),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder()
              ),
            ),
          ],
        ),
      ),
    );
  }
}