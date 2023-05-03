import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'post.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BrowsePage extends StatefulWidget {
  const BrowsePage({Key? key}) : super(key: key);

  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  bool isLiked=false;
  String userName='';
  @override
  void initState() {
    getName();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'menu');
                            },
                            icon: const Icon(
                              Icons.menu_sharp,
                              size: 35,
                            )),
                        SizedBox(
                          child: Container(
                            width: size.width * 0.67,
                          ),
                        ),
                        CircleAvatar(
                            backgroundImage:
                            const AssetImage('assets/pic.png'),
                            radius: 30,
                            backgroundColor: Colors.transparent,
                            child: TextButton(
                              child: const Text(""),
                              onPressed: () {
                                Navigator.pushNamed(context, 'userInfo');
                              },
                            )),
                      ],
                    ),
                    Tooltip(
                        message: "We decide the main topic or question from the "
                            "largest number of users upvote the question means that they "
                            "also want to know the answer of it.",
                        child: Row(
                          children: const [
                            Text("Top Contents :- ",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                                decorationColor: Colors.red,
                              ), ),
                          ],
                        )
                    ),
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage('assets/app_icon.png'),
                          radius: 18,
                        ),
                        Tooltip(
                            waitDuration: const Duration(seconds: 1),
                            showDuration: const Duration(seconds: 2),
                            message: "Click to display user's all posts.",
                            child: Text(userName,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple,
                                  decorationColor: Colors.red,
                                  decoration: TextDecoration.underline,
                                ))),
                      ],
                    ),
                    const Divider(thickness: 2),
                    getQues(context),
                  ],
                ))));
  }
  void getName()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name=prefs.getString('Name')!;
    setState(() { userName=name;});
  }
  }
Widget getQues(BuildContext context){
  List <String> ques=[];
  String ques1='';
  DatabaseService obj = DatabaseService();
  obj.getSpecificFieldFromAllDocuments(ques);
  for (int i = 0; i < ques.length; i++) {
    ques1 = ques[i];
    // TextButton(
    //   child: Text(ques1),
    //   onPressed: () {},
    // );
  }
  return TextButton(onPressed: (){},
      child: Text(ques1));
}
Widget contents(BuildContext context){
  return LikeButton(
              size: 20,
              circleColor:
              const CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
              bubblesColor: const BubblesColor(
                dotPrimaryColor: Color(0xff33b5e5),
                dotSecondaryColor: Color(0xff0099cc),
              ),
              likeBuilder: (bool isLiked) {
                return Icon(
                  Icons.heart_broken,
                  color: isLiked ? Colors.deepPurpleAccent : Colors.red,
                  size: 20,
                );}
  );
}