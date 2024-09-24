import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get.dart';

class RemoteConfigService extends GetxService {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
  final RxBool _shouldMaskEmail = false.obs;

  bool get shouldMaskEmail => _shouldMaskEmail.value;

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
    _shouldMaskEmail.value = _remoteConfig.getBool('mask_email');
  }
}