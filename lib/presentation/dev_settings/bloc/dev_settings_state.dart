import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/dev_settings/models/dev_settings_info.dart';

part 'dev_settings_state.freezed.dart';

@freezed
class DevSettingsState with _$DevSettingsState {
  const factory DevSettingsState({
    @Default(DevSettingsInfo()) DevSettingsInfo info,
    @Default(true) bool isLoading,
    @Default(false) bool isActionLoading,
    String? errorMessage,
    String? successMessage,
  }) = _DevSettingsState;
}
