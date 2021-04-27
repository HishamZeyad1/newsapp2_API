import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:news_app2/models/post.dart';
import 'package:news_app2/utilities/api_utilities.dart';


class PostsAPI {
  Future<List<Post>> fetchWhatsNew() async {
    String whatsNewApi = base_api + whats_new_api;
    var response = await http.get( whatsNewApi );
    List<Post> posts = <Post>[];
    if( response.statusCode == 200 ){
      var jsonData = jsonDecode(  response.body);
      var data = jsonData["data"];
      print("****************************");
      for( var item in data ){
        Post post = Post(
            id: item["id"].toString(),
            title: item["title"].toString(),
            content: item["content"].toString(),
            dateWritten: item["date_written"].toString(),
            featuredImage: item["featured_image"].toString(),
            votesUp: item["votes_up"],
            votesDown: item["votes_down"],
            votersUp: (item["voters_up"] == null) ? <int>[] : jsonDecode( item["voters_up"] ),
            votersDown: (item["voters_down"] == null) ? <int>[] : jsonDecode( item["voters_down"] ),
            userId: item["user_id"],
            categoryId: item["category_id"]
        );
        posts.add(post);
        print( //post.id+" "+
            // post.content+" "+
             //post.dateWritten+" "+post.featuredImage
            // +" "+post.votersUp.length.toString()+" "+post.votersUp[0].toString()
            // +" "+
            // post.userId.toString() +" "+post.categoryId.toString()
                post.title
        );


      }
      print("****************************");

    }
    return posts;
  }



  Future<List<Post>> fetchRecentUpdates() async {
    String whatsNewApi = base_api + recent_updates_api;
    var response = await http.get( whatsNewApi );
    List<Post> posts = <Post>[];
    if( response.statusCode == 200 ){
      var jsonData = jsonDecode(  response.body);
      var data = jsonData["data"];

      for( var item in data ){
        Post post = Post(
            id: item["id"].toString(),
            title: item["title"].toString(),
            content: item["content"].toString(),
            dateWritten: item["date_written"].toString(),
            featuredImage: item["featured_image"].toString(),
            votesUp: item["votes_up"],
            votesDown: item["votes_down"],
            votersUp: (item["voters_up"] == null) ?<int>[] : jsonDecode( item["voters_up"] ),
            votersDown: (item["voters_down"] == null) ?<int>[] : jsonDecode( item["voters_down"] ),
            userId: item["user_id"],
            categoryId: item["category_id"]
        );
        posts.add(post);
      }
    }
    return posts;
  }



  Future<List<Post>> fetChPostsByCategoryId( String id ) async {
    String whatsNewApi = base_api + categories_api + id;
    var response = await http.get(whatsNewApi);
    List<Post> posts = <Post>[];
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var data = jsonData["data"];

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
            categoryId: item["category_id"]
        );
        posts.add(post);
      }
    }
    return posts;
  }
}