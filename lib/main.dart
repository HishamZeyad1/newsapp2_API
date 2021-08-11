import 'package:flutter/material.dart';
import 'package:news_app2/api/authors_api.dart';
import 'package:news_app2/api/posts_api.dart';
import 'package:news_app2/helper/CacheHelper.dart';
import 'Screens/OnBoarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/home_screen.dart';
import 'utilities/app_theme.dart';

void main() async{/*async*/
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  // SharedPreferences prefs = await  SharedPreferences.getInstance();
  // bool? seen = prefs.getBool('seen');
   Widget _screen;
  // if( seen == null || seen == false ){
    _screen = OnBoarding();
  // }else{
  //   _screen = HomeScreen();
  // }
  //_screen = HomeScreen();
  print(_screen);
  // PostsAPI postsAPI=new PostsAPI();
  // postsAPI.fetChSinglePosts("1");

  // AuthorsAPI a=new AuthorsAPI();
  // a.fetChAuthorsByPostId("1");

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
      home:this._screen,//OnBoarding(),//this._screen
    );
  }
}
