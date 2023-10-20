import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_application/models/todo_dm.dart';
import 'package:todo_application/utils/app_colors.dart';
import 'package:todo_application/utils/app_theme.dart';

class TodoWidget extends StatelessWidget {
  final TodoDm model;
  const TodoWidget({super.key, required this.model});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 22, horizontal: 30),
      decoration: BoxDecoration(
          color: Appcolors.white, borderRadius: BorderRadius.circular(20)),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: .21,
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {},
              backgroundColor: Appcolors.red,
              foregroundColor: Appcolors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * .13,
          padding: const EdgeInsets.symmetric(vertical: 27, horizontal: 17),
          child: Row(
            children: [
              const VerticalDivider(),
              const SizedBox(
                width: 12,
              ),
               Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.title, style: AppTheme.taskTitleTextStyle),
                  Text(model.description, style: AppTheme.taskDescriptionTextStyle)
                ],
              ),
              const Spacer(),
              Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                  decoration: BoxDecoration(
                      color: Appcolors.primary,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(
                    Icons.check,
                    color: Appcolors.white,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
