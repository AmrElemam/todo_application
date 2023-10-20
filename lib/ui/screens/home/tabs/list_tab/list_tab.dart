import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_application/ui/screens/home/tabs/list_tab/todo_widget.dart';
import 'package:todo_application/utils/app_colors.dart';
import '../../../../../models/todo_dm.dart';

class ListTab extends StatefulWidget {


  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
   List<TodoDm> todos = [];

  @override
  Widget build(BuildContext context) {
    if(todos.isEmpty) {
      refreshTodoList();
    }
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
                itemCount: todos.length,
                itemBuilder: (_ , index) => TodoWidget(model: todos[index])
            ),
          ),
        ],
      );
    }

   void refreshTodoList() async{
     CollectionReference <TodoDm> todosCollection  =
     FirebaseFirestore.instance.collection(TodoDm.collectionname).
     withConverter<TodoDm>(
         fromFirestore: (docSnapshot, _){
           Map json = docSnapshot.data() as Map;
           TodoDm todo = TodoDm.fromjson(json);
           return todo;
         },

         toFirestore: (TodoDm, _) {
           return TodoDm.toJson();
         }
         );

     QuerySnapshot <TodoDm> todosSnapshot = await todosCollection.get();

     List<QueryDocumentSnapshot<TodoDm>> docs = todosSnapshot.docs;

     //convert docs list to todos list
     todos = docs.map((docSnapshot){
       return docSnapshot.data();
     }).toList();

     setState(() {});
   }
}



