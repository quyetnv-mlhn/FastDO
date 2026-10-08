import 'package:freezed_annotation/freezed_annotation.dart';

part 'dev_settings_info.freezed.dart';

@freezed
class DevSettingsInfo with _$DevSettingsInfo {
  const factory DevSettingsInfo({
    @Default(false) bool hasPermission,
    @Default(false) bool isDevOptionsEnabled,
    @Default(false) bool isUsbDebuggingEnabled,
    @Default(false) bool isRootAvailable,
  }) = _DevSettingsInfo;
}
