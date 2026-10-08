import 'dart:async';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import '../../../core/errors/exceptions.dart';
import '../dtos/dev_settings_dto.dart';

abstract class IDevSettingsLocalDataSource {
  Future<DevSettingsDto> getStatus();
  Future<bool> setDevOptionsEnabled(bool enabled);
  Future<bool> requestAddTile();
  Future<bool> grantRootPermission();
  Future<void> openDevSettings();
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
      final isRoot =
          await _methodChannel.invokeMethod<bool>('isRootAvailable') ?? false;

      return DevSettingsDto(
        hasPermission: hasPerm,
        isDevOptionsEnabled: isDevOn,
        isUsbDebuggingEnabled: isAdbOn,
        isRootAvailable: isRoot,
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
          isRootAvailable: false,
        );
      }
      return const DevSettingsDto();
    });
  }
}
