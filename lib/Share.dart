import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medinet_app/NavBar.dart';
import 'package:medinet_app/post.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharePage extends StatefulWidget {
  const SharePage({Key? key}) : super(key: key);

  @override
  State<SharePage> createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  TextEditingController _headingController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  String _postedHeading = '';
  String _postedContent = '';
  String userName='';
  void getName()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name=prefs.getString('Name')!;
    setState(() { userName=name;});
  }
  @override
  void initState() {
    getName();
    super.initState();
  }
  @override
  void dispose() {
    _headingController.dispose();
    _contentController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(children: [
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
                      onPressed: () {
                        Navigator.pushNamed(context, 'userInfo');
                      },
                    )),
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Add Post",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                  decorationColor: Colors.red,
                ),
              ),
            ),
            Text(
              userName,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
                decorationColor: Colors.red,
                decoration: TextDecoration.underline
              ),
            ),
            const SizedBox(height: 10),
            const Divider(thickness: 5),
            Row(
              children: const [
                Text(
                  'Enter your heading:',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            TextField(
              decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(width: 3, color: Colors.black)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(width: 3, color: Color(0xFFD32F2F)))),
              style: const TextStyle(),
              maxLength: 200,
              minLines: 2,
              maxLines: 20,
              controller: _headingController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp('[A-Za-z0-9?.,:"!#%&*()-+|/; \n]'))
              ],
            ),
            Row(
              children: const [
                Text(
                  'Enter your content:',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            TextField(
              decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(width: 3, color: Color(0xFF0D47A1))),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(width: 3, color: Color(0xFFD32F2F)))),
              style: const TextStyle(),
              maxLength: 800,
              minLines: 3,
              maxLines: 50,
              controller: _contentController,
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
                        if (_headingController.text != "" && _contentController.text != "") {
                          _postedHeading = _headingController.text;
                          _headingController.text = "";
                          _postedContent = _contentController.text;
                          _contentController.text="";
                          DatabaseService obj =DatabaseService();
                          String uid=FirebaseAuth.instance.currentUser!.uid;
                          obj.savingPost(_postedHeading,_postedContent,uid);
                          // ignore: use_build_context_synchronously
                          showDialog(context: context, builder: (context){
                            return AlertDialog(backgroundColor: Colors.red.shade200,
                              title: const Text("Your Post has been added to the Community!\n"
                                  "You will able to see the posts in Your Post Section"),
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.pop(context);
                                  Navigator.pushNamed(context,'AllPost');
                                }, child: const Text("OK"))
                              ],
                            );
                          });
                        }else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(backgroundColor: Colors.black26, content: Text(
                              'Please Write your Post! Your post cannot be empty.',
                            )),
                          );
                        }
                      },
                      child: const Text("Share")),
                  const SizedBox(width: 2),
                  ElevatedButton(
                      onPressed: () {
                        if(_headingController.text=="" && _contentController.text==""){
                          Navigator.pushAndRemoveUntil(context, PageRouteBuilder(
                            pageBuilder: (context, a, b) => const NavBar(),
                            transitionDuration: const Duration(seconds: 0),),
                                  (route) => false);
                        }
                        setState(() {
                          _headingController.text = "";
                          _contentController.text="";
                        });
                        _postedHeading = _headingController.text;
                        _postedContent = _contentController.text;
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