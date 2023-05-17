import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medinet_app/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ChgPass extends StatefulWidget {
  const ChgPass({Key? key}) : super(key: key);

  @override
  State <ChgPass> createState() => _ChgPass();
}

class _ChgPass extends State<ChgPass> {
  bool check=true;
  final _formKey = GlobalKey<FormState>();
  var newPassword=" ";
  final newPasswordController = TextEditingController();
  final _confirmPass = TextEditingController();
  final oldPasswordController = TextEditingController();
  String oldpassword=" ";
  final uId  = FirebaseAuth.instance.currentUser!;
  @override
  void initState() {
    getpass();
    super.initState();
  }
  @override
  void dispose(){
    newPasswordController.dispose();
    _confirmPass.dispose();
    oldPasswordController.dispose();
    super.dispose();
  }
  changePassword() async{
    if(check){
      setState(() {
        newPassword = newPasswordController.text;
      });
      try{
        await uId.updatePassword(newPassword);
        FirebaseAuth.instance.signOut();
        Navigator.pushAndRemoveUntil(context, PageRouteBuilder(
          pageBuilder: (context, a, b) => const MyLogin(),
          transitionDuration: const Duration(seconds: 0),), (route) => false);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.black26,
            content: Text('Your Password has been Changed.. login again !',
              style: TextStyle(color: Color(0xFFFF6D00),
                  fontSize: 20,
                  fontWeight: FontWeight.w900),)
        ),);
      }on FirebaseAuthException catch(e){
        return e.message;
      }
    }
    }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Update Your Password")),
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 25.0),
            child: ListView(
              children: [
                const SizedBox(height: 100),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: Image.asset('assets/logo.png',)),),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    children: [
                      TextFormField(
                        autofocus: false,
                        obscureText: true,
                        controller: oldPasswordController,
                        decoration: const InputDecoration(
                          labelText: 'Current Password ',
                          hintText: 'Enter Current Password ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle: TextStyle(color: Colors.black26,fontSize: 15.0),
                        ),
                        validator: (value){
                          if(value == null || value.isEmpty){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                backgroundColor: Colors.black26,
                                content: Text('Please enter current Password!',)),);
                            check=false;
                          }
                          else if(value != oldpassword){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                backgroundColor: Colors.black26,
                                content: Text('Please enter your valid current Password!',)),);
                            check=false;
                          }
                          else {
                            check = true;
                          }
                        },
                      ),
                      TextFormField(
                        autofocus: false,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'New Password: ',
                          hintText: 'Enter new Password ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle: TextStyle(color: Colors.black26,fontSize: 15.0),
                        ),
                        controller: newPasswordController,
                        validator: (value){
                          if(value == null || value.isEmpty){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                backgroundColor: Colors.black26,
                                content: Text('Please enter new password',)),);
                            check=false;
                          }
                          else if(newPasswordController.text == oldPasswordController.text){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                backgroundColor: Colors.black26,
                                content: Text('Please try different password from current one!',)),);
                            check=false;
                          }
                          else {
                            check = true;
                          }
                        },
                      ),
                      TextFormField(
                          autofocus: false,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Confirm Password: ',
                            hintText: 'Repeat Your Password ',
                            labelStyle: TextStyle(fontSize: 20.0),
                            border: OutlineInputBorder(),
                            errorStyle: TextStyle(color: Colors.black26,fontSize: 15.0),
                          ),
                          controller: _confirmPass,
                          validator: (value){
                            if(value == null || value.isEmpty){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  backgroundColor: Colors.black26,
                                  content: Text('Please repeat your password!',)),);
                            }
                            else if(value != newPasswordController.text) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  backgroundColor: Colors.black26,
                                  content: Text('Password not match!',)),);
                              check=false;
                            }
                            else {
                              check = true;
                            }
                          }
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: (){
                      changePassword();
                  },
                  child: const Text('Change Password ',
                    style: TextStyle(
                        fontSize: 18.0),
                  ),),
              ],
            )
        ),
      ),
    );
  }

  void getpass() async{
    final pref=await SharedPreferences.getInstance();
    String password=pref.getString("Password")!;
    setState(() {
      oldpassword=password;
    });
  }
}