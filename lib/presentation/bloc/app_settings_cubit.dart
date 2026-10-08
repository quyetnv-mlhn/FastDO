import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'app_settings_cubit.freezed.dart';

@freezed
class AppSettingsState with _$AppSettingsState {
  const factory AppSettingsState({
    @Default(ThemeMode.system) ThemeMode themeMode,
    @Default(Locale('vi')) Locale locale,
  }) = _AppSettingsState;
}

@lazySingleton
class AppSettingsCubit extends Cubit<AppSettingsState> {
  AppSettingsCubit() : super(const AppSettingsState());

  void toggleTheme() {
    final nextMode = state.themeMode == ThemeMode.system
        ? ThemeMode.dark
        : (state.themeMode == ThemeMode.dark
            ? ThemeMode.light
            : ThemeMode.system);
    emit(state.copyWith(themeMode: nextMode));
  }

  void toggleLocale() {
    final nextLocale = state.locale.languageCode == 'vi'
        ? const Locale('en')
        : const Locale('vi');
    emit(state.copyWith(locale: nextLocale));
  }
}
