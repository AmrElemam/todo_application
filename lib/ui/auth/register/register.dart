
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_application/models/app_user.dart';
import 'package:todo_application/ui/auth/login/login.dart';
import 'package:todo_application/ui/screens/home/home_screen.dart';
import 'package:todo_application/utils/dialog_utils.dart';

import '../../../utils/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  static const routename = "register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String email = "";

  String password = "";

  String username = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Register Screen"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign up',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: TextField(
                  onChanged: (value) {
                    username = value;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: TextField(
                  onChanged: (value) {
                    password = value;
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Appcolors.primary),
                    ),
                    child: const Text('Register'),
                    onPressed: () {
                      register();
                    },
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Already have an account?'),
                  TextButton(
                    child: const Text(
                      'Sign in',
                      style: TextStyle(color: Appcolors.primary,fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, LoginScreen.routename);
                      //signup screen
                    },
                  )
                ],
              ),
            ],
          )),
    );
  }

  void register() async{
    try{
      showloading(context);
      UserCredential userCredential  = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: password);
      AppUser newUser = AppUser(id: userCredential.user!.uid, email: email, username: username);
      await registerUserInFirestore(newUser);
      AppUser.currentUser = newUser;
      hideloading(context);
      Navigator.pushReplacementNamed(context, HomeScreen.routename);
    }on FirebaseAuthException catch(error){
      hideloading(context);
      showErrorDialog(context, error.message ??
          "Something went wrong please try again later!");

    }
  }

  Future registerUserInFirestore(AppUser user) async {
    CollectionReference <AppUser>usercollection = AppUser.collection();
    await usercollection.doc(user.id).set(user);

    //usercollection.add(user);
  }
}


