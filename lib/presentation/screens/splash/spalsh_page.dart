import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:expense_tracker/presentation/screens/home_page/home_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePgae()));
     });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: AnimatedTextKit(
        animatedTexts: [
          TypewriterAnimatedText('Welcome to Expense app', textStyle: const TextStyle(fontSize: 30, ) )
        ],
             ),
      )
    );
  }
}