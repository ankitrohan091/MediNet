import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:medinet_app/post.dart';
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
  @override
  void initState() {
    getName();
    getQues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    TabController tabController = TabController(length: 3, vsync: this);
    return Scaffold(
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                        width: size.width * 0.70,
                      ),
                    ),
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
                          " Search MediNet!           ",
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
                          "ASK",
                          style: TextStyle(color: Colors.black),
                        )),
                        Tab(
                            child: Text(
                          "Experience",
                          style: TextStyle(color: Colors.black),
                        )),
                        Tab(
                            child: Text(
                          "Dicussions",
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
                          block(context, Colors.lightBlueAccent, "Profile_1"),
                          space(context),
                          block(context, Colors.greenAccent, "Profile_2"),
                          space(context),
                          block(context, Colors.blueGrey, "Profile_3"),
                          space(context),
                          block(context, Colors.yellow, "Profile_4"),
                          space(context),
                          block(context, Colors.green, "Profile_5"),
                          space(context),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          block(context, Colors.lightBlueAccent, "Profile_1"),
                          space(context),
                          block(context, Colors.greenAccent, "Profile_2"),
                          space(context),
                          block(context, Colors.blueGrey, "Profile_3"),
                          space(context),
                          block(context, Colors.yellow, "Profile_4"),
                          space(context),
                          block(context, Colors.green, "Profile_5"),
                          space(context),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          block(context, Colors.lightBlueAccent, "Profile_1"),
                          space(context),
                          block(context, Colors.greenAccent, "Profile_2"),
                          space(context),
                          block(context, Colors.blueGrey, "Profile_3"),
                          space(context),
                          block(context, Colors.yellow, "Profile_4"),
                          space(context),
                          block(context, Colors.green, "Profile_5"),
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
                          "Community Feed",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )),
                verticalCont(context, Colors.deepPurple),
                verticalCont(context, Colors.blue),
                verticalCont(context, Colors.red),
                verticalCont(context, Colors.green),
                verticalCont(context, Colors.black38),
                verticalCont(context, Colors.orange)
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
  void getQues() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    String? question=prefs.getString('question');
    if(question==null){
      question=" ";
    }
    setState(() {
      topQues=question!;
    });
  }
  Widget verticalCont(BuildContext context, Color colour){
    return Container(
      height: 120, width: double.maxFinite, color: colour,
      child: Text(topQues),
    );
  }
}

Widget block(BuildContext context, Color colour, String name) {
  return Container(
      width: 160,
      height: 210,
      alignment: Alignment.bottomLeft,
      color: colour,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
              onPressed: (){},
              child:
                  const Text("My app question is vgdfg srbgsrnngjrsrb  f hfherfefefe fef f e fb cd d rd hdtrhrt hrtdhrhrhrthtr",
                  maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20,
                    )
                  ),
              ),
          Container(
              width: 160,
              height: 40,
              color: Colors.white,
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(Icons.account_circle_outlined),
                TextButton(
                    onPressed: () {
                      print("It's your Profile");
                    },
                    child: Text(name,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        )))
              ]))
        ],
      ));
}
Widget space(BuildContext context) {
  return InkWell(
    child: Ink(height: 90, width: 10, color: Colors.transparent),
  );
}
