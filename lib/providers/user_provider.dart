import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:commentme/service/user_service.dart';

import '../model/user.dart';
import '../service/service_locator.dart';

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
