import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  String? hinttext;
  TextEditingController controller;

  MyTextField({this.hinttext , required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(hintText: hinttext),
    );
  }
}
