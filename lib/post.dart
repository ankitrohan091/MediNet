import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseService {

  // reference for our collections
  final CollectionReference userCollection =
  FirebaseFirestore.instance.collection("user");
  final CollectionReference infoCollection =
  FirebaseFirestore.instance.collection("details");
  final CollectionReference helpCollection =
  FirebaseFirestore.instance.collection('help');
  int rand=Random().nextInt(9)+1;

  // saving the userdata
  Future savingUserData(String name, email, password) async {
    return await userCollection.doc(email).set({
      'userName': name,
      'userId': FirebaseAuth.instance.currentUser!.uid,
      'regTime': FieldValue.serverTimestamp(),
      'email': email,
      'password': password,
    });
  }


  // Future gettingUserName(String email) async {
  //   QuerySnapshot snapshot =
  //   await userCollection.where("email", isEqualTo: email).get();
  //   return snapshot.docs[0]['userName'];
  // }

  Future gettingData(String email) async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    final docRef=userCollection.doc(email);
    docRef.get().then(
            (DocumentSnapshot doc){
          final data = doc.data() as Map<String, dynamic>;
          prefs.setBool('isLoggedIn', true);
          prefs.setString('Name',data['userName']);
          prefs.setString('Email', data['email']);
          prefs.setString('Password',data['password']);
        }
    );
  }

  Future savingPost(String heading,String content,String userId) async{
    double rand2=Random().nextDouble()*rand;
    final CollectionReference postCollection =
    FirebaseFirestore.instance.collection('user').doc(userId).collection('post');
    return await postCollection.doc('$rand2').set({
      'heading': heading,
      'body': content,
      'postId': userId,
      'time': FieldValue.serverTimestamp()
    });
  }
  Future savingQues(String question,String userId) async {
    double rand2=Random().nextDouble()*rand;
    final CollectionReference quesCollection =
    FirebaseFirestore.instance.collection('user').doc(userId).collection('question');
    return await quesCollection.doc('$rand2').set({
      'heading':question,
      'time':FieldValue.serverTimestamp(),
      'questionId':userId
    });
  }
  Future getQues(String userId) async{
    List<String> ques=[];
    final CollectionReference quesCollection =
    FirebaseFirestore.instance.collection('user').doc(userId).collection('question');
    final QuerySnapshot snapshot = await quesCollection.get();
    for(var doc in snapshot.docs){
      String question=doc.get('heading');
      ques.add(question);
    }
    SharedPreferences prefs=await SharedPreferences.getInstance();
    await prefs.setStringList('questions',ques);
  }
  Future giveHelp(String problem) async {
    return await helpCollection.doc().set({
      'Problem': problem,
      'Solution': ' ',
    });
  }

  Future getSoln() async{
    List<String>problemList=[];
    final QuerySnapshot snapshot = await helpCollection.get();
    for(var doc in snapshot.docs) {
      String problem = doc.get('Problem');
      problemList.add(problem);
      String solution = doc.get('Solution');
      problemList.add(solution);
    }
    SharedPreferences prefs=await SharedPreferences.getInstance();
    await prefs.setStringList('problems', problemList);
  }

  Future getDocuments(String userId) async {
    List<String>documentList=[];
    final CollectionReference quesCollection =
    FirebaseFirestore.instance.collection('user').doc(userId).collection('question');
    final CollectionReference postCollection = 
        FirebaseFirestore.instance.collection('user').doc(userId).collection('post');
    final QuerySnapshot postSnapshot = await postCollection.where('postId', isEqualTo: userId).get();
    final QuerySnapshot snapshot = await quesCollection.where('questionId', isEqualTo: userId).get();
    for (var doc in snapshot.docs) {
      String fieldValue = doc.get('heading');
      documentList.add(fieldValue);
    }
    for(var doc in postSnapshot.docs) {
      String postValue = doc.get('heading');
      documentList.add(postValue);
    }
    SharedPreferences prefs=await SharedPreferences.getInstance();
    await prefs.setStringList('posts', documentList);
  }

  Future savingInfo(String name,String email,String number,String age,String gender,String experience,String state,
      String city,String pinCode) async{
    return await infoCollection.doc(email).set({
      'Name' : name,
      'Phone' : number,
      'Age' : age,
      'Gender' : gender,
      'Experience' : experience,
      'State' : state,
      'City' : city,
      'PinCode' : pinCode,
    });
  }

  Future getInfo(String email)async {
    SharedPreferences prefs =await SharedPreferences.getInstance();
    final docRef = infoCollection.doc(email);
    docRef.get().then(
        (DocumentSnapshot doc){
          final data = doc.data() as Map<String, dynamic>;
          prefs.setString('PhoneNo',data['Phone']);
          prefs.setString('Age',data['Age']);
          prefs.setString('Gender',data['Gender']);
          prefs.setString('Experience', data['Experience']);
          prefs.setString('State', data['State']);
          prefs.setString('City', data['City']);
          prefs.setString('Pin', data['PinCode']);
        }
    );
  }

  Future updateInfo(String email,String number,String age,String gender,String experience,String
  state, String city,String pinCode) async{
    final docRef = infoCollection.doc(email);
    docRef.update({
      'Phone' : number,
      'Age' : age,
      'Gender' : gender,
      'Experience' : experience,
      'State' : state,
      'City' : city,
      'PinCode' : pinCode,
    });
  }

  Future getUsers()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    List<String>users=[];
    QuerySnapshot snapshot = await infoCollection.get();
    for(var doc in snapshot.docs) {
      String value = doc.get('Name');
      users.add(value);
    }
    prefs.setStringList('userList', users);
  }
  void getSpecificFieldFromAllDocuments(List <String> ques,String userId) async {
    final CollectionReference quesCollection =
    FirebaseFirestore.instance.collection('user').doc(userId).collection('question');
    QuerySnapshot snapshot = await quesCollection.get();
    for (var docSnapshot in snapshot.docs) {
      String value = docSnapshot.get('heading');
      ques.add(value);
    }
  }
}