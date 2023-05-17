import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:medinet_app/NavBar.dart';
import 'package:medinet_app/post.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*class Auth {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User> handleSignInEmail(String email, String password) async {
    UserCredential result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    final User user = result.user!;

    return user;
  }

  Future<User> handleSignUp(email, password) async {
    UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final User user = result.user!;

    return user;
  }
}*/

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);
  @override
  State<MyRegister> createState() => _MyRegisterState();
}
class _MyRegisterState extends State<MyRegister> {
  final TextEditingController emailAddress = TextEditingController();
  final TextEditingController passcode = TextEditingController();
  final TextEditingController userName = TextEditingController();
  @override
  void dispose() {
    emailAddress.dispose();
    passcode.dispose();
    userName.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    //var authHandler = Auth();
    //FirebaseAuth mAuth;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 35, top: 30),
              child: const Text(
                'Create\nAccount',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(25),
                            ],
                            textCapitalization: TextCapitalization.words,
                            controller: userName,
                            style: const TextStyle(color: Colors.red),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.text_rotation_none),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Name",
                                hintStyle: const TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(30),
                            ],
                            controller: emailAddress,
                            style: const TextStyle(color: Colors.red),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email_sharp),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Email",
                                hintStyle: const TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(20),
                            ],
                            controller: passcode,
                            style: const TextStyle(color: Colors.red),
                            obscureText: true,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.password),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                hintText: "Password",
                                hintStyle: const TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 27,
                                    fontWeight: FontWeight.w700),
                              ),
                              CircleAvatar(
                                radius: 30,
                                child: IconButton(
                                  onPressed: () async{
                                    try {
                                      if(userName.text.isEmpty){
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                            backgroundColor: Colors.black26,
                                            content: Text('Please Enter your Name!',)),);
                                      }
                                      await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                        email: emailAddress.text,
                                        password: passcode.text,
                                      );
                                      final DatabaseService postService = DatabaseService();
                                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                                          email: emailAddress.text,
                                          password: passcode.text
                                      );
                                      postService.savingUserData(userName.text,emailAddress.text,passcode.text);
                                      postService.gettingData(emailAddress.text);
                                      postService.savingInfo(userName.text,emailAddress.text, '', '', '', '', '','', '');
                                      postService.getInfo(emailAddress.text);
                                      // SharedPreferences prefs = await SharedPreferences.getInstance();
                                      // await prefs.setBool('isLoggedIn', true);
                                      // final QuerySnapshot snapshot =
                                      // await postService.gettingUserName(emailAddress.text);
                                      // // // saving the values to our shared preferences
                                      // await prefs.setString("email", emailAddress.text);
                                      // await prefs.setString("Name", snapshot.docs[0]['userName']);
                                      // await prefs.setString("password", passcode.text);
                                      Navigator.pushAndRemoveUntil(context, PageRouteBuilder(
                                            pageBuilder: (context, a, b) => const NavBar(),
                                            transitionDuration: const Duration(seconds: 0),
                                          ),
                                              (route) => false);
                                    } on FirebaseAuthException catch (e) {
                                      if (passcode.text.length < 6) {
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                            backgroundColor: Colors.black26,
                                            content: Text('The provided password is too weak!',)),);
                                      } else if (e.code == 'email-already-in-use') {
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                            backgroundColor: Colors.black26,
                                            content: Text('This Account already in use!',)),);
                                      }
                                      else if(!emailAddress.text.contains('@')){
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                            backgroundColor: Colors.black26,
                                            content: Text('Please enter valid E-mail!',)),);
                                      }
                                      else if(emailAddress.text.isEmpty){
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                            backgroundColor: Colors.black26,
                                            content: Text('Please Enter your E-mail!',)),);
                                      }
                                      else if(passcode.text.isEmpty){
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                            backgroundColor: Colors.black26,
                                            content: Text('Please Enter your Password!',)),);
                                      }
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                  icon: const Icon(Icons.arrow_forward),
                                  color: Colors.white,
                                  splashColor: Colors.green,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 38,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, 'login');
                                },
                                style: const ButtonStyle(),
                                child: const Text(
                                  'Sign In',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.white,
                                      fontSize: 18),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}