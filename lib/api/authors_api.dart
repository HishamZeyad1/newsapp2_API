import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:news_app2/utilities/api_utilities.dart';

import 'package:news_app2/models/author.dart';

class AuthorsAPI {

  Future<List<Author>> fetchAllAuthors() async {
    List<Author> authors = <Author>[];
    String allAuthorsApi = base_api + all_authors_api;
    var response = await http.get(allAuthorsApi);
    // var url = Uri.parse(allAuthorsApi); print("*****************");//192.168.42.6
    // var response = await http.get(url);    // var response = await http.get(allAuthorsApi);
    print(response.statusCode);    print("*****************"); print(response.body);//192.168.42.6\newsapp_api/public/api/authors

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var data = jsonData["data"];
      for (var item in data) {
        Author author = Author(item['id'].toString(), item['name'].toString(),
            item['email'].toString(), item['avatar'].toString());
        authors.add(author);
      }
    }

    return authors;
  }

}