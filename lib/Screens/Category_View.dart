import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:news_app2/Screens/home_screen.dart';
import 'package:news_app2/Screens/single_post.dart';
import 'package:news_app2/api/posts_api.dart';
import 'package:news_app2/api/posts_api.dart';
import 'package:news_app2/api/posts_api.dart';
import 'package:news_app2/api/posts_api.dart';
import 'package:news_app2/home_tabs/popular.dart';
import 'package:news_app2/models/category.dart';
import 'package:news_app2/models/post.dart';
import 'package:news_app2/shared_ui/navigation_drawer.dart';
import 'package:news_app2/utilities/data_utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CategoryView extends StatefulWidget {
  // final Category category;

  // CategoryPage(this.category);
  @override
  CategoryPageState createState() {
    return new CategoryPageState();
  }
}

class CategoryPageState extends State<CategoryView>{
  // late PostsAPI postsAPI;
  // late CategoryAPI postsAPI;

  late List<Category> Categories;
  ValueNotifier<int> _pageViewNotifier = ValueNotifier(0);


  void _addCategories() {
    Categories = <Category>[];

    Categories.add(Category("1","Policy", 'assets/images/news/political-news.jpg'));
    Categories.add(Category("2","Economy", 'assets/images/news/Economy1.jpg'));
    Categories.add(Category("3","Sport", 'assets/images/news/sportCategory2.jpg'));
    Categories.add(Category("4","Healthy", 'assets/images/news/health news1.png'));
    Categories.add(Category("5","Science", 'assets/images/news/Science News5.jpeg'));
    Categories.add(Category("6","Technology", 'assets/images/news/technogy news4.jpeg'));
    Categories.add(Category("7","Tourism", 'assets/images/news/Tourism news1.jpg'));
  }
  @override
  Widget build(BuildContext context) {
    _addCategories();
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
        centerTitle: false,
        // actions: <Widget>[
        //   IconButton(icon: Icon(Icons.search), onPressed: () {}),
        //   // IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        //   // _popOutMenu(context),
        //
        // ],
      ),
      drawer: NavigationDrawer(),
      body:Stack(
          children:[
            Scaffold(
              body: ListView.builder(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _drawRecentUpdates(RandomColor(),Categories[index],index),
                      ],
                    ),
                  );
                },
                itemCount: Categories.length,

                // onPageChanged: (index) {
                //   _pageViewNotifier.value = index;
                // },
              ),

            ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
            //     child: SizedBox(
            //       width: double.infinity,
            //       height: 50,
            //       child: RaisedButton(
            //         color: Colors.red.shade900,
            //         child: Text(
            //           'Follow',
            //           style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 20,
            //             letterSpacing: 1,
            //           ),
            //         ),
            //         onPressed: () {
            //           _updateFollow();
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               builder: (context) {
            //                 return HomeScreen();
            //               },
            //             ),
            //           );
            //
            //         },
            //       ),
            //     ),
            //   ),
            // ),
          ]

      ),
    );

  }
  Color RandomColor(){
    Random r=new Random();
    int red=r.nextInt(255);
    int green=r.nextInt(255);
    int blue=r.nextInt(255);
    return new Color.fromRGBO(red, green, blue, 1);
  }
  Widget _drawRecentUpdates(Color co,Category ca,int index) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(0),
        // child: FutureBuilder(
        //   // future: postsAPI.fetchRecentUpdates(),
        //   future: postsAPI.fetChPostsByCategoryId( "2" ),
        //
        //   builder: (context, AsyncSnapshot snapShot) {
        //     switch (snapShot.connectionState) {
        //       case ConnectionState.waiting:
        //         return loading();
        //         break;
        //       case ConnectionState.active:
        //         return loading();
        //         break;
        //       case ConnectionState.none:
        //         return connectionError();
        //         break;
        //       case ConnectionState.done:
        //         if (snapShot.error != null) {
        //           return error(snapShot.error);
        //         } else {
        //           if (snapShot.hasData) {
        //             if (snapShot.data.length >= 2) {
        //               return Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: <Widget>[
        //                   // Padding(
        //                   //   padding: const EdgeInsets.only(
        //                   //       left: 16, bottom: 8, top: 8),
        //                   //   child: _drawSectionTitle('Recent Updates'),
        //                   // ),
        //                   _drawRecentUpdatesCard(
        //                       Colors.deepOrange, snapShot.data[0]),
        //                   _drawRecentUpdatesCard(Colors.teal, snapShot.data[1]),
        //                   SizedBox(
        //                     height: 48,
        //                   ),
        //
        //                 ],
        //               );
        //             }else { return noData();}
        //           } else {
        //             return noData();
        //           }
        //         }
        //         break;
        //     }
        //   },
        // ),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _drawRecentUpdatesCard( co,ca,index),
            // _drawRecentUpdatesCard( Colors.purple,Categories[1]),
            // _drawRecentUpdatesCard( Colors.green,Categories[2]),
            // _drawRecentUpdatesCard( Colors.cyan,Categories[3]),
            // _drawRecentUpdatesCard( Colors.amber,Categories[4]),
            // _drawRecentUpdatesCard( Colors.brown,Categories[5]),
            // _drawRecentUpdatesCard( Colors.indigo,Categories[6]),

            SizedBox(
              height: 48,
            ),
          ],
        ),

      ),
    );
  }
  Widget _drawRecentUpdatesCard(Color color,  Category category,int index) {
    String type;
    switch(index){
      case 0:type="Political News";break;
      case 1:type="Economy News";break;
      case 2:type="Sport News";break;
      case 3:type="Healthy News";break;
      case 4:type="Sciences News";break;
      case 5:type="Technology News";break;
      case 6:type="Tourism News";break;
      default:type="... News";break;
    }
    return Card(
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: ( context   ){
                  return Scaffold(
                    appBar: AppBar(
                      title: Text("$type"),
                      centerTitle: false,
                    ),
                    drawer: NavigationDrawer(),
                    body: Center(
                        child: Popular(index+1),
                    ),
                  );


                  // return Container();
                }));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        // image: ExactAssetImage('assets/images/placeholder_bg.png'),
                        // image: NetworkImage( post.featuredImage ),
                        image: ExactAssetImage(category.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                    width: double.infinity,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.4,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5/*, left: 16*/),
                    child: Container(
                      width:double.infinity,
                      padding: EdgeInsets.only(/*left: 24, */right: 24, top: 2, bottom: 0),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        category.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 0),
                    // padding: EdgeInsets.all(0),

                  ),
                ],
              ),
            ),
          );

  }
  Widget _drawSectionTitle(String title) {
    return Text(
      title,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
      style: TextStyle(
          color: Colors.grey.shade700,
          fontWeight: FontWeight.w600,
          fontSize: 16),
    );
  }
}