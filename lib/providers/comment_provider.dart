import 'package:flutter/foundation.dart';
import '../model/comment.dart';
import '../service/comment_service.dart';

class CommentProvider extends ChangeNotifier {
  final CommentService _commentService = CommentService();
  List<Comment> _comments = [];
  bool _isLoading = false;

  List<Comment> get comments => _comments;
  bool get isLoading => _isLoading;

  Future<void> fetchComments() async {
    _isLoading = true;
    notifyListeners();

    try {
      _comments = await _commentService.fetchComments();
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
