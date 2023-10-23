import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_application/ui/auth/register/register.dart';
import 'package:todo_application/utils/app_colors.dart';

import '../../../models/app_user.dart';
import '../../../utils/dialog_utils.dart';
import '../../screens/home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routename = "login";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "";

  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Login Screen"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 20),
                  )),
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
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                    child: const Text('Login'),
                    onPressed: () {
                      login();
                    },
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Does not have account?'),
                  TextButton(
                    child: const Text(
                      'Sign up',
                      style: TextStyle(color: Appcolors.primary,fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, RegisterScreen.routename);
                      //signup screen
                    },
                  )
                ],
              ),
            ],
          )),
    );
  }

  void login() async{
    try{
      showloading(context);
      UserCredential userCredential  = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      AppUser currentUser = await getUserFromFirestore(userCredential.user!.uid);
      AppUser.currentUser = currentUser;
      hideloading(context);
      Navigator.pushReplacementNamed(context, HomeScreen.routename);
    }on FirebaseAuthException catch(error){
      hideloading(context);
      showErrorDialog(context, error.message ??
          "Something went wrong please try again later!");

    }
  }

  Future <AppUser> getUserFromFirestore(String id) async {
    CollectionReference<AppUser> userCollection = AppUser.collection();
    DocumentSnapshot <AppUser> documentSnapshot = await userCollection.doc(id).get();
    return documentSnapshot.data()!;


  }
}

