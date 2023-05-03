import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medinet_app/NavBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AskPage extends StatefulWidget {
  const AskPage({Key? key}) : super(key: key);

  @override
  State<AskPage> createState() => _AskPageState();
}

class _AskPageState extends State<AskPage> {
  final TextEditingController question = TextEditingController();
  late String ques;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
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
                    backgroundImage: const AssetImage('assets/pic.png'),
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
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Add Question",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                  decorationColor: Colors.red,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: const [
                SizedBox(
                  child: Text(
                    "🥴 Tips on getting Good answers quickly: -",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            ),
             const Divider(thickness: 5),
             const TextField(
              enabled: false,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.label_important),
                label: Text(
                  "Please ensure that your question has not already been posed.",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),),
            )),
            const TextField(
                enabled: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.label_important),
                  label: Text(
                      "Keep your question short, concise and to the point!",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),),
                )),
            const TextField(
                enabled: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.label_important),
                  label: Text(
                    "Look carefully at the grammar and spelling.",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),),
                )),
            const Divider(thickness: 5),
            TextField(
              decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(width: 3, color: Color(0xFF0D47A1))),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(width: 3, color: Color(0xFFD32F2F)))),
              style: const TextStyle(),
              maxLength: 500,
              minLines: 3,
              maxLines: 50,
              controller: question,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp('[A-Za-z0-9?.,:"!#%&*()-+|/; \n]'))
              ],
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () async{
                        if (question.text != "" && question.text != " ") {
                          ques = question.text;
                          question.text = "";
                          SharedPreferences prefs =await SharedPreferences.getInstance();
                          prefs.setString('question', ques);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(backgroundColor: Colors.black26, content: Text(
                                  'Your Question has been added to the Community!\n '
                                      'You will able to check the answers in Your Post Section, if someone give the answer',
                                ),
                              duration: Duration(seconds: 6),
                          ));
                          Navigator.pushNamed(context,'AllPost');
                        }else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(backgroundColor: Colors.black26, content: Text(
                                  'Please Write your Qustion! Your question cannot be null.',
                                )),
                          );
                        }
                      },
                      child: const Text("Add")),
                  const SizedBox(width: 2),
                  ElevatedButton(
                      onPressed: () {
                        if(question.text==""){
                          Navigator.pushAndRemoveUntil(context, PageRouteBuilder(
                            pageBuilder: (context, a, b) => const NavBar(),
                            transitionDuration: const Duration(seconds: 0),),
                                  (route) => false);
                        }
                        setState(() {
                          question.text = "";
                        });
                        ques = question.text;
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                      ),
                      child: const Text("Cancel"))
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}