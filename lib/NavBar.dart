import 'package:medinet_app/Ask.dart';
import 'package:medinet_app/Browse.dart';
import 'package:medinet_app/Share.dart';
import 'package:flutter/material.dart';
import 'package:medinet_app/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int pageIndex = 0;
  static Future<String> getName()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name=prefs.getString('Name')!;
    return name;
  }
  final List<Widget> tabList = [
    const MyHome(),
    const AskPage(),
    const SharePage(),
    const BrowsePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
          children: [
        tabList.elementAt(pageIndex),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Align(
            alignment: const Alignment(0.0, 1.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: BottomNavigationBar(
                  selectedItemColor: Colors.green[900],
                  unselectedItemColor: Colors.grey,
                  showSelectedLabels: true,
                  showUnselectedLabels: false,
                  backgroundColor: Colors.white,
                  currentIndex: pageIndex,
                  onTap: (int index) {
                    setState(() {
                      pageIndex = index;
                    });
                  },
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home_filled), label: "Home"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.question_mark_sharp),label: "ASK"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.view_array_outlined), label: "Add Post"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.question_answer), label: "Browse"),
                  ]),
            ),
          ),
        ),
      ]),
    );
  }
}
