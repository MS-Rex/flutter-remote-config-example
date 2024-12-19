/// A service class that wraps Firebase Remote Config functionality.
///
/// This class provides methods to manage remote configuration values
/// specifically for Christmas mode feature.
///
/// Example usage:
/// ```dart
/// final remoteValueService = RemoteValueService(remoteConfig: firebaseRemoteConfig);
/// await remoteValueService.setDefaultsAndFetch();
/// await remoteValueService.setConfigurations();
/// bool isChristmasModeEnabled = remoteValueService.christmasModeEnabledKey;
/// ```
///
/// The service includes:
/// * Setting default values and fetching remote config
/// * Configuring fetch timeout and interval settings
/// * Retrieving Christmas mode enabled status
import 'package:firebase_remote_config/firebase_remote_config.dart';

/// Wrapper around [FirebaseRemoteConfig].
class RemoteValueService {
  static const _christmasModeEnabledKey = 'christmas_mode';

  FirebaseRemoteConfig remoteConfig;

  RemoteValueService({required this.remoteConfig});

  Future<void> setDefaultsAndFetch() async {
    await remoteConfig.setDefaults(<String, dynamic>{
      _christmasModeEnabledKey: false,
    });
    await remoteConfig.fetchAndActivate();
  }

  Future<void> setConfigurations() async {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(seconds: 20),
    ));
  }

  bool get christmasModeEnabledKey => remoteConfig.getBool(
        _christmasModeEnabledKey,
      );
}
