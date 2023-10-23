import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser{
  static const collectionname = "users";
  static AppUser? currentUser;
  late String id;
  late String email;
  late String username;
  AppUser({required this.id,required this.email,required this.username});
  AppUser.fromjson(Map json){
    id = json["id"];
    email = json["email"];
    username = json["username"];
  }
  Map <String , dynamic> tojson(){
    return {
    "id" : id,
    "email" : email,
    "username" : username,};
  }

  static CollectionReference <AppUser> collection(){
    return FirebaseFirestore.instance.collection(AppUser.collectionname)
        .withConverter(
      fromFirestore: (snapshot, _) {
        return AppUser.fromjson(snapshot.data()!);
      },
      toFirestore: (user, _) {
        return user.tojson();
      },
    );

  }

}