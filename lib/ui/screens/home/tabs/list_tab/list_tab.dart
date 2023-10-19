import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_application/ui/screens/home/tabs/list_tab/todo_widget.dart';
import 'package:todo_application/utils/app_colors.dart';

class ListTab extends StatelessWidget {
  const ListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * .12,
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                      flex: 3,
                      child: Container(
                        color: Appcolors.primary,
                      )),
                  Expanded(
                      flex: 7,
                      child: Container(
                        color: Appcolors.accent,
                      ))
                ],
              ),
              CalendarTimeline(
                initialDate: DateTime.now(),
                firstDate: DateTime.now().subtract(const Duration(days: 365)),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                onDateSelected: (date) => {},
                leftMargin: 20,
                monthColor: Appcolors.white,
                dayColor: Appcolors.primary,
                dayNameColor: Appcolors.primary,
                activeDayColor: Appcolors.primary,
                activeBackgroundDayColor: Appcolors.white,
                dotsColor: Appcolors.transparent,
                locale: 'en',
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: 10, itemBuilder: (_, index) => const TodoWidget()),
        ),
      ],
    );
  }
}
