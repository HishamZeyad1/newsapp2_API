import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app2/api/Comments_api.dart';
import 'package:news_app2/models/comment.dart';
import 'package:news_app2/models/post.dart';
import 'package:news_app2/utilities/data_utilities.dart';

class SinglePost extends StatefulWidget {
  final Post post;
  SinglePost(this.post);
  @override
  _SinglePostState createState() => _SinglePostState();
}

class _SinglePostState extends State<SinglePost> {
  late CommentsAPI commentsAPI;
  var len=1;
  @override
  Widget build(BuildContext context) {
    commentsAPI=CommentsAPI();
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              expandedHeight: 300.0,
              floating: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.post.featuredImage),
                        fit: BoxFit.cover),
                  ),
                ),
              )),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, position) {
                // var e= len==0?len+1:len;
              if (position == 0) {
                return _drawPostDetails();
              } else if (position >=1 && position <=len) {
                print("######################################["+position.toString()+"]:"+len.toString());
                return _comments();
              } else {
                return _commentTextEntry();
              }
            }, childCount:len+2),

          ),
        ],
      ),
    );
  }


  Widget _drawPostDetails() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text(
        widget.post.content,
        style: TextStyle(fontSize: 18, letterSpacing: 1.2, height: 1.25),
      ),
    );
  }

  Widget _comments() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: FutureBuilder(
        future:commentsAPI.fetChCommentsByPostId("7") ,
        builder:(context,AsyncSnapshot snapShot){
          switch (snapShot.connectionState) {
            case ConnectionState.waiting:
              return loading();
              break;
            case ConnectionState.active:
              return loading();
              break;
            case ConnectionState.none:
              return connectionError();
              break;
            case ConnectionState.done:
              if (snapShot.error != null) {
                return error(snapShot.error);
              } else {
                if (snapShot.hasData) {
                  List<Comment> comments = snapShot.data;len=comments.length;print(len);
                    Comment Comment1 = comments[0];

                    return Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage:
                              ExactAssetImage("assets/images/placeholder_bg.png"),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Christina'),
                                Text(parseHumanDateTime(Comment1.dateWritten)),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text( Comment1.content)
                            // 'Weasel the jeeper goodness inconsiderately spelled so ubiquitous amused knitted and altruistic amiable'),

                      ],
                    );
                  } else {
                  return noData();
                }
              }
              break;
          }
        },
      ),

    );
  }

  Widget _commentTextEntry() {
    return Container(
      color: Color.fromRGBO(241, 245, 247, 1),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Write Comment here!',
                      contentPadding: EdgeInsets.only( left: 16 , top: 24 , bottom: 28 )
                  ),
                ),
              ),
              FlatButton(
                child: Text(
                  'SEND',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
  Color getRandomColor({int minBrightness = 50}) {
    final random = Random();
    assert(minBrightness >= 0 && minBrightness <= 255);
    return Color.fromARGB(
      0xFF,
      minBrightness + random.nextInt(255 - minBrightness),
      minBrightness + random.nextInt(255 - minBrightness),
      minBrightness + random.nextInt(255 - minBrightness),
    );
  }

}




