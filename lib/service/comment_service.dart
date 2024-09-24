import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/comment.dart';

class CommentService {
  Future<List<Comment>> fetchComments() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body) as List;
      return jsonData.map((commentJson) => Comment.fromJson(commentJson)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }
}