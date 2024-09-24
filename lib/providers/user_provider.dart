import 'package:flutter/foundation.dart';

import 'package:commentme/services/user_service.dart';

import '../models/user.dart';
import '../services/service_locator.dart';

class UserProvider extends ChangeNotifier {
  final UserService _userService = getIt<UserService>();
  User? _user;

  User? get user => _user;

  Future<void> fetchUser(String uid) async {
    try {
      _user = await _userService.getUser(uid);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user: $e');
      }
      _user = null;
      notifyListeners();
    }
  }

  void clear() {
    _user = null;
    notifyListeners();
  }
}
