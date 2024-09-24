import 'package:get_it/get_it.dart';

import 'package:commentme/service/auth_service.dart';
import 'package:commentme/service/remote_config_service.dart';
import 'package:commentme/service/user_service.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  getIt.registerLazySingleton<AuthService>(() => AuthService());
  getIt.registerLazySingleton<UserService>(() => UserService());
  final remoteConfigService = await RemoteConfigService().initialize();
  getIt.registerSingleton<RemoteConfigService>(remoteConfigService);
}