import 'package:commentme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:commentme/firebase_options.dart';
import 'package:commentme/providers/auth_provider.dart';
import 'package:commentme/providers/user_provider.dart';
import 'package:commentme/app_router.dart';

import 'providers/comment_provider.dart';
import 'services/remote_config_service.dart';
import 'services/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => CommentProvider()),
        ChangeNotifierProvider(create: (_) => RemoteConfigService()),
      ],
      child: MaterialApp(
        title: 'CommentMe',
        theme: AppTheme.theme,
        initialRoute: AppRouter.login,
        onGenerateRoute: AppRouter.onGenerateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
