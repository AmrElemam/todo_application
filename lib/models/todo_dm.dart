import 'package:cloud_firestore/cloud_firestore.dart';

class TodoDm {
  late String id;
  late String title;
  late String description;
  late DateTime date;
  late bool isDone;
  static const collectionname = "todos";

  TodoDm(this.id, this.title, this.description, this.date, this.isDone);

  TodoDm.fromjson(Map json){
    id = json["id"];
    title = json["title"];
    description = json["description"];
    Timestamp time = json["date"];
    date = time.toDate();
    isDone = json["isDone"];
  }

  Map <String , Object?>toJson() {
    return {
    "id" : id,
    "description" : description,
    "title" : title,
    "date" : date,
    "isDone" : isDone
  };
  }
}