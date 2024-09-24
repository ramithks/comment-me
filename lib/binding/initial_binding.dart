import 'package:get/get.dart';
import 'package:commentme/controller/auth_controller.dart';
import 'package:commentme/controller/user_controller.dart';
import 'package:commentme/service/auth_service.dart';
import 'package:commentme/service/user_service.dart';

class InitialBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    await Get.putAsync<AuthController>(
        () async => AuthController(authService: AuthService()),
        permanent: true);
    Get.put<UserController>(UserController(userService: UserService()),
        permanent: true);
  }
}
