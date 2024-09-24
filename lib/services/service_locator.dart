import 'package:get_it/get_it.dart';

import 'package:commentme/services/auth_service.dart';
import 'package:commentme/services/remote_config_service.dart';
import 'package:commentme/services/user_service.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  getIt.registerLazySingleton<AuthService>(() => AuthService());
  getIt.registerLazySingleton<UserService>(() => UserService());

  final remoteConfigService = await RemoteConfigService().initialize();
  getIt.registerSingleton<RemoteConfigService>(remoteConfigService);
}
