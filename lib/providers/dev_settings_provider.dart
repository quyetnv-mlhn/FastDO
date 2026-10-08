import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../models/dev_settings_state.dart';
import '../services/dev_settings_service.dart';

class DevSettingsProvider extends ChangeNotifier {
  final DevSettingsService _service;
  DevSettingsState _state = const DevSettingsState();
  StreamSubscription? _eventSubscription;

  DevSettingsProvider({DevSettingsService? service})
    : _service = service ?? DevSettingsService() {
    init();
  }

  DevSettingsState get state => _state;

  Future<void> init() async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    await refreshAll();

    // Listen to real-time events from ContentObserver
    _eventSubscription?.cancel();
    _eventSubscription = _service.settingsStream.listen(
      (event) {
        if (event.isNotEmpty) {
          final hasPerm =
              event['hasPermission'] as bool? ?? _state.hasPermission;
          final isDevOn =
              event['isDevOptionsEnabled'] as bool? ??
              _state.isDevOptionsEnabled;
          final isAdbOn =
              event['isUsbDebuggingEnabled'] as bool? ??
              _state.isUsbDebuggingEnabled;

          _state = _state.copyWith(
            hasPermission: hasPerm,
            isDevOptionsEnabled: isDevOn,
            isUsbDebuggingEnabled: isAdbOn,
            isLoading: false,
          );
          notifyListeners();
        }
      },
      onError: (err) {
        debugPrint('Error in settings stream: $err');
      },
    );
  }

  Future<void> refreshAll() async {
    try {
      final hasPerm = await _service.checkPermission();
      final isDevOn = await _service.isDevOptionsEnabled();
      final isAdbOn = await _service.isUsbDebuggingEnabled();
      final isRoot = await _service.isRootAvailable();

      _state = _state.copyWith(
        hasPermission: hasPerm,
        isDevOptionsEnabled: isDevOn,
        isUsbDebuggingEnabled: isAdbOn,
        isRootAvailable: isRoot,
        isLoading: false,
      );
    } catch (e) {
      _state = _state.copyWith(isLoading: false, errorMessage: e.toString());
    }
    notifyListeners();
  }

  Future<bool> toggleDevOptions(bool enabled) async {
    if (_state.isLoading) {
      return false;
    }
    HapticFeedback.lightImpact();

    if (!_state.hasPermission) {
      // Cannot toggle without permission
      return false;
    }

    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    final success = await _service.setDevOptionsEnabled(enabled);
    if (success) {
      _state = _state.copyWith(
        isDevOptionsEnabled: enabled,
        isUsbDebuggingEnabled: enabled,
        isLoading: false,
      );
      notifyListeners();
      HapticFeedback.mediumImpact();
    } else {
      _state = _state.copyWith(isLoading: false);
      notifyListeners();
    }
    return success;
  }

  Future<void> openDevSettings() async {
    HapticFeedback.selectionClick();
    await _service.openDevSettings();
  }

  Future<void> openAppSettings() async {
    HapticFeedback.selectionClick();
    await _service.openAppSettings();
  }

  Future<bool> requestAddTile() async {
    HapticFeedback.selectionClick();
    return await _service.requestAddTile();
  }

  Future<bool> grantRootPermission() async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    final success = await _service.grantRootPermission();
    await refreshAll();
    return success;
  }

  Future<void> openUrl(String url) async {
    await _service.openUrl(url);
  }

  @override
  void dispose() {
    _eventSubscription?.cancel();
    super.dispose();
  }
}
