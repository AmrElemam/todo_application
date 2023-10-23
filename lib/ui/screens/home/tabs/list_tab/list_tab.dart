import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/ui/providers/list_provider.dart';
import 'package:todo_application/ui/screens/home/tabs/list_tab/todo_widget.dart';
import 'package:todo_application/utils/app_colors.dart';
import '../../../../../models/todo_dm.dart';

class ListTab extends StatefulWidget {


  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  late ListProvider provider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.refreshTodoList();
    });
  }
  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
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
                  initialDate: provider.selectedDate,
                  firstDate: DateTime.now().subtract(const Duration(days: 365)),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  onDateSelected: (date) => {
                    provider.selectedDate = date,
                    provider.refreshTodoList()
                  },
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
                itemCount: provider.todos.length,
                itemBuilder: (_ , index) => TodoWidget(model: provider.todos[index])
            ),
          ),
        ],
      );
    }

}



