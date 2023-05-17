import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseService {
  DatabaseService(String uid);

  final CollectionReference userCollection =
  FirebaseFirestore.instance.collection("user");

  Future savingUserData(String name, email, password) async {
    return await userCollection.doc('uid').set({
      'userName': name,
      'userId': FirebaseAuth.instance.currentUser!.uid,
      'regTime': FieldValue.serverTimestamp(),
      'email': email,
      'password': password,
    });
  }

  Future gettingUserName(String email) async {
    QuerySnapshot snapshot =
    await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }
}