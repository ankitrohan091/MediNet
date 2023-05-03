import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'GetHelp.dart';
class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);
  @override
  State<Help> createState() => _HelpState();
}
class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Help"),
        elevation: 0,
      ),
      body: ListView(
        itemExtent: 50.0,
        children: [
          Container(
            color: Colors.purple[600],
            child: ListTile(
              title: const Center(child: Text(
                  "How can we help you?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.amberAccent)),),
              trailing: GestureDetector(onTap: (){
              },
                  child: Container(height:45,width:50,color:Colors.amber,child: const Icon(Icons.add_alert_sharp))),
            ),
          ),
          // const Divider(thickness: 2,),
          helpTopic(context, "How to Start with MediNet","⦿ How to start with MediNet",
              "Welcome to the MediNet community. Hope you are doing well.There is lot to do on this platform, activities you can do are :-\n\n• "
                  "Ask your questions regarding disorders. \n\n• Help others to get rid of disorders. \n\n• You can browse discussions."),

          const Divider(thickness: 2),

          helpTopic(context,"Account Management and Security!","⦿ Account management and security",
              "In MediNet community, account management "
                  "and security are crucial aspects to ensure the privacy and confidentiality of "
                  "sensitive personal and medical information of its users."
                  '\n\n• 𝐔𝐬𝐞𝐫 𝐑𝐞𝐠𝐢𝐬𝐭𝐫𝐚𝐭𝐢𝐨𝐧: Users can create an account by providing their name, email address, '
                  'and a strong password. They can also add other relevant information such as '
                  'phone number, address, and date of birth in user details section'
                  '\n\n• 𝐋𝐨𝐠𝐢𝐧 𝐚𝐧𝐝 𝐋𝐨𝐠𝐨𝐮𝐭: Users can securely log in and log out of their account by email verification.'
                  '\n\n• 𝐀𝐜𝐜𝐨𝐮𝐧𝐭 𝐒𝐞𝐭𝐭𝐢𝐧𝐠𝐬: Users can update their personal information, change their password, and many more.'
                  '\n\n• 𝐏𝐫𝐢𝐯𝐚𝐜𝐲 𝐏𝐨𝐥𝐢𝐜𝐲: The application have a clear and concise privacy policy '
                  'that outlines how user data is collected, stored, and used. This policy is easily accessible to users and regularly updated.'
                  "\n\n• 𝐃𝐚𝐭𝐚 𝐒𝐞𝐜𝐮𝐫𝐢𝐭𝐲: The application uses standard encryption methods to protect user data both in transit and at rest."),

          const Divider(thickness: 2,),

          helpTopic(context,"Resources available in MediNet.","⦿ Resources available in MediNet",
              "Well, Users priceless experiences is "
                  "one of the main resources you will find on MediNet.\n"
                  '\nOther than that you can also use following resources :-'
                  '\n• You can get information about your disease by searching for it in search bar.'
                  '\n• You can browse for recent topics people searched frequently.'),

          const Divider(thickness: 2,),

          helpTopic(context, "What to do if any opinion do not suites you?","⦿ What to do if any opinion do not suites you?",
              "First of all you should not try any remedy you see about your disease.It might happen that one solution works fine for others "
                  "but do not for you.In case you feel uneasy or any kind of discomfort after trying any solution, then go through these steps:-"
                  "\n\n• At first stop proceeding with the solution anymore. \n\n• Go to the nearest hospital or contact any health expert you can."
                  "\n\n• After getting relief from the problem, you can also share your opinion on the platform so it can be helpful to other."),

          const Divider(thickness: 2,),

          const ListTile(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyQuestion()),
                );
              }, icon:const Icon(Icons.headset_mic_rounded)),
              TextButton(onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyQuestion()),
              );},
                  child: const Text("Get Help",
                      style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown)),)
            ],
          )
        ],
      ),
    );
  }
}
Widget helpTopic(context,String name,String head,String topicName){
  return ListTile(
      leading:const Icon(CupertinoIcons.arrow_right),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => newPage(context,head,topicName)),
        );
      },
      title: Text(name,
          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black)),
  );
}
Widget newPage(BuildContext context,String head,String topic){
  return
   Scaffold(
        appBar: AppBar(title: Text(head),),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Text(topic,
                    style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black45)
                ),
              ),
            ],
          ),
        )
  );
}