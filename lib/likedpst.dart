import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Liked extends StatefulWidget {
  const Liked({Key? key}) : super(key: key);
  @override
  State<Liked> createState() => _LikedState();
}
class _LikedState extends State<Liked> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text("Liked Post"),
          elevation: 0,
        ),
        body: Column(
          children: [
            Container(
               width: MediaQuery.of(context).size.width,
              // height: 40,
              color: Colors.white12,
              child: OutlinedButton.icon(
                onPressed: () {
                  print("Profile Opend");
                },
                icon: const Icon(
                  Icons.account_circle,
                  size: 55.0,
                ),
                label: const Text("Uploaded By"), // <-- Text
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(CupertinoIcons.person),
              title: Text('This is post 1'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                ],
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(CupertinoIcons.person),
              title: Text('This is post 2'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                ],
              ),
            )
          ],
        ));
  }
}
