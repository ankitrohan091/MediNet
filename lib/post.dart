import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseService {

  // reference for our collections
  final CollectionReference userCollection =
  FirebaseFirestore.instance.collection("user");
  final CollectionReference infoCollection =
  FirebaseFirestore.instance.collection("details");

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

  Future savingInfo(String email,String number,String age,String gender,String experience,String state,
      String city,String pinCode) async{
    return await infoCollection.doc(email).set({
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
}