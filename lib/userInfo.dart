import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'post.dart';
class UserInfo extends StatefulWidget {
  const UserInfo({super.key});
  @override
  State<UserInfo> createState() => _UserInfoState();
}
class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Information'),
      ),
      body: const MyCustomForm(),
    );
  }
}
// Create a Form widget.dart.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}
class MyCustomFormState extends State<MyCustomForm> {
  String name='',email='',experience='',
      state='',city='',phoneNumber='',pinCode='',age='';
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final timeController = TextEditingController();
  final pinController = TextEditingController();
  final stateController = TextEditingController();
  final experienceController =TextEditingController();
  final cityController= TextEditingController();
  final ageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String dropdownvalue="";
  @override
  void initState() {
    setValue();
    control();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var items=[
      "","Male","Female","Other"
    ];
    return SingleChildScrollView(
        child:Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: nameController,
                enabled: false,
                decoration: const InputDecoration(
                  icon:Icon(Icons.person),
                  hintText: 'Enter your name',
                  labelText: 'Name',
                ),
              ),
              TextFormField(
                controller: emailController,
                enabled: false,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Enter your e-mail',
                  labelText: 'E-mail',
                ),
              ),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(
                  icon:  Icon(Icons.phone),
                  hintText: 'Enter your 10 digit Phone Number',
                  labelText: 'Phone',
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp('[0-9+]'))
                ],
                onChanged: (value){
                  phoneNumber=value;
                },
              ),
              TextFormField(
                controller: ageController,
                decoration: const InputDecoration(
                  icon:  Icon(Icons.add),
                  hintText: 'Enter your Age',
                  labelText: 'Age',
                ),
                onChanged: (value){
                  age=value;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp('[0-9]'))
                ],
                maxLength: 3,
              ),
            Container(
              padding: const EdgeInsets.only(left: 24,right: 24),
              child: DropdownButton(
                hint: const Text('Select Gender'),
                dropdownColor: Colors.grey,
                icon: const Icon(Icons.arrow_drop_down, size: 40.0),
                isExpanded: true,
                value: dropdownvalue,
                items: items.map((String items){
                  return DropdownMenuItem(
                    value: items,
                    child:Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue){
                  setState((){
                    dropdownvalue=newValue! ;
                  });
                },
              ),
            ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.date_range_rounded),
                  enabled: false,
                  labelText: "Joined Us on"
                ),
                controller: timeController,
              ),
              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                controller: experienceController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.abc),
                  hintText: 'Any Experience?',
                  labelText: 'Any medical experience?',
                ),
                maxLength: 200,
                minLines: 2,
                maxLines: 4,
                onChanged: (value){
                  experience=value;
                },
              ),
              TextFormField(
                textCapitalization: TextCapitalization.words,
                controller: stateController,
                decoration:const InputDecoration(
                  icon: Icon(Icons.abc),
                  hintText: 'State',
                  labelText: 'State',
                ),
                onChanged: (value){
                  state=value;
                },
              ),
              TextFormField(
                textCapitalization: TextCapitalization.words,
                controller: cityController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.abc),
                  hintText: 'Enter your City',
                  labelText: 'City',
                ),
                onChanged: (value){
                  city=value;
                },
              ),
              TextFormField(
                controller: pinController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.add),
                  hintText: 'Pincode',
                  labelText: 'PIN',
                ),
                maxLength: 6,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp('[0-9]'))
                ],
                onChanged: (value){
                  pinCode=value;
                },
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue),
                  onPressed: (){
                    final DatabaseService obj=DatabaseService();
                    obj.updateInfo(email, phoneController.text, ageController.text, dropdownvalue,
                        experienceController.text, stateController.text, cityController.text, pinController.text);
                    obj.getInfo(email);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          backgroundColor: Colors.black26,
                          content: Text(
                            'Thank You, Your Profile has benn updated!',
                          )),
                    );
                  },
                  child: const Text('Submit',
                      style: TextStyle(color: Colors.black,
                          fontWeight: FontWeight.bold)),
                ),)
            ],
          ),
        ));
  }

  void setValue() async{
    final pref=await SharedPreferences.getInstance();
    String userName=pref.getString("Name")!;
    String userEmail=pref.getString("Email")!;
    nameController.text=userName;
    name=userName;
    emailController.text=userEmail;
    email=emailController.text;
    setState(() {});
  }


  void control() async{
    final SharedPreferences prefs=await SharedPreferences.getInstance();
    phoneController.text=prefs.getString('PhoneNo')??'';
    ageController.text=prefs.getString('Age')??'';
    dropdownvalue=prefs.getString('Gender')??'';
    experienceController.text=prefs.getString('Experience')??'';
    stateController.text=prefs.getString('State')??'';
    cityController.text=prefs.getString('City')??'';
    pinController.text=prefs.getString('Pin')??'';
  }
}