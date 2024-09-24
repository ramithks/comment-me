import 'package:flutter/material.dart';

import 'package:commentme/views/home.dart';
import 'package:commentme/views/login.dart';
import 'package:commentme/views/signup.dart';

class AppRouter {
  static const String login = '/';
  static const String signup = '/signup';
  static const String home = '/home';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginView());
      case signup:
        return MaterialPageRoute(builder: (_) => SignUpView());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}