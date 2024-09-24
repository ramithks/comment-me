import 'dart:convert';
import 'package:http/http.dart' as http;
import "package:commentme/model/comment.dart";

class CommentService {
  final int _limit = 20;

  Future<List<Comment>> fetchComments({int page = 1}) async {
    final response = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/comments?_page=$page&_limit=$_limit'));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body) as List;
      return jsonData
          .map((commentJson) => Comment.fromJson(commentJson))
          .toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }
}
