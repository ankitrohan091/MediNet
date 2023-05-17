import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medinet_app/chgPass.dart';
import 'package:medinet_app/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MenuPage extends StatefulWidget {
  const MenuPage({super.key});
  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('MediNet'),
        ),
        body: Container(
            width: 288,
            height: double.maxFinite,
            color: Colors.green[50],
            child: SafeArea(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white24,
                      child: Image.asset('assets/app_icon.png'),
                    ),
                    title: const Text(
                      "MediNet",
                      style: TextStyle(
                        color: Color(0xFF0D47A1),
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    subtitle: const Text(
                      "No Problem is Unique",
                      style: TextStyle(
                        color: Color(0xFF0D47A2),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  menuTitle(context, "Your Post", "AllPost"),
                  menuTitle(context, "Liked Post", "like"),
                  menuTitle(context, "Illness Category", "filter"),
                  menuTitle(context, "About Us", "aboutUs"),
                  menuTitle(context, "Help?", "Help"),
                  Row(children: [
                    const Icon(Icons.ad_units_outlined, color: Colors.pink),
                    TextButton(
                      child: const Text(
                        "Change Password",
                        style: TextStyle(
                            color: Color(0xFF303030),
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChgPass()),
                        );
                      },
                    ),
                  ]),
                  Row(
                    children: [
                      const Icon(Icons.logout, size: 24, color: Colors.pink),
                      TextButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.pushAndRemoveUntil(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, a, b) => const MyLogin(),
                                transitionDuration: const Duration(seconds: 0),
                              ),
                                  (route) => false);
                        },
                        child: const Text(
                          "Sign Out",
                          style: TextStyle(
                              color: Color(0xFF303030),
                              fontWeight: FontWeight.w700,
                              fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}

Widget menuTitle(BuildContext context, String name, String page) {
  return Row(
    children: [
      const Icon(Icons.ad_units_outlined, size: 24, color: Colors.pink),
      TextButton(
        onPressed: () {
          Navigator.pushNamed(context, page);
        },
        child: Text(
          name,
          style: const TextStyle(
              color: Color(0xFF303030),
              fontWeight: FontWeight.w700,
              fontSize: 20),
        ),
      ),
    ],
  );
}
