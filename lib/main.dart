import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/ui/auth/login/login.dart';
import 'package:todo_application/ui/auth/register/register.dart';
import 'package:todo_application/ui/screens/home/home_screen.dart';
import 'package:todo_application/ui/screens/splash/splash_screen.dart';
import 'package:todo_application/utils/app_theme.dart';

import 'ui/providers/list_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings =
      const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  //await FirebaseFirestore.instance.disableNetwork();
  runApp(ChangeNotifierProvider(
      create: (_) {
        return ListProvider();
      },
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.LightTheme,
      darkTheme: AppTheme.DarkTheme,
      routes: {
        HomeScreen.routename: (_) => const HomeScreen(),
        SplashScreen.routename: (_) => const SplashScreen(),
        LoginScreen.routename: (_) => const LoginScreen(),
        RegisterScreen.routename: (_) => const RegisterScreen(),
      },
      initialRoute: SplashScreen.routename,
    );
  }
}
