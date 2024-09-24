import 'package:firebase_auth/firebase_auth.dart' as fauth;
import 'package:flutter/foundation.dart';

import 'package:commentme/services/auth_service.dart';

import '../models/user.dart';
import '../services/service_locator.dart';
import '../services/user_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = getIt<AuthService>();
  fauth.User? _firebaseUser;
  bool _isLoading = false;

  fauth.User? get user => _firebaseUser;
  bool get isLoading => _isLoading;

  AuthProvider() {
    _authService.authStateChanges().listen((fauth.User? user) {
      _firebaseUser = user;
      notifyListeners();
    });
  }

  Future<void> createUser(String name, String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      fauth.UserCredential authResult = await _authService.createUser(email, password);

      if (authResult.user == null) {
        _isLoading = false;
        notifyListeners();
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
        _isLoading = false;
        notifyListeners();
      } else {
        _isLoading = false;
        notifyListeners();
        throw Exception('user was not created.');
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      if (kDebugMode) {
        print("Error creating Account: $e");
      }
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      fauth.UserCredential authResult = await _authService.login(email, password);
      _firebaseUser = authResult.user;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
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