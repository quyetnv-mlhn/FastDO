import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/dev_settings/usecases/get_dev_settings_status_usecase.dart';
import '../../../domain/dev_settings/usecases/grant_root_permission_usecase.dart';
import '../../../domain/dev_settings/usecases/open_app_settings_usecase.dart';
import '../../../domain/dev_settings/usecases/open_dev_settings_usecase.dart';
import '../../../domain/dev_settings/usecases/open_wireless_debugging_settings_usecase.dart';
import '../../../domain/dev_settings/usecases/request_add_tile_usecase.dart';
import '../../../domain/dev_settings/usecases/request_add_wifi_tile_usecase.dart';
import '../../../domain/dev_settings/usecases/toggle_dev_options_usecase.dart';
import '../../../domain/dev_settings/usecases/toggle_wifi_debugging_usecase.dart';
import '../../../domain/dev_settings/usecases/watch_dev_settings_usecase.dart';
import 'dev_settings_state.dart';

@injectable
class DevSettingsCubit extends Cubit<DevSettingsState> {
  final GetDevSettingsStatusUseCase _getStatusUseCase;
  final ToggleDevOptionsUseCase _toggleDevOptionsUseCase;
  final ToggleWifiDebuggingUseCase _toggleWifiDebuggingUseCase;
  final RequestAddTileUseCase _requestAddTileUseCase;
  final RequestAddWifiTileUseCase _requestAddWifiTileUseCase;
  final GrantRootPermissionUseCase _grantRootPermissionUseCase;
  final OpenDevSettingsUseCase _openDevSettingsUseCase;
  final OpenWirelessDebuggingSettingsUseCase
  _openWirelessDebuggingSettingsUseCase;
  final OpenAppSettingsUseCase _openAppSettingsUseCase;
  final WatchDevSettingsUseCase _watchDevSettingsUseCase;

  StreamSubscription? _settingsSubscription;

  DevSettingsCubit(
    this._getStatusUseCase,
    this._toggleDevOptionsUseCase,
    this._toggleWifiDebuggingUseCase,
    this._requestAddTileUseCase,
    this._requestAddWifiTileUseCase,
    this._grantRootPermissionUseCase,
    this._openDevSettingsUseCase,
    this._openWirelessDebuggingSettingsUseCase,
    this._openAppSettingsUseCase,
    this._watchDevSettingsUseCase,
  ) : super(const DevSettingsState()) {
    init();
  }

  void init() {
    loadStatus();
    _settingsSubscription?.cancel();
    _settingsSubscription = _watchDevSettingsUseCase().listen((info) {
      emit(
        state.copyWith(
          info: state.info.copyWith(
            hasPermission: info.hasPermission,
            isDevOptionsEnabled: info.isDevOptionsEnabled,
            isUsbDebuggingEnabled: info.isUsbDebuggingEnabled,
            isWifiDebuggingEnabled: info.isWifiDebuggingEnabled,
            wifiIpAddress: info.wifiIpAddress,
            wifiPort: info.wifiPort,
          ),
        ),
      );
    });
  }

  Future<void> loadStatus() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await _getStatusUseCase();
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (info) => emit(state.copyWith(isLoading: false, info: info)),
    );
  }

  Future<bool> toggleDevOptions() async {
    HapticFeedback.lightImpact();
    if (!state.info.hasPermission) {
      return false;
    }

    final target = !state.info.isDevOptionsEnabled;
    emit(state.copyWith(isActionLoading: true));

    final result = await _toggleDevOptionsUseCase(target);
    return result.fold(
      (failure) {
        emit(
          state.copyWith(isActionLoading: false, errorMessage: failure.message),
        );
        return false;
      },
      (success) {
        if (success) {
          HapticFeedback.mediumImpact();
          emit(
            state.copyWith(
              isActionLoading: false,
              info: state.info.copyWith(isDevOptionsEnabled: target),
            ),
          );
        } else {
          emit(state.copyWith(isActionLoading: false));
        }
        return success;
      },
    );
  }

  Future<bool> toggleWifiDebugging() async {
    HapticFeedback.lightImpact();
    if (!state.info.hasPermission) {
      return false;
    }

    final target = !state.info.isWifiDebuggingEnabled;
    emit(state.copyWith(isActionLoading: true));

    final result = await _toggleWifiDebuggingUseCase(target);
    return result.fold(
      (failure) {
        emit(
          state.copyWith(isActionLoading: false, errorMessage: failure.message),
        );
        return false;
      },
      (success) {
        if (success) {
          HapticFeedback.mediumImpact();
          emit(
            state.copyWith(
              isActionLoading: false,
              info: state.info.copyWith(
                isWifiDebuggingEnabled: target,
                isDevOptionsEnabled: target
                    ? true
                    : state.info.isDevOptionsEnabled,
              ),
            ),
          );
        } else {
          emit(state.copyWith(isActionLoading: false));
        }
        return success;
      },
    );
  }

  Future<bool> requestAddTile() async {
    HapticFeedback.selectionClick();
    final result = await _requestAddTileUseCase();
    return result.fold((_) => false, (success) => success);
  }

  Future<bool> requestAddWifiTile() async {
    HapticFeedback.selectionClick();
    final result = await _requestAddWifiTileUseCase();
    return result.fold((_) => false, (success) => success);
  }

  Future<bool> grantRootPermission() async {
    emit(state.copyWith(isActionLoading: true));
    final result = await _grantRootPermissionUseCase();
    await loadStatus();
    return result.fold((_) => false, (success) => success);
  }

  Future<void> openDevSettings() async {
    HapticFeedback.selectionClick();
    await _openDevSettingsUseCase();
  }

  Future<void> openWirelessDebuggingSettings() async {
    HapticFeedback.selectionClick();
    await _openWirelessDebuggingSettingsUseCase();
  }

  Future<void> openAppSettings() async {
    HapticFeedback.selectionClick();
    await _openAppSettingsUseCase();
  }

  @override
  Future<void> close() {
    _settingsSubscription?.cancel();
    return super.close();
  }
}
