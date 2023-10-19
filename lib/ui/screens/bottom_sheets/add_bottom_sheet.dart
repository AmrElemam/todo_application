import 'package:flutter/material.dart';
import 'package:todo_application/ui/Widgets/my_text_field.dart';
import 'package:todo_application/utils/app_colors.dart';
import 'package:todo_application/utils/app_theme.dart';


class AddBottomSheet extends StatefulWidget {
  const AddBottomSheet({super.key});

  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  DateTime selecteddate = DateTime.now();
  @override
  Widget build(BuildContext context) {
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
            }, child: const Text("Add"))
          ],
        ),
      ),
    );
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

