import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

class Users{
  final String uid;
  Users({this.uid});
  FirebaseFirestore db = GetIt.I.get<FirebaseFirestore>();

  Future updateUserData(String name , String email ) async{
    final CollectionReference users = db.collection('users');

    return await users.doc(this?.uid).set({
      'name' : name,
      'email' : email,
    });
  }
}