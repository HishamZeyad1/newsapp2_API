import 'dart:convert';
import 'package:news_app2/models/comment.dart';
import 'package:news_app2/utilities/api_utilities.dart';
import 'package:http/http.dart' as http;

class CommentsAPI{

  late List<Comment> Comments;
  late int len;
  Future<List<Comment>> fetChCommentsByPostId( String id ) async {
    String NewCommentApi = base_api + Comments_api + id;
    var response = await http.get(NewCommentApi);
     Comments = <Comment>[];
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var data = jsonData["data"];

      for (var item in data) {
        Comment comment = Comment(
            id: item["id"].toString(),
            content: item["content"].toString(),
            dateWritten: item["date_written"].toString(),
            userId: item["user_id"].toString(),
            postId: item["post_id"].toString()
        );
        Comments.add(comment);
        print("Comment:"+comment.toString());
      }
    }
    return Comments;
  }

  int getSize(){
      this.len=Comments.length;
    return len;
  }

}