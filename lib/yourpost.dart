import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostList extends StatefulWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  State<PostList> createState() => _PostListState();
}
class _PostListState extends State<PostList> {
  String Name="";
  void getName()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name=prefs.getString('Name')!;
    Name=name;
    setState(() {});
  }
  @override
  void initState() {
    getName();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Posts")),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              const Icon(
                Icons.person,
                size: 50,
              ),
              Text(Name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.deepPurpleAccent)),
            ],
          ),
          const Text("Help us! to know About You",
              style: TextStyle(fontSize: 18, color: Colors.black)),
          const Divider(thickness: 15),
          SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(children: const [
                Text("Your First contribution related to 'Headache' ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.pinkAccent)),
                Divider(thickness: 2),
                Text("Your second contribution related to 'Skin Problem' ",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: Colors.pinkAccent)),
                Divider(thickness: 2),
                Text("This contribution related to 'Fever' "),
                Divider(thickness: 2),
                Text("This contribution related to '_______' "),
                Divider(thickness: 2),
                Text("This contribution related to '_______' "),
                Divider(thickness: 2),
                Text("This contribution related to '_______' "),
                Divider(thickness: 2),
                Text("This contribution related to '_______' "),
                Divider(thickness: 2),
                Text("This contribution related to '_______' "),
              ]))
        ],
      ),
    );
  }
}
