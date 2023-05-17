import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medinet_app/post.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostList extends StatefulWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  State<PostList> createState() => _PostListState();
}
class _PostListState extends State<PostList>{
  String Name = "";
  List<String> documentList=[];

  void getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      String name = prefs.getString('Name')!;
      Name = name;
    });
  }

  void getQues() async {
    DatabaseService obj = DatabaseService();
      obj.getDocuments(FirebaseAuth.instance.currentUser!.uid);
  }
  Future<List<String>> getList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> myList = prefs.getStringList('posts') ?? [];
    return myList;
  }
  void get() async{
    documentList = await getList();
  }

  @override
  void initState() {
    super.initState();
      getQues();
      get();
      getName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Your Posts")),
        body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
              showQues(context),
              ]));
  }
  Widget showQues(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (documentList.length==0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
            child: Text("No Post Yet!",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.pinkAccent
            ),),
          ),
        ],
      );
    }
    else {
      return Flexible(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: documentList.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: size.width * 0.95,
                        child: TextButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                SizedBox(
                                  width: size.width * 0.90,
                                  child: Text(documentList[index],
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.blueGrey)),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                const Divider(thickness: 2,)
              ],
            );
          },
        ),
      );
    }}
}