import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:medinet_app/NavBar.dart';
import 'package:medinet_app/forgotPass.dart';
import 'package:medinet_app/post.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);
  @override
  State<MyLogin> createState() => _MYLoginState();
}

class _MYLoginState extends State<MyLogin> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController emailAddress = TextEditingController();
  final TextEditingController passcode = TextEditingController();
  bool isLoggedIn = false;
  @override
  void dispose() {
    emailAddress.dispose();
    passcode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(),
            Container(
              padding: const EdgeInsets.only(left: 35, top: 130),
              child: const Text(
                'Welcome\nBack',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(30),
                            ],
                            controller: emailAddress,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email_sharp),
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Email",
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
                            style: const TextStyle(color: Colors.black),
                            obscureText: true,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.security_rounded),
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Password",
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
                                'Sign in',
                                style: TextStyle(
                                    fontSize: 27, fontWeight: FontWeight.w700),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: const Color(0xff4c505b),
                                child: IconButton(
                                  color: Colors.white,
                                  onPressed: () async {
                                    try {
                                      await auth
                                          .signInWithEmailAndPassword(
                                              email: emailAddress.text,
                                              password: passcode.text);
                                      final DatabaseService obj= DatabaseService();
                                      SharedPreferences pref=await SharedPreferences.getInstance();
                                      obj.gettingData(emailAddress.text);
                                      obj.getInfo(emailAddress.text);
                                        Navigator.pushAndRemoveUntil(context,
                                            PageRouteBuilder(pageBuilder: (context, a, b) => const NavBar(),
                                              transitionDuration: const Duration(seconds: 0),),
                                            (route) => false);
                                    } on FirebaseAuthException catch (e) {
                                      if (e.code == 'user-not-found') {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                              backgroundColor: Colors.black26,
                                              content: Text(
                                                'No User found for that E-mail!',
                                              )),
                                        );
                                      }
                                      else if (e.code == 'wrong-password') {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                              backgroundColor: Colors.black26,
                                              content: Text(
                                                'Please Enter correct Password!',
                                              )),
                                        );
                                      } else if (emailAddress.text.isEmpty) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                              backgroundColor: Colors.black26,
                                              content: Text(
                                                'Please Enter your E-mail!',
                                              )),
                                        );
                                      } else if (passcode.text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              backgroundColor: Colors.black26,
                                              content: Text(
                                                'Please Enter your Password!',
                                              )),
                                        );
                                      }
                                    }
                                  },
                                  icon: const Icon(Icons.arrow_forward),
                                  splashColor: Colors.lightBlue,
                                ),
                              )
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
                                  Navigator.pushNamed(context, 'register');
                                },
                                style: const ButtonStyle(),
                                child: const Text(
                                  'Sign Up',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xff4c505b),
                                      fontSize: 18),
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ForgotPassword()),
                                    );
                                  },
                                  child: const Text(
                                    'Forgot Password',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xff4c505b),
                                      fontSize: 18,
                                    ),
                                  )),
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
