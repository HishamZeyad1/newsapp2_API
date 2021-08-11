import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app2/Screens/single_post.dart';
import 'package:news_app2/api/authors_api.dart';
import 'package:news_app2/api/posts_api.dart';
import 'package:news_app2/models/PostDetails.dart';
import 'package:news_app2/models/author.dart';
import 'package:news_app2/models/post.dart';
import 'package:news_app2/utilities/data_utilities.dart';

class Favourites extends StatefulWidget {
  late int id=1;
  Favourites( this.id);
  @override
  _FavouritesState createState() => _FavouritesState(this.id);
}

class _FavouritesState extends State<Favourites> {
  List<Color> colorsList = [
  Colors.red,
  Colors.teal,
  Colors.deepOrange,
  Colors.indigo,
  Colors.brown,
  Colors.purple
  ];
  Random random = Random();
  Color _getRandomColor() {
  return colorsList[random.nextInt(colorsList.length)];
  }

  PostsAPI postsAPI = PostsAPI();
  AuthorsAPI authorsAPI=new AuthorsAPI();
  late int id;
  _FavouritesState(int id){this.id=id;}

  @override
  Widget build(BuildContext context) {
        return FutureBuilder(
          future:postsAPI.fetChPostsByCategoryId("$id"),
            builder: (BuildContext context, AsyncSnapshot snapShot) {
              switch ( snapShot.connectionState ){
                case ConnectionState.none :
                  return connectionError();
                  break;
                case ConnectionState.waiting :
                  return loading();
                  break;
                case ConnectionState.active :
                  return loading();
                  break;
                case ConnectionState.done :

                  if( snapShot.hasError ){
                    return error( snapShot.error );
                  }else {
                    List<Post> posts = snapShot.data;
                    return ListView.builder(
                      itemBuilder: (context, position) {
                       print(posts[position].id);
                       print("==============================================");

                       return Card(
                          child: Container(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: <Widget>[
                        FutureBuilder(
                        future:postsAPI.fetChSinglePosts(posts[position].id),
                        builder: (BuildContext context, AsyncSnapshot snapShot) {
                        switch ( snapShot.connectionState ){
                          case ConnectionState.none :
                          return connectionError();
                          break;
                          case ConnectionState.waiting :
                          return loading();
                          break;
                          case ConnectionState.active :
                          return loading();
                          break;
                          case ConnectionState.done :

                          if( snapShot.hasError ){
                          return error( snapShot.error );
                          }else {
                            if (snapShot.hasData) {
                              PostDetails post = snapShot.data;
                              return _authorRow(post);
                            }else {return noData();}
                            // PostDetails post1 = snapShot.data;
                            print("*************post1****************");
                            // print(post1["data"]["id"]);
                          return _authorRow(snapShot.data);
                        }}}),
                        //         FutureBuilder(
                        // future:authorsAPI.fetChAuthorsByPostId("$id"),
                        // builder: (BuildContext context, AsyncSnapshot<Author> snapshot) {
                        //         return _authorRow("$id");}),
                        //         _authorRow(post1),

                            SizedBox( height: 16, ),
                                _newsItemRow(posts[position]),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: posts.length,
                    );
                  }
              }
            }

        );
  }

  Widget _authorRow(PostDetails postDetails) {
    print(postDetails);
        return  Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        // image: // ExactAssetImage('assets/images/placeholder_bg.png'),
                        image:NetworkImage(postDetails.author.avatar),//postDetails.featuredImage
                        // image:ExactAssetImage('assets/images/placeholder_bg.png'),
                        fit: BoxFit.cover),
                    shape: BoxShape.circle,
                  ),
                  width: 50,
                  height: 50,
                  margin: EdgeInsets.only(right: 16),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.values.first,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: <Widget>[
                    Text(
                      // 'Michael Adams',
                      postDetails.author.name,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    // SizedBox(
                    //   height: 8,
                    // ),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment:MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            // '15 Min .',
                            parseHumanDateTime( postDetails.dateWritten ),
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Text(
                          // 'Life Style',
                         postDetails.category.title,
                          style: TextStyle(
                            color: _getRandomColor(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            // IconButton(
            //   icon: Icon(Icons.bookmark_border),
            //   onPressed: () {},
            //   color: Colors.grey,
            // ),
          ],
        );
      }

  Widget _newsItemRow(Post post) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: ( context ){
          return SinglePost( post );
        }));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.values.first,

        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  // image: ExactAssetImage('assets/images/placeholder_bg.png'),
                  image: NetworkImage( post.featuredImage ),
                  fit: BoxFit.cover),
            ),
            width: 124,
            height: 124,
            margin: EdgeInsets.only( right: 16 ),
          ),
          Expanded(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.values.first,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.values.first,
              children: <Widget>[
                Text(
                  // 'Tech Tent: Old phones and safe social',
                  post.title,
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:8),
                  child: Text(
                    // 'We also talk about the future of work as the robots advance, and we ask whether a retro phone',
                   post.content,
                    maxLines: 4,

                    style: TextStyle(color: Colors.grey, fontSize: 16 , height: 1.25),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

