import 'package:flutter/material.dart';
import 'package:todo_application/ui/auth/login/login.dart';
import 'package:todo_application/ui/screens/home/home_screen.dart';
import 'package:todo_application/utils/app_assets.dart';


class SplashScreen extends StatefulWidget {
  static const routename = "splashscreen";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, LoginScreen.routename);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(AppAssets.splash),
    );
  }
}
