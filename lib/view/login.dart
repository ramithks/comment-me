import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:commentme/providers/auth_provider.dart';
import 'package:commentme/routes.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (authProvider.user != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed(AppRouter.home);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'email',
                  ),
                  controller: _emailController,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'password',
                  ),
                  controller: _passwordController,
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  child: const Text('Log in'),
                  onPressed: () async {
                    try {
                      await authProvider.login(
                        _emailController.text,
                        _passwordController.text,
                      );
                      Navigator.of(context).pushReplacementNamed(AppRouter.home);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.toString())),
                      );
                    }
                  },
                ),
                const SizedBox(height: 30),
                TextButton(
                  child: const Text('Sign up'),
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRouter.signup);
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