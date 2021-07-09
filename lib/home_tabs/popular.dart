import 'package:flutter/material.dart';
import 'package:news_app2/Screens/single_post.dart';
import 'package:news_app2/api/authors_api.dart';
import 'package:news_app2/api/posts_api.dart';
import 'package:news_app2/models/author.dart';
import 'package:news_app2/models/post.dart';
import 'package:news_app2/utilities/data_utilities.dart';
class Popular extends StatefulWidget {
  late int id=3;

  Popular( this.id);

  @override
  _PopularState createState() => _PopularState(this.id);
}

class _PopularState extends State<Popular> {
  PostsAPI postsAPI = PostsAPI();

  AuthorsAPI authorsAPI=new AuthorsAPI();
  late int id;
  _PopularState(int id){this.id=id;}

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: postsAPI.fetChPostsByCategoryId("$id"),
        builder: (context, AsyncSnapshot snapShot) {
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
                    return Card(
                      // child: _drawSingleRow(),
                      child: _drawSingleRow( posts[position] ) ,
                    );
                  }, itemCount: posts.length,
                );
              }
          }

        });



  }



  Widget _drawSingleRow(Post post) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: ( context ){
            return SinglePost( post );
          }));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              child: Image(
                // image: ExactAssetImage('assets/images/placeholder_bg.png'),
                image: NetworkImage( post.featuredImage ),
                fit: BoxFit.cover,
              ),
              width: 100,
              height: 100,
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(
                    // 'The World Global Warming Annual Summit',
                    post.title,
                    maxLines: 2,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // Text('Michael Adams',style: TextStyle(fontSize: 12)),
                      Container(
                          child:FutureBuilder(
                              future:authorsAPI.fetChAuthorsByPostId(post.userId.toString()),
                              builder: (context,AsyncSnapshot  snapShot) {
                                switch (snapShot.connectionState) {
                                  case ConnectionState.waiting:return loading(); break;
                                  case ConnectionState.active: return loading(); break;
                                  case ConnectionState.none: return connectionError();break;
                                  case ConnectionState.done:
                                    if (snapShot.error != null) {return error(snapShot.error);}
                                    else {
                                      if (snapShot.hasData) {
                                        Author author = snapShot.data;
                                        return Text(author.name, style: TextStyle(fontSize: 12),);
                                      }else {return noData();}
                                    };break;}})),

                      Row(
                        children: <Widget>[
                          Icon(Icons.timer),
                          // Text('15 min'),
                          Text( parseHumanDateTime( post.dateWritten ),
                              style: TextStyle(fontSize: 12)),


                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}