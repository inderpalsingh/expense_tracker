import 'package:expense_tracker/presentation/screens/user_login/login_page.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SignUp here'),),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder()
              ),
            ),
            const SizedBox(height: 30),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder()
              ),
            ),
            const SizedBox(height: 30),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder()
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(onPressed: () {

            }, child: const Text('SignUp')),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              
                InkWell(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginUser()));
                    },
                    child: const Text('Login Here')
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
