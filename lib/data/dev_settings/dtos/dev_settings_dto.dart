import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/dev_settings/models/dev_settings_info.dart';

part 'dev_settings_dto.freezed.dart';
part 'dev_settings_dto.g.dart';

@freezed
abstract class DevSettingsDto with _$DevSettingsDto {
  const DevSettingsDto._();

  const factory DevSettingsDto({
    @Default(false) bool hasPermission,
    @Default(false) bool isDevOptionsEnabled,
    @Default(false) bool isUsbDebuggingEnabled,
    @Default(false) bool isWifiDebuggingEnabled,
    @Default(false) bool isRootAvailable,
    String? wifiIpAddress,
    String? wifiPort,
  }) = _DevSettingsDto;

  factory DevSettingsDto.fromJson(Map<String, dynamic> json) =>
      _$DevSettingsDtoFromJson(json);

  DevSettingsInfo toDomain() {
    return DevSettingsInfo(
      hasPermission: hasPermission,
      isDevOptionsEnabled: isDevOptionsEnabled,
      isUsbDebuggingEnabled: isUsbDebuggingEnabled,
      isWifiDebuggingEnabled: isWifiDebuggingEnabled,
      isRootAvailable: isRootAvailable,
      wifiIpAddress: wifiIpAddress,
      wifiPort: wifiPort,
    );
  }
}
