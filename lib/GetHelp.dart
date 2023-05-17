import 'package:flutter/material.dart';
import 'package:medinet_app/post.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MyQuestion extends StatefulWidget {
  const MyQuestion({Key? key}) : super(key: key);

  @override
  State<MyQuestion> createState() => _MyQuestionState();
}

class _MyQuestionState extends State<MyQuestion> {
   List<String> questions = [];
  final TextEditingController _controller = TextEditingController();
  DatabaseService obj=DatabaseService();
  void getList(){
    setState(() {
      obj.getSoln();
    });
  }
  Future<List<String>> getProblem() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> myList = prefs.getStringList('problems') ?? [];
    return myList;
  }
  void get() async{
    questions = await getProblem();
  }
  @override
  void initState() {
    super.initState();
    setState(() {
      getList();
      get();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Describe Problem'),
        ),
        body: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Enter your question',
                contentPadding: EdgeInsets.all(10),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async{
                if (_controller.text != "") {
                obj.giveHelp(_controller.text);
                _controller.text="";
                showDialog(context: context, builder: (context){
                  return AlertDialog(backgroundColor: Colors.white70,
                    title: const Text('Our Team has get your problem that you are facing in our Application.\nYou will notify soon through our '
                        'E-mail with its solution and You will also see the answer here in this page '
                        'after our team has reply your Questions',
                      style: TextStyle(color: Colors.blueAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.w900),),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }, child: const Text("OK",style: TextStyle(color: Colors.black),))
                    ],
                  );
                });
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        backgroundColor: Colors.black26,
                        content: Text(
                          'Please Describe your Problem!',
                        )),
                  );
                }
                },
              child: const Text('Post'),
            ),
            const SizedBox(height: 10),
            Flexible(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: questions.length,
                  itemBuilder: (context,index){
                    final item = questions[index];
                    final textStyle = index % 2 == 0
                        ? const TextStyle(
                      decorationColor: Colors.green,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                      fontSize: 19.5,
                      color: Colors.red,
                    )
                        : const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.blue,
                    );
                    return Text(
                      item,
                      style: textStyle,
                    );
              }),
            )
          ],
        ));
  }
}