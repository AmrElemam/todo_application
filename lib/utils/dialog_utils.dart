import 'package:flutter/material.dart';

 showloading(BuildContext context){
  return showDialog(
    barrierDismissible: false,
      context: context,
      builder: (_) {
        return const AlertDialog(
          content: Row(
            children: [
              Text("Loading..."),
              Spacer(),
              CircularProgressIndicator()
            ],
          ),
        );
      },);
}

 hideloading(BuildContext context){
   Navigator.pop(context);
 }

 showErrorDialog(BuildContext context , String message){
   return showDialog(
     context: context,
     builder: (_) {
       return  AlertDialog(
         title: const Text("Error"),
         content: Text(message),
         actions: [
           TextButton(
               onPressed: (){
                 Navigator.pop(context);
               },
               child: const Text("Ok"))
         ],

       );
     },);
 }