import 'package:flutter/foundation.dart';
import '../models/comment.dart';
import '../services/comment_service.dart';

class CommentProvider extends ChangeNotifier {
  final CommentService _commentService = CommentService();
  final List<Comment> _comments = [];
  bool _isLoading = false;
  int _currentPage = 1;
  bool _hasMore = true;

  List<Comment> get comments => _comments;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> fetchComments({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 1;
      _comments.clear();
      _hasMore = true;
    }

    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    try {
      final newComments =
          await _commentService.fetchComments(page: _currentPage);
      if (newComments.isEmpty) {
        _hasMore = false;
      } else {
        _comments.addAll(newComments);
        _currentPage++;
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
