// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dev_settings_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DevSettingsInfo {
  bool get hasPermission => throw _privateConstructorUsedError;
  bool get isDevOptionsEnabled => throw _privateConstructorUsedError;
  bool get isUsbDebuggingEnabled => throw _privateConstructorUsedError;
  bool get isRootAvailable => throw _privateConstructorUsedError;

  /// Create a copy of DevSettingsInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DevSettingsInfoCopyWith<DevSettingsInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DevSettingsInfoCopyWith<$Res> {
  factory $DevSettingsInfoCopyWith(
          DevSettingsInfo value, $Res Function(DevSettingsInfo) then) =
      _$DevSettingsInfoCopyWithImpl<$Res, DevSettingsInfo>;
  @useResult
  $Res call(
      {bool hasPermission,
      bool isDevOptionsEnabled,
      bool isUsbDebuggingEnabled,
      bool isRootAvailable});
}

/// @nodoc
class _$DevSettingsInfoCopyWithImpl<$Res, $Val extends DevSettingsInfo>
    implements $DevSettingsInfoCopyWith<$Res> {
  _$DevSettingsInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DevSettingsInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasPermission = null,
    Object? isDevOptionsEnabled = null,
    Object? isUsbDebuggingEnabled = null,
    Object? isRootAvailable = null,
  }) {
    return _then(_value.copyWith(
      hasPermission: null == hasPermission
          ? _value.hasPermission
          : hasPermission // ignore: cast_nullable_to_non_nullable
              as bool,
      isDevOptionsEnabled: null == isDevOptionsEnabled
          ? _value.isDevOptionsEnabled
          : isDevOptionsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isUsbDebuggingEnabled: null == isUsbDebuggingEnabled
          ? _value.isUsbDebuggingEnabled
          : isUsbDebuggingEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isRootAvailable: null == isRootAvailable
          ? _value.isRootAvailable
          : isRootAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DevSettingsInfoImplCopyWith<$Res>
    implements $DevSettingsInfoCopyWith<$Res> {
  factory _$$DevSettingsInfoImplCopyWith(_$DevSettingsInfoImpl value,
          $Res Function(_$DevSettingsInfoImpl) then) =
      __$$DevSettingsInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool hasPermission,
      bool isDevOptionsEnabled,
      bool isUsbDebuggingEnabled,
      bool isRootAvailable});
}

/// @nodoc
class __$$DevSettingsInfoImplCopyWithImpl<$Res>
    extends _$DevSettingsInfoCopyWithImpl<$Res, _$DevSettingsInfoImpl>
    implements _$$DevSettingsInfoImplCopyWith<$Res> {
  __$$DevSettingsInfoImplCopyWithImpl(
      _$DevSettingsInfoImpl _value, $Res Function(_$DevSettingsInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of DevSettingsInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasPermission = null,
    Object? isDevOptionsEnabled = null,
    Object? isUsbDebuggingEnabled = null,
    Object? isRootAvailable = null,
  }) {
    return _then(_$DevSettingsInfoImpl(
      hasPermission: null == hasPermission
          ? _value.hasPermission
          : hasPermission // ignore: cast_nullable_to_non_nullable
              as bool,
      isDevOptionsEnabled: null == isDevOptionsEnabled
          ? _value.isDevOptionsEnabled
          : isDevOptionsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isUsbDebuggingEnabled: null == isUsbDebuggingEnabled
          ? _value.isUsbDebuggingEnabled
          : isUsbDebuggingEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isRootAvailable: null == isRootAvailable
          ? _value.isRootAvailable
          : isRootAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$DevSettingsInfoImpl implements _DevSettingsInfo {
  const _$DevSettingsInfoImpl(
      {this.hasPermission = false,
      this.isDevOptionsEnabled = false,
      this.isUsbDebuggingEnabled = false,
      this.isRootAvailable = false});

  @override
  @JsonKey()
  final bool hasPermission;
  @override
  @JsonKey()
  final bool isDevOptionsEnabled;
  @override
  @JsonKey()
  final bool isUsbDebuggingEnabled;
  @override
  @JsonKey()
  final bool isRootAvailable;

  @override
  String toString() {
    return 'DevSettingsInfo(hasPermission: $hasPermission, isDevOptionsEnabled: $isDevOptionsEnabled, isUsbDebuggingEnabled: $isUsbDebuggingEnabled, isRootAvailable: $isRootAvailable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DevSettingsInfoImpl &&
            (identical(other.hasPermission, hasPermission) ||
                other.hasPermission == hasPermission) &&
            (identical(other.isDevOptionsEnabled, isDevOptionsEnabled) ||
                other.isDevOptionsEnabled == isDevOptionsEnabled) &&
            (identical(other.isUsbDebuggingEnabled, isUsbDebuggingEnabled) ||
                other.isUsbDebuggingEnabled == isUsbDebuggingEnabled) &&
            (identical(other.isRootAvailable, isRootAvailable) ||
                other.isRootAvailable == isRootAvailable));
  }

  @override
  int get hashCode => Object.hash(runtimeType, hasPermission,
      isDevOptionsEnabled, isUsbDebuggingEnabled, isRootAvailable);

  /// Create a copy of DevSettingsInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DevSettingsInfoImplCopyWith<_$DevSettingsInfoImpl> get copyWith =>
      __$$DevSettingsInfoImplCopyWithImpl<_$DevSettingsInfoImpl>(
          this, _$identity);
}

abstract class _DevSettingsInfo implements DevSettingsInfo {
  const factory _DevSettingsInfo(
      {final bool hasPermission,
      final bool isDevOptionsEnabled,
      final bool isUsbDebuggingEnabled,
      final bool isRootAvailable}) = _$DevSettingsInfoImpl;

  @override
  bool get hasPermission;
  @override
  bool get isDevOptionsEnabled;
  @override
  bool get isUsbDebuggingEnabled;
  @override
  bool get isRootAvailable;

  /// Create a copy of DevSettingsInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DevSettingsInfoImplCopyWith<_$DevSettingsInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
