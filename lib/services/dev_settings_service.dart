import 'dart:async';

import 'package:flutter/services.dart';

class DevSettingsService {
  static const MethodChannel _methodChannel = MethodChannel(
    'com.quyetnv.fastdo/channel',
  );
  static const EventChannel _eventChannel = EventChannel(
    'com.quyetnv.fastdo/events',
  );

  static const String packageName = 'com.quyetnv.fastdo';
  static const String adbGrantCommand =
      'adb shell pm grant $packageName android.permission.WRITE_SECURE_SETTINGS';

  /// Check if the app has the WRITE_SECURE_SETTINGS permission
  Future<bool> checkPermission() async {
    try {
      final bool? result = await _methodChannel.invokeMethod<bool>(
        'checkPermission',
      );
      return result ?? false;
    } on PlatformException catch (_) {
      return false;
    }
  }

  /// Check if Developer Options are currently enabled
  Future<bool> isDevOptionsEnabled() async {
    try {
      final bool? result = await _methodChannel.invokeMethod<bool>(
        'isDevOptionsEnabled',
      );
      return result ?? false;
    } on PlatformException catch (_) {
      return false;
    }
  }

  /// Toggle or set Developer Options enabled/disabled
  Future<bool> setDevOptionsEnabled(bool enabled) async {
    try {
      final bool? result = await _methodChannel.invokeMethod<bool>(
        'setDevOptionsEnabled',
        {'enabled': enabled},
      );
      return result ?? false;
    } on PlatformException catch (_) {
      return false;
    }
  }

  /// Check if USB debugging (ADB) is enabled
  Future<bool> isUsbDebuggingEnabled() async {
    try {
      final bool? result = await _methodChannel.invokeMethod<bool>(
        'isUsbDebuggingEnabled',
      );
      return result ?? false;
    } on PlatformException catch (_) {
      return false;
    }
  }

  /// Open System Developer Options Settings
  Future<void> openDevSettings() async {
    try {
      await _methodChannel.invokeMethod('openDevSettings');
    } on PlatformException catch (_) {}
  }

  /// Open App Settings
  Future<void> openAppSettings() async {
    try {
      await _methodChannel.invokeMethod('openAppSettings');
    } on PlatformException catch (_) {}
  }

  /// Request adding Quick Settings Tile (Android 13+)
  Future<bool> requestAddTile() async {
    try {
      final bool? result = await _methodChannel.invokeMethod<bool>(
        'requestAddTile',
      );
      return result ?? false;
    } on PlatformException catch (_) {
      return false;
    }
  }

  /// Check if device is rooted
  Future<bool> isRootAvailable() async {
    try {
      final bool? result = await _methodChannel.invokeMethod<bool>(
        'isRootAvailable',
      );
      return result ?? false;
    } on PlatformException catch (_) {
      return false;
    }
  }

  /// Attempt to grant permission via root `su` command
  Future<bool> grantRootPermission() async {
    try {
      final bool? result = await _methodChannel.invokeMethod<bool>(
        'grantRootPermission',
      );
      return result ?? false;
    } on PlatformException catch (_) {
      return false;
    }
  }

  /// Open external URL via native intent
  Future<bool> openUrl(String url) async {
    try {
      final bool? result = await _methodChannel.invokeMethod<bool>('openUrl', {
        'url': url,
      });
      return result ?? false;
    } on PlatformException catch (_) {
      return false;
    }
  }

  /// Stream of system settings events (ContentObserver)
  Stream<Map<String, dynamic>> get settingsStream {
    return _eventChannel.receiveBroadcastStream().map((event) {
      if (event is Map) {
        return Map<String, dynamic>.from(event);
      }
      return <String, dynamic>{};
    });
  }
}
