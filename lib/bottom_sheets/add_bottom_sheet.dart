import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/models/app_user.dart';
import 'package:todo_application/ui/Widgets/my_text_field.dart';
import 'package:todo_application/ui/providers/list_provider.dart';
import 'package:todo_application/utils/app_colors.dart';
import 'package:todo_application/utils/app_theme.dart';

import '../models/todo_dm.dart';


class AddBottomSheet extends StatefulWidget {
  const AddBottomSheet({super.key});

  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  DateTime selecteddate = DateTime.now();
  late ListProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: MediaQuery.of(context).size.height * .4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Add New Task",
              style: AppTheme.bottomSheetTitleTextStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            MyTextField(hinttext: "Enter Task Title" , controller: titlecontroller),
            const SizedBox(height: 8),
            MyTextField(hinttext: "Enter Task Title" , controller: descriptioncontroller,),
            const SizedBox(height: 16),
            Text(
              "Selected Date",
              style: AppTheme.bottomSheetTitleTextStyle
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            InkWell(
              onTap: () => myshowdatepicker(),
              child: Text(
                "${selecteddate.day}/${selecteddate.month}/${selecteddate.year}",
                textAlign: TextAlign.center,
                style: AppTheme.bottomSheetTitleTextStyle.copyWith(
                    fontWeight: FontWeight.normal, color: Appcolors.grey),
              ),
            ),
            const Spacer(),
            ElevatedButton(onPressed: () {
              addTodoFireStore();
            }, child: const Text("Add"))
          ],
        ),
      ),
    );
  }
  void addTodoFireStore() async{
    CollectionReference todoCollectionRef =
    AppUser.collection().doc(AppUser.currentUser!.id).collection(TodoDm.collectionname);
    DocumentReference newEmptyDoc = todoCollectionRef.doc();
    await newEmptyDoc.set(
        {
          "id": newEmptyDoc.id,
          "title": titlecontroller.text,
          "description": descriptioncontroller.text,
          "date": selecteddate,
          "isDone": false
        });
    provider.refreshTodoList();
    Navigator.pop(context);
  }
  void myshowdatepicker() async{
    selecteddate = await showDatePicker(
        context: context,
        initialDate: selecteddate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365))
    )??selecteddate;
    setState(() {});
  }
}

