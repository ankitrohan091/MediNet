import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Liked extends StatefulWidget {
  const Liked({Key? key}) : super(key: key);
  @override
  State<Liked> createState() => _LikedState();
}
class _LikedState extends State<Liked> {
  int page=0;
  void getPage()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    page=prefs.getInt('initialPage')!;
  }
  @override
  void initState() {
    super.initState();
    getPage();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2,
        initialIndex: page,
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Liked Post"),
        elevation: 0,
        bottom: const TabBar(
          tabs: [
            Tab(child:Text("Post",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.yellowAccent
              ))
            ),
            Tab(child:Text("Questions",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellowAccent
                ))),
          ],
        ),
      ),
      body: const TabBarView(
        children: [
          Text("Answer"),
          Text("Question")
        ],
      ),
    ));
    // return Scaffold(
    //     appBar: AppBar(
    //       backgroundColor: Colors.blue,
    //       title: const Text("Liked Post"),
    //       elevation: 0,
    //     ),
    //     body: Column(
    //       children: [
    //         Container(
    //            width: MediaQuery.of(context).size.width,
    //           // height: 40,
    //           color: Colors.white12,
    //           child: OutlinedButton.icon(
    //             onPressed: () {
    //             },
    //             icon: const Icon(
    //               Icons.account_circle,
    //               size: 55.0,
    //             ),
    //             label: const Text("Uploaded By"), // <-- Text
    //           ),
    //         ),
            // ListTile(
            //   leading: Icon(CupertinoIcons.person),
            //   title: Text('This is post 1'),
            //   trailing: Row(
            //     mainAxisSize: MainAxisSize.min,
            //     children: <Widget>[
            //     ],
            //   ),
            // ),
            // Divider(),
            // ListTile(
            //   leading: Icon(CupertinoIcons.person),
            //   title: Text('This is post 2'),
            //   trailing: Row(
            //     mainAxisSize: MainAxisSize.min,
            //     children: <Widget>[
            //     ],
            //   ),
            // )
        //   ],
        // ));
  }
}
/*
getPage();
void getPage()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setInt('initialPage', 1);
  }
 */