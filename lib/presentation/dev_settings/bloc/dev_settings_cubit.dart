import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/dev_settings/usecases/get_dev_settings_status_usecase.dart';
import '../../../domain/dev_settings/usecases/grant_root_permission_usecase.dart';
import '../../../domain/dev_settings/usecases/open_app_settings_usecase.dart';
import '../../../domain/dev_settings/usecases/open_dev_settings_usecase.dart';
import '../../../domain/dev_settings/usecases/request_add_tile_usecase.dart';
import '../../../domain/dev_settings/usecases/toggle_dev_options_usecase.dart';
import '../../../domain/dev_settings/usecases/watch_dev_settings_usecase.dart';
import 'dev_settings_state.dart';

@injectable
class DevSettingsCubit extends Cubit<DevSettingsState> {
  final GetDevSettingsStatusUseCase _getStatusUseCase;
  final ToggleDevOptionsUseCase _toggleDevOptionsUseCase;
  final RequestAddTileUseCase _requestAddTileUseCase;
  final GrantRootPermissionUseCase _grantRootPermissionUseCase;
  final OpenDevSettingsUseCase _openDevSettingsUseCase;
  final OpenAppSettingsUseCase _openAppSettingsUseCase;
  final WatchDevSettingsUseCase _watchDevSettingsUseCase;

  StreamSubscription? _settingsSubscription;

  DevSettingsCubit(
    this._getStatusUseCase,
    this._toggleDevOptionsUseCase,
    this._requestAddTileUseCase,
    this._grantRootPermissionUseCase,
    this._openDevSettingsUseCase,
    this._openAppSettingsUseCase,
    this._watchDevSettingsUseCase,
  ) : super(const DevSettingsState()) {
    init();
  }

  void init() {
    loadStatus();
    _settingsSubscription?.cancel();
    _settingsSubscription = _watchDevSettingsUseCase().listen((info) {
      emit(state.copyWith(
        info: state.info.copyWith(
          hasPermission: info.hasPermission,
          isDevOptionsEnabled: info.isDevOptionsEnabled,
          isUsbDebuggingEnabled: info.isUsbDebuggingEnabled,
        ),
      ));
    });
  }

  Future<void> loadStatus() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await _getStatusUseCase();
    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      )),
      (info) => emit(state.copyWith(
        isLoading: false,
        info: info,
      )),
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
        emit(state.copyWith(
          isActionLoading: false,
          errorMessage: failure.message,
        ));
        return false;
      },
      (success) {
        if (success) {
          HapticFeedback.mediumImpact();
          emit(state.copyWith(
            isActionLoading: false,
            info: state.info.copyWith(isDevOptionsEnabled: target),
          ));
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
