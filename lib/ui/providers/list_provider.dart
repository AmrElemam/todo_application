import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_application/models/todo_dm.dart';

class ListProvider extends ChangeNotifier {
  List<TodoDm> todos = [];
  DateTime selectedDate = DateTime.now();

  void refreshTodoList() async {
    CollectionReference <TodoDm> todosCollection =
    FirebaseFirestore.instance.collection(TodoDm.collectionname).
    withConverter<TodoDm>(
        fromFirestore: (docSnapshot, _) {
          Map json = docSnapshot.data() as Map;
          TodoDm todo = TodoDm.fromjson(json);
          return todo;
        },

        toFirestore: (TodoDm, _) {
          return TodoDm.toJson();
        }
    );

    QuerySnapshot <TodoDm> todosSnapshot = await todosCollection.
    orderBy("date").get();

    List<QueryDocumentSnapshot<TodoDm>> docs = todosSnapshot.docs;

    //convert docs list to todos list
    //for(int i = 0; i<docs.length;i++){
    //todos.add(docs[i].data());
    //}
    //Better  Solution:
    todos = docs.map((docSnapshot) {
      return docSnapshot.data();
    }).toList();
    //Filter todos list according to selected date;
    //for(int i = 0; i<todos.length;i++){
    //if(todos[i].date.day != selectedDate.day ||
    //todos[i].date.month != selectedDate.month ||
    //todos[i].date.year != selectedDate.year
    //){
    //todos.removeAt(i);
    //i--;
    //}
    //Better  Solution:
    todos = todos.where((todo) {
      if (todo.date.day != selectedDate.day ||
          todo.date.month != selectedDate.month ||
          todo.date.year != selectedDate.year
      ) {
        return false;
      } else {
        return true;
      }
    }).toList();
    notifyListeners();
  }

  }
