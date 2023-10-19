import 'package:flutter/material.dart';
import 'package:todo_application/ui/screens/home/home_screen.dart';
import 'package:todo_application/ui/screens/splash/splash_screen.dart';
import 'package:todo_application/utils/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.LightTheme,
      darkTheme: AppTheme.DarkTheme,
      routes: {
        HomeScreen.routename: (_) => HomeScreen(),
        SplashScreen.routename: (_) => SplashScreen()
      },
      initialRoute: HomeScreen.routename,
    );
  }
}
