import 'package:flutter/material.dart';
import 'Screens/OnBoarding.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/home_screen.dart';
import 'utilities/app_theme.dart';

void main() async{/*async*/
  WidgetsFlutterBinding.ensureInitialized();
  //
  // SharedPreferences prefs = await  SharedPreferences.getInstance();
  // bool seen = prefs.getBool( 'seen' );
  Widget _screen;
  // if( seen == null || seen == false ){
  //   _screen = OnBoarding();
  // }else{
  //   _screen = HomeScreen();
  // }
  _screen = HomeScreen();
  print(_screen);
  runApp(NewsApp(_screen));//NewsApp(_screen)
}

class NewsApp  extends StatelessWidget {
  // This widget is the root of your application.
  final Widget _screen;

  NewsApp (this._screen);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     theme: AppTheme.appTheme,
      home:OnBoarding(),//this._screen
    );
  }
}
