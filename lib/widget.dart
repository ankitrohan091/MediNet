import 'package:shared_preferences/shared_preferences.dart';

class Widgets {
  static getUserSf() async {
    final pref=await SharedPreferences.getInstance();
    String userName=pref.getString('Name')!;
    return userName;
  }
}
