import 'dart:async';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import '../../../core/errors/exceptions.dart';
import '../dtos/dev_settings_dto.dart';

abstract class IDevSettingsLocalDataSource {
  Future<DevSettingsDto> getStatus();
  Future<bool> setDevOptionsEnabled(bool enabled);
  Future<bool> setWifiDebuggingEnabled(bool enabled);
  Future<bool> requestAddTile();
  Future<bool> requestAddWifiTile();
  Future<bool> grantRootPermission();
  Future<void> openDevSettings();
  Future<void> openWirelessDebuggingSettings();
  Future<void> openAppSettings();
  Stream<DevSettingsDto> watchSettings();
}

@LazySingleton(as: IDevSettingsLocalDataSource)
class DevSettingsLocalDataSourceImpl implements IDevSettingsLocalDataSource {
  static const MethodChannel _methodChannel = MethodChannel(
    'com.quyetnv.fastdo/channel',
  );
  static const EventChannel _eventChannel = EventChannel(
    'com.quyetnv.fastdo/events',
  );

  @override
  Future<DevSettingsDto> getStatus() async {
    try {
      final hasPerm =
          await _methodChannel.invokeMethod<bool>('checkPermission') ?? false;
      final isDevOn =
          await _methodChannel.invokeMethod<bool>('isDevOptionsEnabled') ??
          false;
      final isAdbOn =
          await _methodChannel.invokeMethod<bool>('isUsbDebuggingEnabled') ??
          false;
      final isWifiOn =
          await _methodChannel.invokeMethod<bool>('isWifiDebuggingEnabled') ??
          false;
      final isRoot =
          await _methodChannel.invokeMethod<bool>('isRootAvailable') ?? false;
      final ipAddress = await _methodChannel.invokeMethod<String>(
        'getWifiIpAddress',
      );
      final port = await _methodChannel.invokeMethod<String>('getWifiPort');

      return DevSettingsDto(
        hasPermission: hasPerm,
        isDevOptionsEnabled: isDevOn,
        isUsbDebuggingEnabled: isAdbOn,
        isWifiDebuggingEnabled: isWifiOn,
        isRootAvailable: isRoot,
        wifiIpAddress: ipAddress,
        wifiPort: port,
      );
    } on PlatformException catch (e) {
      throw PlatformExceptionWrapper(
        e.message ?? 'Failed to get status',
        code: e.code,
      );
    } catch (e) {
      throw PlatformExceptionWrapper(e.toString());
    }
  }

  @override
  Future<bool> setDevOptionsEnabled(bool enabled) async {
    try {
      final result = await _methodChannel.invokeMethod<bool>(
        'setDevOptionsEnabled',
        {'enabled': enabled},
      );
      return result ?? false;
    } on PlatformException catch (e) {
      throw PlatformExceptionWrapper(
        e.message ?? 'Failed to set dev options',
        code: e.code,
      );
    }
  }

  @override
  Future<bool> setWifiDebuggingEnabled(bool enabled) async {
    try {
      final result = await _methodChannel.invokeMethod<bool>(
        'setWifiDebuggingEnabled',
        {'enabled': enabled},
      );
      return result ?? false;
    } on PlatformException catch (e) {
      throw PlatformExceptionWrapper(
        e.message ?? 'Failed to set wifi debugging',
        code: e.code,
      );
    }
  }

  @override
  Future<bool> requestAddTile() async {
    try {
      final result = await _methodChannel.invokeMethod<bool>('requestAddTile');
      return result ?? false;
    } on PlatformException catch (e) {
      throw PlatformExceptionWrapper(
        e.message ?? 'Failed to request add tile',
        code: e.code,
      );
    }
  }

  @override
  Future<bool> requestAddWifiTile() async {
    try {
      final result = await _methodChannel.invokeMethod<bool>(
        'requestAddWifiTile',
      );
      return result ?? false;
    } on PlatformException catch (e) {
      throw PlatformExceptionWrapper(
        e.message ?? 'Failed to request add wifi tile',
        code: e.code,
      );
    }
  }

  @override
  Future<bool> grantRootPermission() async {
    try {
      final result = await _methodChannel.invokeMethod<bool>(
        'grantRootPermission',
      );
      return result ?? false;
    } on PlatformException catch (e) {
      throw PlatformExceptionWrapper(
        e.message ?? 'Failed to grant root permission',
        code: e.code,
      );
    }
  }

  @override
  Future<void> openDevSettings() async {
    try {
      await _methodChannel.invokeMethod('openDevSettings');
    } on PlatformException catch (e) {
      throw PlatformExceptionWrapper(
        e.message ?? 'Failed to open dev settings',
        code: e.code,
      );
    }
  }

  @override
  Future<void> openWirelessDebuggingSettings() async {
    try {
      await _methodChannel.invokeMethod('openWirelessDebuggingSettings');
    } on PlatformException catch (e) {
      throw PlatformExceptionWrapper(
        e.message ?? 'Failed to open wireless debugging settings',
        code: e.code,
      );
    }
  }

  @override
  Future<void> openAppSettings() async {
    try {
      await _methodChannel.invokeMethod('openAppSettings');
    } on PlatformException catch (e) {
      throw PlatformExceptionWrapper(
        e.message ?? 'Failed to open app settings',
        code: e.code,
      );
    }
  }

  @override
  Stream<DevSettingsDto> watchSettings() {
    return _eventChannel.receiveBroadcastStream().map((event) {
      if (event is Map) {
        final map = Map<String, dynamic>.from(event);
        return DevSettingsDto(
          hasPermission: map['hasPermission'] as bool? ?? false,
          isDevOptionsEnabled: map['isDevOptionsEnabled'] as bool? ?? false,
          isUsbDebuggingEnabled: map['isUsbDebuggingEnabled'] as bool? ?? false,
          isWifiDebuggingEnabled:
              map['isWifiDebuggingEnabled'] as bool? ?? false,
          isRootAvailable: false,
          wifiIpAddress: map['wifiIpAddress'] as String?,
          wifiPort: map['wifiPort'] as String?,
        );
      }
      return const DevSettingsDto();
    });
  }
}
