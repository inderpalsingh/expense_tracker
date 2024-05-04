import 'package:expense_tracker/presentation/screens/user_login/signup_page.dart';
import 'package:flutter/material.dart';

class LoginUser extends StatelessWidget {
  const LoginUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login here'),),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
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
              
            }, child: const Text('Login')),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('Forget Password?'),
                InkWell(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
                  },
                    child: const Text('SignUp Here')
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
