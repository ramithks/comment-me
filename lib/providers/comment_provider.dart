import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../model/comment.dart';

class CommentProvider extends ChangeNotifier {
  List<Comment> _comments = [];
  bool _isLoading = false;

  List<Comment> get comments => _comments;
  bool get isLoading => _isLoading;

  Future<void> fetchComments() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body) as List;
        _comments = jsonData
            .map((commentJson) => Comment.fromJson(commentJson))
            .toList();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching comments: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}