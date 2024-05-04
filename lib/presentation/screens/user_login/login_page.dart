
import 'package:expense_tracker/domain/repositories/local/db_repository.dart';
import 'package:expense_tracker/presentation/screens/home_page/home_page.dart';
import 'package:expense_tracker/presentation/screens/user_login/signup_page.dart';
import 'package:flutter/material.dart';

class LoginUser extends StatelessWidget {
  const LoginUser({super.key});

  @override
  Widget build(BuildContext context) {
    final _key = GlobalKey<FormState>();
    
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();
    
    
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.white],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email_outlined),
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return 'Please enter email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: passController,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outline),
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton(onPressed: () async{
                  var db = DbConnection.dbInstance;
                  var check = await db.loginUser(emailController.text.toString(), passController.text.toString());
                  if(check){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePgae()));
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid credentials !!')));
                  }
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
        ),
      ),
    );
  }
}
