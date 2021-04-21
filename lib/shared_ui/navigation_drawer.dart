
import 'package:flutter/material.dart';
import 'package:news_app2/Screens/facebook_feeds.dart';
import 'package:news_app2/Screens/headline_news.dart';
import 'package:news_app2/Screens/home_screen.dart';
import 'package:news_app2/Screens/instagram_feed.dart';
import 'package:news_app2/Screens/twitter_feed.dart';
import 'package:news_app2/models/nav_menu.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
    List<NavMenuItem> navigationMenu = [
      NavMenuItem('Explore',()=>HomeScreen()),
      NavMenuItem('Headline News',()=>HeadLineNews()),
      NavMenuItem('TwitterFeeds',()=>TwitterFeed()),
      NavMenuItem("Instagram Feeds", () => InstagramFeed() ),
      NavMenuItem("Facebook Feeds", () => FacebookFeeds() ),

    ];

    @override
    Widget build(BuildContext context) {
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
  }
