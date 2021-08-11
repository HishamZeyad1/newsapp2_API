import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:news_app2/Screens/single_post.dart';
import 'package:news_app2/models/author.dart';
import 'package:news_app2/models/category.dart';
import 'package:news_app2/models/comment.dart';
import 'dart:convert';
import 'package:news_app2/models/post.dart';
import 'package:news_app2/models/PostDetails.dart';
import 'package:news_app2/utilities/api_utilities.dart';


class PostsAPI {
  // Future<List<Post>> fetchWhatsNew() async {
  //   String whatsNewApi = base_api + whats_new_api;
  //   var response = await http.get( whatsNewApi );
  //   List<Post> posts = <Post>[];
  //   if( response.statusCode == 200 ){
  //     var jsonData = jsonDecode(  response.body);
  //     var data = jsonData["data"];
  //     print("****************************");
  //     for( var item in data ){
  //       Post post = Post(
  //           id: item["id"].toString(),
  //           title: item["title"].toString(),
  //           content: item["content"].toString(),
  //           dateWritten: item["date_written"].toString(),
  //           featuredImage: item["featured_image"].toString(),
  //           votesUp: item["votes_up"],
  //           votesDown: item["votes_down"],
  //           votersUp: (item["voters_up"] == null) ? <int>[] : jsonDecode( item["voters_up"] ),
  //           votersDown: (item["voters_down"] == null) ? <int>[] : jsonDecode( item["voters_down"] ),
  //           userId: item["user_id"],
  //           categoryId: item["category_id"]
  //       );
  //       posts.add(post);
  //       print( //post.id+" "+
  //           // post.content+" "+
  //            //post.dateWritten+" "+post.featuredImage
  //           // +" "+post.votersUp.length.toString()+" "+post.votersUp[0].toString()
  //           // +" "+
  //           // post.userId.toString() +" "+post.categoryId.toString()
  //               post.title
  //       );
  //     }
  //     print("****************************");
  //
  //   }
  //   return posts;
  // }

  //
  // Future<List<Post>> fetchRecentUpdates() async {
  //   String whatsNewApi = base_api + recent_updates_api;
  //   var response = await http.get( whatsNewApi );
  //   List<Post> posts = <Post>[];
  //   if( response.statusCode == 200 ){
  //     var jsonData = jsonDecode(  response.body);
  //     var data = jsonData["data"];
  //
  //     for( var item in data ){
  //       Post post = Post(
  //           id: item["id"].toString(),
  //           title: item["title"].toString(),
  //           content: item["content"].toString(),
  //           dateWritten: item["date_written"].toString(),
  //           featuredImage: item["featured_image"].toString(),
  //           votesUp: item["votes_up"],
  //           votesDown: item["votes_down"],
  //           votersUp: (item["voters_up"] == null) ?<int>[] : jsonDecode( item["voters_up"] ),
  //           votersDown: (item["voters_down"] == null) ?<int>[] : jsonDecode( item["voters_down"] ),
  //           userId: item["user_id"],
  //           categoryId: item["category_id"]
  //       );
  //       posts.add(post);
  //     }
  //   }
  //   return posts;
  // }



  Future<List<Post>> fetChPostsByCategoryId( String id ) async {
    //print("******************************************");
    String whatsNewApi = base_api + categories_api + id;
    var response = await http.get(whatsNewApi);
    List<Post> posts = <Post>[];
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var data = jsonData["data"];
      //print(response.body);
      for (var item in data) {
        Post post = Post(
            id: item["id"].toString(),
            title: item["title"].toString(),
            content: item["content"].toString(),
            dateWritten: item["date_written"].toString(),
            featuredImage: item["featured_image"].toString(),
            votesUp: item["votes_up"],
            votesDown: item["votes_down"],
            votersUp: (item["voters_up"] == null) ? <int>[] : jsonDecode(
                item["voters_up"]),
            votersDown: (item["voters_down"] == null) ? <int>[] : jsonDecode(
                item["voters_down"]),
            userId: item["user_id"],
            categoryId: item["category_id"],
            // author:item["author"],
            // category: item['category'],
            // created_at:item['created_at'],
            // updated_at: item['updated_at'],


        );
        posts.add(post);
      }
    }
    return posts;
  }

  Future<PostDetails> fetChSinglePosts( String id ) async {
    PostDetails post=new PostDetails(id:"2", title: "title", content: "content", dateWritten: "2021-06-06T15:19:59.000000Z",
        featuredImage: "featuredImage", votesUp: 22, votesDown: 22, votersUp: [], votersDown: [], userId: 2, categoryId: 2,
        created_at: "2021-06-06T15:19:59.000000Z", updated_at: "2021-06-06T15:19:59.000000Z",
        author: new Author(id: "1", name: "name", email: "email", avatar: "avatar"), category:new Category("2", "title"));
    //print("******************************************");
    String whatsNewApi = base_api + post_api + id;
    var response = await http.get(whatsNewApi);
    // List<PostDetails> PostDetail = <PostDetails>[];
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var data = jsonData["data"];
      // print(data[0]["updated_at"]);

      // print(response.body);
      // print(data);

      for (var item in data) {
        // post = PostDetails(
        //   id: data[0]["id"].toString(),
        //   title: data[0]["title"].toString(),
        //   content: data[0]["content"].toString(),
        //   dateWritten: data[0]["date_written"].toString(),
        //   featuredImage: data[0]["featured_image"].toString(),
        //   votesUp: data[0]["votes_up"],
        //   votesDown: data[0]["votes_down"],
        //   votersUp: (data[0]["voters_up"] == null) ? <int>[] : jsonDecode(
        //       data[0]["voters_up"]),
        //   votersDown: (data[0]["voters_down"] == null) ? <int>[] : jsonDecode(
        //       data[0]["voters_down"]),
        //   userId: data[0]["user_id"],
        //   categoryId: data[0]["category_id"],
        //   author:data[0]["author"],
        //   category: data[0]['category'],
        //   created_at:data[0]['created_at'],
        //   updated_at: data[0]['updated_at']
        // );
        // PostDetail.add(post);
        String id1=data[0]["id"].toString();
        String title1=data[0]["title"];
        String content1=data[0]["content"];
        String date_written1=data[0]["date_written"];
        String featured_image1=data[0]["featured_image"];
        int  votes_up=data[0]["votes_up"];//(data[0]["votes_up"] == null) ? 0 : jsonDecode(data[0]["votes_up"]);

        int votes_down=data[0]["votes_down"];//(data[0]["votes_down"] == null) ? 0: jsonDecode(data[0]["votes_down"]);
        List<int> voters_up=(data[0]["voters_up"] == null) ? <int>[] : jsonDecode(data[0]["voters_up"]);
        List<int> voters_down=(data[0]["voters_down"] == null) ? <int>[] : jsonDecode(data[0]["voters_down"]);
        int user_id=data[0]["user_id"];
        int category_id=data[0]["category_id"];
        String created_at=data[0]["created_at"];

        String updated_at=data[0]["updated_at"];
        // List<String> comments=data[0]["comments"];
        Author author=new Author(id: data[0]["author"]["id"].toString(), name: data[0]["author"]["name"], email: data[0]["author"]["email"],
            avatar:data[0]["author"]["avatar"]);
        Category category=new Category(data[0]["category"]["id"].toString(),data[0]["category"]["title"]);
        post=new PostDetails(id: id1, title: title1, content: content1, dateWritten: date_written1, featuredImage: featured_image1,
            votesUp: votes_up,
            votesDown:votes_down, votersUp: voters_up, votersDown: voters_down, userId: user_id, categoryId: category_id,
            created_at: created_at, updated_at: updated_at, author: author, category: category);
        print(post);
      }
    }
    // print(post);
    return post;
  }




}