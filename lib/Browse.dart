import 'package:flutter/material.dart';
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
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'menu');
                      },
                      icon: const Icon(
                        Icons.menu_sharp,
                        size: 35,
                      )),
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
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: questions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return QuestionWidget(questions[index]);
                  },
                ),
              )
            ],
          ),
        ));
  }
  void getName()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name=prefs.getString('Name')!;
    setState(() { userName=name;});
  }
  }
class Question {
  final String question;
  final String answer;
  int likes;
  List<String> comments;

  Question(this.question, this.answer, this.likes, this.comments);
}

List<Question> questions = [
  Question("What are some ways to maintain a healthy lifestyle?", " Maintaining a healthy lifestyle involves eating "
      "a balanced diet, "
      "staying physically active, getting enough sleep, reducing stress, avoiding tobacco and excessive alcohol "
      "consumption, and getting regular medical checkups.", 0, []),
  Question("What are some common risk factors for heart disease?", "Common risk factors for heart disease include "
      "high blood pressure, "
      "high cholesterol, smoking, physical inactivity, obesity, diabetes, family history of heart disease, "
      "and age.", 0, []),
  Question("What are some common symptoms of depression?", "Common symptoms of depression include persistent "
      "feelings of sadness, "
      "hopelessness, or emptiness, loss of interest in activities, changes in appetite or sleep patterns, "
      "fatigue, difficulty concentrating, and thoughts of suicide.", 0, []),
  Question("What are some tips for getting a good night's sleep?", "To improve your sleep quality, it's "
      "important to establish a "
      "consistent sleep schedule, avoid caffeine and alcohol before bedtime, create a relaxing bedtime routine, "
      "sleep in a dark and quiet environment, and limit screen time before bed.", 0, []),
  Question("How to get rid of common cold?", "Rest: Getting plenty of rest is one of the most important things "
      "you can do to help your "
      "body fight off the virus that causes the common cold."
      "\n Stay hydrated: Drinking plenty of fluids can help to thin out mucus and relieve congestion. Water, "
      "warm teas, and soups are all good options."
      "\n Use saline nasal drops: Saline drops or sprays can help to relieve nasal congestion and dryness."
      "\n Gargle with salt water: Gargling with salt water can help to soothe a sore throat and reduce inflammation."
      "\n Take over-the-counter medications: Over-the-counter medications such as acetaminophen, ibuprofen, and "
      "decongestants can help "
      "to relieve pain and reduce fever and congestion.", 0, []),
  Question("How can I manage stress?", "Some effective ways to manage stress include regular exercise, deep "
      "breathing or meditation, "
      "getting enough sleep, practicing relaxation techniques, talking to someone about your feelings, and "
      "prioritizing self-care activities.", 0, []),
  Question("What are some common symptoms of anxiety?", "Common symptoms of anxiety include excessive worry or "
      "fear, restlessness, irritability, muscle tension, difficulty sleeping, and panic attacks.", 0, []),
  Question("How can I maintain good mental health?", "Maintaining good mental health involves taking care of "
      "yourself both physically and emotionally. This includes eating a healthy diet, staying physically "
      "active, getting enough sleep, avoiding excessive alcohol and drug use, practicing stress management "
      "techniques, and seeking help from a mental health professional when needed.", 0, []),
  Question("What are some ways to prevent the spread of infectious diseases?", "To prevent the spread of infectious "
      "diseases, it's important to practice good "
      "hygiene, such as washing your hands frequently, covering your mouth and nose when you cough or sneeze, "
      "avoiding close contact with sick individuals, and staying home when you are sick. It's also important to "
      "get vaccinated against preventable diseases.", 0, []),
];

class QuestionWidget extends StatefulWidget {
  final Question question;
  const QuestionWidget(this.question, {super.key});
  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  TextEditingController _textEditingController = TextEditingController();
  double _dialogHeight = 100.0;
  bool showAnswer = false;
  bool liked = false;
  void _updateDialogHeight() {
    final textFieldHeight = 50.0;
    final padding = 20.0;
    final newHeight = _textEditingController.text.isEmpty
        ? 150.0
        : _textEditingController.text.split('\n').length * textFieldHeight +
        padding;
    setState(() {
      _dialogHeight = newHeight;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.question.question,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.red),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.thumb_up, color: liked ? Colors.blue : null),
                onPressed: () {
                  setState(() {
                    if (liked) {
                      widget.question.likes--;
                    } else {
                      widget.question.likes++;
                    }
                    liked = !liked;
                  });
                },
              ),
              Text(widget.question.likes.toString()),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      final TextEditingController commentController =
                      TextEditingController();
                      return AlertDialog(
                        title: const Text('Enter some text'),
                        content: SizedBox(
                          height: _dialogHeight,
                          width: 100,
                          child: Column(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _textEditingController,
                                  maxLines: 50,
                                  onChanged: (_) => _updateDialogHeight(),
                                  decoration: const InputDecoration(
                                    hintText: 'Type here...',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                widget.question.comments
                                    .add(commentController.text);
                              });
                              Navigator.of(context).pop();
                            },
                            child: const Text('Post'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              Text(widget.question.comments.length.toString()),
            ],
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                showAnswer = !showAnswer;
              });
            },
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      showAnswer ? widget.question.answer : "Show answer",
                      style: const TextStyle(fontSize: 16,color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
  }
}

