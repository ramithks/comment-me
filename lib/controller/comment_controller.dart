import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:commentme/model/comment.dart';

class CommentController extends GetxController {
  var comments = <Comment>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchComments();
    super.onInit();
  }

  void fetchComments() async {
    isLoading(true);
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body) as List;
        comments.value = jsonData
            .map((commentJson) => Comment.fromJson(commentJson))
            .toList();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching comments: $e');
      }
    } finally {
      isLoading(false);
    }
  }
}
