import 'package:firebase_auth/firebase_auth.dart' as fauth;
import 'package:flutter/foundation.dart';

import 'package:commentme/services/auth_service.dart';

import '../models/user.dart';
import '../services/service_locator.dart';
import '../services/user_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = getIt<AuthService>();
  fauth.User? _firebaseUser;

  fauth.User? get user => _firebaseUser;

  AuthProvider() {
    _authService.authStateChanges().listen((fauth.User? user) {
      _firebaseUser = user;
      notifyListeners();
    });
  }

  Future<void> createUser(String name, String email, String password) async {
    try {
      fauth.UserCredential authResult = await _authService.createUser(email, password);

      if (authResult.user == null) {
        throw Exception('authResult.user == null');
      }

      _firebaseUser = authResult.user;

      User user = User(
        id: authResult.user!.uid,
        name: name,
        email: authResult.user!.email,
      );
      
      final userService = getIt<UserService>();
      if (await userService.createNewUser(user)) {
        notifyListeners();
      } else {
        throw Exception('user was not created.');
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error creating Account: $e");
      }
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      fauth.UserCredential authResult = await _authService.login(email, password);
      _firebaseUser = authResult.user;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print("Error signing in: $e");
      }
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _authService.signOut();
      _firebaseUser = null;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print("Error signing out: $e");
      }
      rethrow;
    }
  }
}