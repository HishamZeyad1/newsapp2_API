import 'package:flutter/material.dart';
import 'package:news_app2/api/authentication_api.dart';
import 'package:news_app2/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Logout extends StatefulWidget {
  // SharedPreferences? sharedPreferences=null;
  // int a;
  @override
  _LogoutState createState() => _LogoutState();

  // Logout(int a){
  //   this.a= a;
  // }
}
class _LogoutState extends State<Logout> {
  static bool isLoggedIn = false;
  late bool token;
  late SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    if( sharedPreferences != null ){
      sharedPreferences.remove('token');
    }
    return HomeScreen();
  }

  // _checkToken() async{
  //   initState();
  //   setState(() {
  //     if( token == null ){
  //       isLoggedIn = false;
  //     }else{
  //       isLoggedIn = true;
  //     }
  //   });
  // }

  // @override
  // Future<void> initState() async {
  //   super.initState();
  //   sharedPreferences = await SharedPreferences.getInstance();
  //   token = sharedPreferences.getBool('token')!;
  // }


}