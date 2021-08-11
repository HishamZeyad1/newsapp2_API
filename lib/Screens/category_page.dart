import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:news_app2/Screens/home_screen.dart';
import 'package:news_app2/Screens/single_post.dart';
import 'package:news_app2/api/posts_api.dart';
import 'package:news_app2/api/posts_api.dart';
import 'package:news_app2/api/posts_api.dart';
import 'package:news_app2/api/posts_api.dart';
import 'package:news_app2/helper/CacheHelper.dart';
import 'package:news_app2/models/category.dart';
import 'package:news_app2/models/post.dart';
import 'package:news_app2/shared_ui/navigation_drawer.dart';
import 'package:news_app2/utilities/data_utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CategoryPage extends StatefulWidget {
  // final Category category;

  // CategoryPage(this.category);
  @override
  CategoryPageState createState() {
    return new CategoryPageState();
  }
}

class CategoryPageState extends State<CategoryPage>{
  // late PostsAPI postsAPI;
  late List<Category> Categories=[];
  ValueNotifier<int> _pageViewNotifier = ValueNotifier(0);
  late List<bool> _checked=[false,false,false,false,false,false,false];

  late List<int> NewsFavoriteList=[];
  late List<SharedPreferences> prefs=[];
    // late Map<String,bool> map={"key":follow,"value":true};
  bool block=false;
  // Future<void> sharedata() async {
// // await  SharedPreferences.getInstance();
//   // bool? _checked[0] = prefs[0].getBool('follow')!;  bool? seen = prefs[1].getBool('follow');
//   // bool? seen = prefs[2].getBool('follow');  bool? seen = prefs[3].getBool('follow');
//   // bool? seen = prefs[4].getBool('follow');  bool? seen = prefs[5].getBool('follow');
// }
  void sharedata() async {
    _checked=[false,false,false,false,false,false,false];
  prefs.length=_checked.length;
  // bool? _checked[0] = prefs[0].getBool('follow')!;
  for(int index=0;index<prefs.length;++index){
    print("**************************************************************");
    prefs[index]=await  SharedPreferences.getInstance();
    _checked[index] = prefs[index].getBool('follow$index')!;
    bool b=_checked[index];
    print("############################sharedata##############################");
    print( "_checked[index]:$b");
  }
  // prefs=[await  SharedPreferences.getInstance(),
  // await  SharedPreferences.getInstance(), await  SharedPreferences.getInstance(),
  // await  SharedPreferences.getInstance(), await  SharedPreferences.getInstance(),
  // await  SharedPreferences.getInstance(), await  SharedPreferences.getInstance()];
  // _checked[0] = prefs[0].getBool('follow')!;_checked[1] = prefs[1].getBool('follow')!;
  // _checked[2] = prefs[2].getBool('follow')!;_checked[3] = prefs[3].getBool('follow')!;
  // _checked[4] = prefs[4].getBool('follow')!;_checked[5] = prefs[5].getBool('follow')!;
  // _checked[6] = prefs[6].getBool('follow')!;
  print("############################sharedata##############################");
  // print("prefs[0]:");print(prefs[0].getBool('follow')!);
  // for(int a=0;a<prefs.length;++a){
  //   // prefs.add(await  SharedPreferences.getInstance());
  //     _checked[a] = prefs[a].getBool('follow')!;
  //   }
}
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
  // void _initialCheckCatgory(){
  //   _checked=[];
  //   _checked.length=Categories.length;
  //   print(_checked.length);
  //   for(int a=0;a<_checked.length;++a){
  //     _checked[a]=false;
  //     print(_checked[a]);
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   sharedata();
  // }
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    // TODO: implement initState
    super.initState();
   // sharedata();
    for(int i=0;i<7;++i){
      _checked[i] =(CacheHelper.getbool(key:"check$i")==null?_checked[i]:CacheHelper.getbool(key:"check$i"))!;
    }
  }
  @override
  Widget build(BuildContext context) {
    _addCategories();
    // if(!block){
    //   for(int i=0;i<7;++i){
    //     _checked[i] =(CacheHelper.getbool(key:"check$i")==null?_checked[i]:CacheHelper.getbool(key:"check$i"))!;
    //   }
    //   ;block=true;}

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
          Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
          child: SizedBox(
          width: double.infinity,
          height: 50,
          child: RaisedButton(
          color: Colors.red.shade900,
          child: Text(
          'Follow',
          style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          letterSpacing: 1,
          ),
          ),
          onPressed: () {
           _updateFollow();
          Navigator.push(
          context,
          MaterialPageRoute(
          builder: (context) {
          return HomeScreen();
          },
          ),
          );

          },
          ),
          ),
          ),
          ),]

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
  Widget _drawRecentUpdatesCard(Color color,  Category post,int index) {
    print( "Hisham Zryad:");
    print(prefs);
    print(prefs.length);//prefs.isEmpty?_checked[index]:prefs[index].getBool('follow')
    // bool? n=prefs[index]==null?_checked[index]:prefs[index].getBool('follow$index');
    // print("result:$n"_checked[index]);
    print(_checked[index]);
    // print("prefs[index]:$prefs[index]");

    // print(prefs[index].runtimeType==SharedPreferences);
    // print(prefs[index].getBool('follow'));
    return Stack(
     children: <Widget>[
      Card(
        child: GestureDetector(
          // onTap: (){
          //   Navigator.push(context, MaterialPageRoute(builder: ( context   ){
          //     // return SinglePost(post);
          //     return Container();
          //   }));
          // },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    // image: ExactAssetImage('assets/images/placeholder_bg.png'),
                    // image: NetworkImage( post.featuredImage ),
                    image: ExactAssetImage(post.image),
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
                    post.title,
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
      ),
       CheckboxListTile(
         secondary: Icon(Icons.check),
         value:_checked[index],
          // prefs[index]==null?_checked[index]:prefs[index].getBool('follow$index'),
         // prefs.isEmpty?_checked[index]:prefs[index].getBool('follow'),
         // prefs[index].getBool('follow')==false?_checked[index]:_checked[index],//_checked[index]:,
         onChanged: (bool? value) {
           setState(() {
             _checked[index]=!_checked[index];
             // CacheHelper.putbool(key: "check${index}", value: value!);

             // _checked[index]=value!;
             // prefs[index].setBool( 'follow$index' ,_checked[index]);
             // prefs[index].setBool( 'follow' ,_checked[index]);
             // if(value==true){
             //   NewsFavoriteList.add(index);
             //   // prefs[index].setBool( 'follow' ,true);
             // }else{
             //   NewsFavoriteList.remove(index);
             //   // prefs[index].setBool( 'follow' , false);
             // }
             print("NewsFavoriteList$NewsFavoriteList");
             // print(NewsFavoriteList);
             // NewsFavoriteList.add(index);
             // print(NewsFavoriteList);
           });
       },
       ),
     ]
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

  void _updateFollow(){
    //
    // //   SharedPreferences prefs = await SharedPreferences.getInstance();
    // print("###############################################################");
    //
      for(int index=0;index<_checked.length;++index){
      print("**************************************************************");
      CacheHelper.putbool(key: "check${index}", value:_checked[index]);

        // if(_checked[index]){
      //   // prefs[NewsFavoriteList[index]].setBool('check${NewsFavoriteList[index]}' ,true);
      //   // CacheHelper.putbool(key: "check${NewsFavoriteList[index]}", value:true);
      //   CacheHelper.putbool(key: "check${index}", value:true);
      // }else{
      //   // prefs[index].setBool('check$index' ,false);
      //   CacheHelper.putbool(key: "check${index}", value:false);
      // }
      // if(_checked[index]){
      //   prefs[index].setBool( 'follow' , true);
      //   print("###############################################################");
      //   print(prefs[index].getBool('follow'));
      //   print("###############################################################");
      // }else{
      //   prefs[index].setBool( 'follow' , false);
      //   print("###############################################################");
      //   print(prefs[index].getBool('follow'));
      //   print("###############################################################");
      // }
    }
  }


}