import 'package:flutter/material.dart';
import 'package:todo_application/utils/app_colors.dart';


abstract class AppTheme{
  static const TextStyle appBarTextStyle = TextStyle(color: Appcolors.white , fontSize: 22
      , fontWeight: FontWeight.bold);
  static const TextStyle taskTitleTextStyle = TextStyle(color: Appcolors.primary , fontSize: 22
      , fontWeight: FontWeight.bold);
  static const TextStyle taskDescriptionTextStyle = TextStyle(color: Appcolors.lightblack , fontSize: 14
      , fontWeight: FontWeight.normal);
  static const TextStyle bottomSheetTitleTextStyle = TextStyle(color: Appcolors.black , fontSize: 20
      , fontWeight: FontWeight.bold);
  static ThemeData LightTheme = ThemeData(
      primaryColor: Appcolors.primary,
      scaffoldBackgroundColor: Appcolors.accent,
      appBarTheme: const AppBarTheme(
          backgroundColor: Appcolors.primary,
          elevation: 0,
          titleTextStyle: appBarTextStyle),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedIconTheme: IconThemeData(size: 32),
        unselectedIconTheme: IconThemeData(size: 32),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Appcolors.primary,
        unselectedItemColor: Appcolors.grey,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          shape: StadiumBorder(
              side: BorderSide(color: Appcolors.white, width: 4))),
      dividerTheme:
      const DividerThemeData(color: Appcolors.primary, thickness: 3));

  static ThemeData DarkTheme = ThemeData();
}