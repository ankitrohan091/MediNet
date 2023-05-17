import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medinet_app/Ask.dart';
import 'package:medinet_app/aboutUs.dart';
import 'package:medinet_app/filter.dart';
import 'package:medinet_app/forgotPass.dart';
import 'package:medinet_app/home.dart';
import 'package:medinet_app/login.dart';
import 'package:medinet_app/menuPage.dart';
import 'package:medinet_app/register.dart';
import 'package:medinet_app/userInfo.dart';
import 'package:medinet_app/yourpost.dart';
import 'package:medinet_app/Help.dart';
import 'NavBar.dart';
import 'chgPass.dart';
import 'likedpst.dart';
late final FirebaseApp app;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  app = await Firebase.initializeApp(
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'login',
    routes: {
      'register': (BuildContext context) => const MyRegister(),
      'login': (BuildContext context) => const MyLogin(),
      'home': (BuildContext context) => const MyHome(),
      'menu': (BuildContext context) => const MenuPage(),
      'userInfo':(BuildContext context) => const UserInfo(),
      'aboutUs' :(BuildContext context) => const AboutUs(),
      'chgPs' :(BuildContext context) => const ChgPass(),
      'forgot' :(BuildContext context) => ForgotPassword(),
      'Help' :(BuildContext context) => const Help(),
      'AllPost': (BuildContext context) => const PostList(),
      'Navbar' :(BuildContext context) => const NavBar(),
      'like' :(BuildContext context) => const Liked(),
      'Ask' :(BuildContext context) => const AskPage(),
      'filter' :(BuildContext context) => const Filter(),
    },
  ));
}
