import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class RemoteConfigService extends ChangeNotifier {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
  bool _shouldMaskEmail = false;

  bool get shouldMaskEmail => _shouldMaskEmail;

  Future<RemoteConfigService> initialize() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ));

    await _remoteConfig.setDefaults({
      'mask_email': false,
    });

    await _remoteConfig.fetchAndActivate();

    _updateValues();
    _remoteConfig.onConfigUpdated.listen((event) async {
      await _remoteConfig.activate();
      _updateValues();
    });

    return this;
  }

  void _updateValues() {
    _shouldMaskEmail = _remoteConfig.getBool('mask_email');
    notifyListeners();
  }

  String maskEmail(String email) {
    if (!_shouldMaskEmail) return email;

    final parts = email.split('@');
    if (parts.length != 2) return email;

    String username = parts[0];
    String domain = parts[1];

    if (username.length <= 3) return email;

    String maskedUsername = '${username.substring(0, 3)}${'*' * (username.length - 3)}';
    return '$maskedUsername@$domain';
  }
}