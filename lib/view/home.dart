import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:commentme/controller/auth_controller.dart';
import 'package:commentme/controller/user_controller.dart';
import 'package:commentme/controller/comment_controller.dart';
import 'package:commentme/routes.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final authController = Get.find<AuthController>();
  final userController = Get.find<UserController>();
  final commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text('Welcome ${userController.user.name ?? ''}')),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              await authController.signOut();
              Get.offAllNamed(Routes.LOGIN);
            },
          ),
        ],
      ),
      body: Obx(() {
        if (commentController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: commentController.comments.length,
            itemBuilder: (context, index) {
              final comment = commentController.comments[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor:
                            Colors.primaries[index % Colors.primaries.length],
                        child: Text(
                          comment.name[0].toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name: ${comment.name}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Email: ${comment.email}',
                              style: const TextStyle(
                                  color: Colors.blue, fontSize: 12),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              comment.body,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
