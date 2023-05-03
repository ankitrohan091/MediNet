import 'package:flutter/material.dart';
class MyQuestion extends StatefulWidget {
  const MyQuestion({Key? key}) : super(key: key);

  @override
  State<MyQuestion> createState() => _MyQuestionState();
}

class _MyQuestionState extends State<MyQuestion> {
  List<String> _questions = [];
  TextEditingController _controller = TextEditingController();
  void _postQuestion() {
    setState(() {
      _questions.add(_controller.text);
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Question Box'),
        ),
        body: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter your question',
                contentPadding: EdgeInsets.all(10),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_controller.text != "") {
                _postQuestion();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Colors.teal,
                    content: Text(
                      'Our Team has get your problem that you are facing in our Application.\n You will notify soon through our '
                          'E-mail with its solution and You will also see the answer here in this page '
                          'after our team has reply your Questions  ⮛',
                      style: TextStyle(color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w900),),
                    duration: Duration(seconds: 18),
                  ),);
                }
                else{
                  null;
                }
                },
              child: Text('Post'),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _questions.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(_questions[index]),
                  );
                },
              ),
            ),
          ],
        ));
  }
}