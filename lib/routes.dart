import 'package:get/get.dart';
import 'package:commentme/view/home.dart';
import 'package:commentme/view/login.dart';
import 'package:commentme/view/signup.dart';

class Routes {
  // ignore_for_file: constant_identifier_names
  static const LOGIN = '/';
  static const SIGNUP = '/signup';
  static const HOME = '/home';
  static final routes = [
    GetPage(
      name: LOGIN,
      page: () => Login(),
      transition: Transition.circularReveal,
    ),
    GetPage(
      name: SIGNUP,
      page: () => SignUp(),
      transition: Transition.circularReveal,
    ),
    GetPage(
      name: HOME,
      page: () => Home(),
      transition: Transition.circularReveal,
    ),
  ];
}
