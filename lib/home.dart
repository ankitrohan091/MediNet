import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medinet_app/post.dart';
import 'package:medinet_app/topQues.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class CustomSearchDelegate extends SearchDelegate {
  // Demo list to show querying
  List<String> searchTerms = [
    "Anxiety",
    "Asthma",
    "Cancer",
    "Cataract",
    "Covid-19",
    "Diabetes",
    "Fever",
    "Heart disease",
    "Malaria",
    "Sleepiness"
  ];

  // first overwrite to
  // clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}

class _MyHomeState extends State<MyHome> with TickerProviderStateMixin {
  String nName = '';
  String topQues = '';
  String user = '';
  List<String> documentList = [];
  TextEditingController answerController = TextEditingController();

  void setQues() async {
    DatabaseService obj = DatabaseService();
    setState(() {
      obj.getQues(FirebaseAuth.instance.currentUser!.uid);
    });
  }

  Future<List<String>> getList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> myList = prefs.getStringList('questions') ?? [];
    return myList;
  }

  void get() async {
    documentList = await getList();
  }

  String getQues(int i) {
    if (documentList.length > i) {
      topQues = documentList[i];
      return topQues;
    }
    else {
      topQues = "Please Ask a Question before!..";
      return topQues;
    }
  }

  List<String> userDoc = [];

  void setUsers() async {
    DatabaseService obj = DatabaseService();
    setState(() {
      obj.getUsers();
    });
  }

  Future<List<String>> getUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> myList = prefs.getStringList('userList') ?? [];
    return myList;
  }

  void getUserNoPrefs() async {
    userDoc = await getUsers();
  }

  String getUser(int i) {
    user = userDoc[i];
    return user;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      setUsers();
      getUserNoPrefs();
      setQues();
      get();
      getName();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    TabController tabController = TabController(length: 3, vsync: this);
    return Scaffold(
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                        backgroundImage: const AssetImage('assets/pic.png'),
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        child: TextButton(
                          child: const Text(""),
                          onPressed: () async {
                            // final DatabaseService obj=DatabaseService();
                            // SharedPreferences prefs =await  SharedPreferences.getInstance();
                            // String? email=prefs.getString('Email');
                            // obj.getInfo(email!);
                            Navigator.pushNamed(context, 'userInfo');
                          },
                        )),
                  ],
                ),
                Row(children: [
                  Text(
                    '  Hello $nName,\n  Welcome to MediNet',
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        showSearch(
                            context: context,
                            // delegate to customize the search bar
                            delegate: CustomSearchDelegate());
                      },
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red, width: 3),
                        ),
                        child: const Text(
                          "Search MediNet!                                 ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // method to show the search bar
                        showSearch(
                            context: context,
                            // delegate to customize the search bar
                            delegate: CustomSearchDelegate());
                      },
                      icon: const Icon(Icons.search,
                          color: Colors.deepOrange, size: 28),
                    )
                  ],
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 5,
                  child: Container(
                    width: size.width * 1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black.withOpacity(0.1),
                    ),
                    child: TabBar(
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.orange),
                      controller: tabController,
                      isScrollable: true,
                      labelPadding: const EdgeInsets.symmetric(horizontal: 33),
                      tabs: const [
                        Tab(
                            child: Text(
                              "Experience",
                              style: TextStyle(color: Colors.black),
                            )),
                        Tab(
                            child: Text(
                              "Ask",
                              style: TextStyle(color: Colors.black),
                            )),
                        Tab(
                            child: Text(
                              "Top Users",
                              style: TextStyle(color: Colors.black),
                            ))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 210,
                  child: TabBarView(
                      controller: tabController,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              block(context, Colors.green.shade100, 0,"What is it like to be a doctor? What do they think of their patients?",0),
                              space(context),
                              block(context, Colors.green.shade100, 1,"Age when a baby can drink cows' milk?",2),
                              space(context),
                              block(context, Colors.green.shade100, 2,"How can a healthy diet help in preventing diabetes?",4),
                              space(context),
                              block(context, Colors.green.shade100, 3,"Is it okay to have green tea on an empty stomach?",6),
                              space(context),
                              block(context, Colors.green.shade100, 4,"Do you think there is another pain equal to childbirth?",8),
                              space(context),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              block(context, Colors.yellow, 0,"Best remedies for the fever which is not last upto 10 days.",10),
                              space(context),
                              block(context, Colors.yellow, 1,"What are some natural remedies for migraines?",12),
                              space(context),
                              block(context, Colors.yellow, 2,"How can I improve my sleep quality?",14),
                              space(context),
                              block(context, Colors.yellow, 3,"What are the symptoms and treatments for anxiety disorders?",16),
                              space(context),
                              block(context, Colors.yellow, 4,"Is there a cure for chronic back pain?",18),
                              space(context),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              WidgetBlock(
                                  context, Colors.cyanAccent, 0,
                                  "Sitamarhi,Bihar"),
                              space(context),
                              WidgetBlock(
                                  context, Colors.cyanAccent, 1,
                                  "Sitamarhi,Bihar"),
                              space(context),
                              WidgetBlock(
                                  context, Colors.cyanAccent, 2,
                                  "Amritsar,Punjab"),
                              space(context),
                              WidgetBlock(
                                  context, Colors.cyanAccent, 3,
                                  "Sangrur,Punjab"),
                              space(context),
                              WidgetBlock(
                                  context, Colors.cyanAccent, 4,
                                  "Saharsa,Bihar"),
                              space(context),
                            ],
                          ),
                        ),
                      ]),
                ),
                SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: const [
                        Text(
                          "Questions",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(thickness: 2, color: Colors.red,)
                      ],
                    )),
                verticalCont(context, Colors.white, 0),
                const Divider(thickness: 2, color: Colors.red,),
                verticalCont(context, Colors.white, 1),
                const Divider(thickness: 2, color: Colors.red,),
                verticalCont(context, Colors.white, 2),
                const Divider(thickness: 2, color: Colors.red,),
                verticalCont(context, Colors.white, 3),
                const Divider(thickness: 2, color: Colors.red,),
                verticalCont(context, Colors.white, 4),
                const Divider(thickness: 2, color: Colors.red,),
                verticalCont(context, Colors.white, 5),
                const Divider(thickness: 2, color: Colors.red,),
              ],
            )));
  }

  void getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('Name')!;
    setState(() {
      nName = name;
    });
  }

  Widget verticalCont(BuildContext context, Color colour, int i) {
    return Container(
        height: 120, width: double.maxFinite, color: colour,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(nName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          decorationColor: Colors.red,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      content: SizedBox(
                        // height: 120,
                        // width: 100,
                        child: Column(
                          children: [
                            Expanded(
                              child: Text(getQues(i),
                                  style: const TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple,
                                    decorationColor: Colors.red,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text(getQues(i),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue
                ),),
            ),
            Row(
              children: [
                IconButton(onPressed: () {
                  showDialog(context: context, builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Enter Your Answer"),
                      content: SizedBox(
                        height: 120,
                        width: 100,
                        child: Column(
                          children: [
                            Expanded(child: TextField(
                              controller: answerController,
                              minLines: 3,
                              maxLines: 35, decoration: const InputDecoration(
                              hintText: 'Type here...',
                            ),
                            ))
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(onPressed: () {
                          Navigator.of(context).pop();
                          answerController.text = '';
                        },
                            child: const Text('Cancel')),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            answerController.text = "";
                          },
                          child: const Text('Post'),
                        ),
                      ],
                    );
                  });
                },
                    icon: const Icon(Icons.edit,
                      size: 32.0,)),
                const Text("Write Your Answer", style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.red
                ),)
              ],
            )
          ],
        )
    );
  }

  Widget block(BuildContext context, Color colour, int index,String question,int contNumber) {
    return Container(
        width: 160,
        height: 210,
        alignment: Alignment.bottomCenter,
        color: colour,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () async{
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Top(i: contNumber),
                  ),
                );
              },
              child:
               Text(
                  question,
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                  )
              ),
            ),
            Container(
                width: 160,
                height: 40,
                color: Colors.white,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(Icons.account_circle_outlined),
                  TextButton(
                      onPressed: () {},
                      child: Text(getUser(index),
                          style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          )))
                ]))
          ],
        ));
  }

  Widget WidgetBlock(BuildContext context, Color colour, int index, String address) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
          padding: const EdgeInsets.all(15),
          width: 190,
          height: 220,
          alignment: Alignment.bottomCenter,
          color: colour,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(2500),
                child: Image.asset("assets/pic.png",
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.account_circle),
                  TextButton(
                    onPressed: () {
                      // Do something when the button is pressed
                    },
                    child: Text(getUser(index),overflow: TextOverflow.ellipsis,),
                  )
                  ,
                ],
              ),
              Text(address)
            ],
          )),
    );
  }
}
Widget space(BuildContext context) {
  return InkWell(
    child: Ink(height: 90, width: 10, color: Colors.transparent),
  );
}