import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:news_app2/Screens/category_page.dart';
import 'package:news_app2/Screens/facebook_feeds.dart';
import 'package:news_app2/Screens/headline_news.dart';
import 'package:news_app2/Screens/home_screen.dart';
import 'package:news_app2/Screens/instagram_feed.dart';
import 'package:news_app2/Screens/twitter_feed.dart';
import 'package:news_app2/models/nav_menu.dart';

import 'package:news_app2/utilities/app_utilities.dart';
import 'package:news_app2/Screens/pages/login.dart';
import 'package:news_app2/Screens/pages/logout.dart';

import 'package:shared_preferences/shared_preferences.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();

}

class _NavigationDrawerState extends State<NavigationDrawer> {
  static bool isLoggedIn = false;
  late bool token;
  late SharedPreferences? sharedPreferences=null;
  int _a=3;

  int get a{return _a;}

  // SharedPreferences? get sharedPreferences =>
  //     _sharedPreferences; // late final Logout logout=new Logout(sharedPreferences1);

    List<NavMenuItem> navigationMenu = [
      NavMenuItem('Explore',()=>HomeScreen()),
      NavMenuItem('Headline News',()=>HeadLineNews()),
      NavMenuItem('TwitterFeeds',()=>TwitterFeed()),
      NavMenuItem("Instagram Feeds", () => InstagramFeed() ),
      NavMenuItem("Facebook Feeds", () => FacebookFeeds() ),
      NavMenuItem("Category", () => CategoryPage() ),

      NavMenuItem(isLoggedIn?"LogIn":"Logout",isLoggedIn?() => Login():() =>Login()),
//    NavMenuItem("Register", () => FacebookFeeds() ),
    ];
    @override
    Widget build(BuildContext context) {
      if( this.mounted ){
        _checkToken();
      }
      return Drawer(
        child: Padding(
          padding: EdgeInsets.only(top: 75, left: 24),
          child: ListView.builder(
            itemBuilder: (context, position) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(
                    navigationMenu[position].title,
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 22),
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Colors.grey.shade400,
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => navigationMenu[position].destination() ));
                  },
                ),
              );
            },
            itemCount: navigationMenu.length,
          ),
        ),
      );
    }

  _checkToken() async{
    sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences!.getBool('token')!;
    setState(() {
      if( token == null ){
        isLoggedIn = false;
      }else{
        isLoggedIn = true;
      }
    });
  }

  _logout(){
    if( sharedPreferences != null ){
      sharedPreferences!.remove('token');
    }
    return HomeScreen();
  }

  @override
  void initState() {
    super.initState();
    if( isLoggedIn ){
      navigationMenu.add( NavMenuItem("Logout", _logout() ) );
    }
  }

  }
