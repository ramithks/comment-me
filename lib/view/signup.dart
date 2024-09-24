import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:commentme/controller/auth_controller.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthController controller = Get.find<AuthController>();

  final _formKey = GlobalKey<FormState>();

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sign_up'.tr),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'full_name'.tr,
                  ),
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please_enter_full_name'.tr;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'email'.tr,
                  ),
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please_enter_email'.tr;
                    }
                    if (!isValidEmail(value)) {
                      return 'please_enter_valid_email'.tr;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'password'.tr,
                  ),
                  obscureText: true,
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please_enter_password'.tr;
                    }
                    if (value.length < 6) {
                      return 'password_min_length'.tr;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: Text('sign_up'.tr),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      controller.createUser(
                        nameController.text,
                        emailController.text,
                        passwordController.text,
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}