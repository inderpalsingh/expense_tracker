import 'package:expense_tracker/bloc/bloc_user/user_bloc.dart';
import 'package:expense_tracker/bloc/bloc_user/user_event.dart';
import 'package:expense_tracker/bloc/bloc_user/user_state.dart';
import 'package:expense_tracker/data/model/user_model.dart';
import 'package:expense_tracker/domain/repositories/local/db_repository.dart';
import 'package:expense_tracker/presentation/screens/user_login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();


    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.green, Colors.white],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_2_outlined),
                    labelText: 'Name',
                    border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    labelText: 'Email',
                    border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: passController,
                obscureText: true,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline),
                    labelText: 'Password',
                    border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 30),
              BlocConsumer<UserBloc, UserState>(
                builder: (context, state) {
                  return ElevatedButton(onPressed: () {
                    // var db = DbConnection.dbInstance;
                    // var check = await db.signUpUser(
                    //     userModel: UserModel(
                    //       uid: 0,
                    //       name: nameController.text,
                    //       email: emailController.text,
                    //       pass: passController.text,
                    //     ));
                    // if(check){
                    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoginUser()));
                    // }else{
                    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Email already exists')));
                    // }
                    if (nameController.text.isNotEmpty && emailController.text.isNotEmpty && passController.text.isNotEmpty) {
                      context.read<UserBloc>().add(AddUserEvent(
                          userModel: UserModel(
                            name: nameController.text,
                            email: emailController.text,
                            pass: passController.text,
                          )));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Fields are empty')));
                    }
                  }, child: const Text('SignUp'));
                },
                listener: (context, state) {
                  if(state is SuccessfulUserState){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoginUser()));
                  }
                  
                },
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => const LoginUser()));
                      },
                      child: const Text('Login Here')
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
