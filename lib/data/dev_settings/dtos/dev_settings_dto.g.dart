// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dev_settings_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DevSettingsDtoImpl _$$DevSettingsDtoImplFromJson(Map<String, dynamic> json) =>
    _$DevSettingsDtoImpl(
      hasPermission: json['hasPermission'] as bool? ?? false,
      isDevOptionsEnabled: json['isDevOptionsEnabled'] as bool? ?? false,
      isUsbDebuggingEnabled: json['isUsbDebuggingEnabled'] as bool? ?? false,
      isRootAvailable: json['isRootAvailable'] as bool? ?? false,
    );

Map<String, dynamic> _$$DevSettingsDtoImplToJson(
        _$DevSettingsDtoImpl instance) =>
    <String, dynamic>{
      'hasPermission': instance.hasPermission,
      'isDevOptionsEnabled': instance.isDevOptionsEnabled,
      'isUsbDebuggingEnabled': instance.isUsbDebuggingEnabled,
      'isRootAvailable': instance.isRootAvailable,
    };
