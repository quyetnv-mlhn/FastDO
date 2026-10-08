// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dev_settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DevSettingsState {
  DevSettingsInfo get info => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isActionLoading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  String? get successMessage => throw _privateConstructorUsedError;

  /// Create a copy of DevSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DevSettingsStateCopyWith<DevSettingsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DevSettingsStateCopyWith<$Res> {
  factory $DevSettingsStateCopyWith(
          DevSettingsState value, $Res Function(DevSettingsState) then) =
      _$DevSettingsStateCopyWithImpl<$Res, DevSettingsState>;
  @useResult
  $Res call(
      {DevSettingsInfo info,
      bool isLoading,
      bool isActionLoading,
      String? errorMessage,
      String? successMessage});

  $DevSettingsInfoCopyWith<$Res> get info;
}

/// @nodoc
class _$DevSettingsStateCopyWithImpl<$Res, $Val extends DevSettingsState>
    implements $DevSettingsStateCopyWith<$Res> {
  _$DevSettingsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DevSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
    Object? isLoading = null,
    Object? isActionLoading = null,
    Object? errorMessage = freezed,
    Object? successMessage = freezed,
  }) {
    return _then(_value.copyWith(
      info: null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as DevSettingsInfo,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isActionLoading: null == isActionLoading
          ? _value.isActionLoading
          : isActionLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      successMessage: freezed == successMessage
          ? _value.successMessage
          : successMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of DevSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DevSettingsInfoCopyWith<$Res> get info {
    return $DevSettingsInfoCopyWith<$Res>(_value.info, (value) {
      return _then(_value.copyWith(info: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DevSettingsStateImplCopyWith<$Res>
    implements $DevSettingsStateCopyWith<$Res> {
  factory _$$DevSettingsStateImplCopyWith(_$DevSettingsStateImpl value,
          $Res Function(_$DevSettingsStateImpl) then) =
      __$$DevSettingsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DevSettingsInfo info,
      bool isLoading,
      bool isActionLoading,
      String? errorMessage,
      String? successMessage});

  @override
  $DevSettingsInfoCopyWith<$Res> get info;
}

/// @nodoc
class __$$DevSettingsStateImplCopyWithImpl<$Res>
    extends _$DevSettingsStateCopyWithImpl<$Res, _$DevSettingsStateImpl>
    implements _$$DevSettingsStateImplCopyWith<$Res> {
  __$$DevSettingsStateImplCopyWithImpl(_$DevSettingsStateImpl _value,
      $Res Function(_$DevSettingsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of DevSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? info = null,
    Object? isLoading = null,
    Object? isActionLoading = null,
    Object? errorMessage = freezed,
    Object? successMessage = freezed,
  }) {
    return _then(_$DevSettingsStateImpl(
      info: null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as DevSettingsInfo,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isActionLoading: null == isActionLoading
          ? _value.isActionLoading
          : isActionLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      successMessage: freezed == successMessage
          ? _value.successMessage
          : successMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$DevSettingsStateImpl implements _DevSettingsState {
  const _$DevSettingsStateImpl(
      {this.info = const DevSettingsInfo(),
      this.isLoading = true,
      this.isActionLoading = false,
      this.errorMessage,
      this.successMessage});

  @override
  @JsonKey()
  final DevSettingsInfo info;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isActionLoading;
  @override
  final String? errorMessage;
  @override
  final String? successMessage;

  @override
  String toString() {
    return 'DevSettingsState(info: $info, isLoading: $isLoading, isActionLoading: $isActionLoading, errorMessage: $errorMessage, successMessage: $successMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DevSettingsStateImpl &&
            (identical(other.info, info) || other.info == info) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isActionLoading, isActionLoading) ||
                other.isActionLoading == isActionLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.successMessage, successMessage) ||
                other.successMessage == successMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, info, isLoading, isActionLoading,
      errorMessage, successMessage);

  /// Create a copy of DevSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DevSettingsStateImplCopyWith<_$DevSettingsStateImpl> get copyWith =>
      __$$DevSettingsStateImplCopyWithImpl<_$DevSettingsStateImpl>(
          this, _$identity);
}

abstract class _DevSettingsState implements DevSettingsState {
  const factory _DevSettingsState(
      {final DevSettingsInfo info,
      final bool isLoading,
      final bool isActionLoading,
      final String? errorMessage,
      final String? successMessage}) = _$DevSettingsStateImpl;

  @override
  DevSettingsInfo get info;
  @override
  bool get isLoading;
  @override
  bool get isActionLoading;
  @override
  String? get errorMessage;
  @override
  String? get successMessage;

  /// Create a copy of DevSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DevSettingsStateImplCopyWith<_$DevSettingsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
