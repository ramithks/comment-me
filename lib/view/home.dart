import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:commentme/controller/auth_controller.dart';
import 'package:commentme/controller/user_controller.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final authController = Get.find<AuthController>();
  final userController = Get.find<UserController>();

  void _changeLanguage(String languageCode) {
    Locale locale;
    switch (languageCode) {
      case 'en':
        locale = const Locale('en', 'US');
        break;
      case 'ar':
        locale = const Locale('ar', 'SA');
        break;
      default:
        locale = const Locale('en', 'US');
    }
    Get.updateLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Obx(() => Text('${'welcome'.tr} ${userController.user.name}')),
          centerTitle: true,
          actions: [
            PopupMenuButton<String>(
              icon: const Icon(Icons.language),
              onSelected: _changeLanguage,
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'en',
                  child: Text('english'.tr),
                ),
                PopupMenuItem<String>(
                  value: 'ar',
                  child: Text('arabic'.tr),
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                authController.signOut();
              },
            ),
          ],
        ),
        body: const Center());
  }
}
