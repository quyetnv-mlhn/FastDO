// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/dev_settings/datasources/dev_settings_local_datasource.dart'
    as _i279;
import '../../data/dev_settings/repositories/dev_settings_repository_impl.dart'
    as _i346;
import '../../domain/dev_settings/repositories/dev_settings_repository.dart'
    as _i805;
import '../../domain/dev_settings/usecases/get_dev_settings_status_usecase.dart'
    as _i423;
import '../../domain/dev_settings/usecases/grant_root_permission_usecase.dart'
    as _i810;
import '../../domain/dev_settings/usecases/open_app_settings_usecase.dart'
    as _i444;
import '../../domain/dev_settings/usecases/open_dev_settings_usecase.dart'
    as _i793;
import '../../domain/dev_settings/usecases/request_add_tile_usecase.dart'
    as _i375;
import '../../domain/dev_settings/usecases/toggle_dev_options_usecase.dart'
    as _i907;
import '../../domain/dev_settings/usecases/watch_dev_settings_usecase.dart'
    as _i939;
import '../../presentation/bloc/app_settings_cubit.dart' as _i644;
import '../../presentation/dev_settings/bloc/dev_settings_cubit.dart' as _i539;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i644.AppSettingsCubit>(() => _i644.AppSettingsCubit());
    gh.lazySingleton<_i279.IDevSettingsLocalDataSource>(
        () => _i279.DevSettingsLocalDataSourceImpl());
    gh.lazySingleton<_i805.IDevSettingsRepository>(() =>
        _i346.DevSettingsRepositoryImpl(
            gh<_i279.IDevSettingsLocalDataSource>()));
    gh.lazySingleton<_i444.OpenAppSettingsUseCase>(
        () => _i444.OpenAppSettingsUseCase(gh<_i805.IDevSettingsRepository>()));
    gh.lazySingleton<_i810.GrantRootPermissionUseCase>(() =>
        _i810.GrantRootPermissionUseCase(gh<_i805.IDevSettingsRepository>()));
    gh.lazySingleton<_i793.OpenDevSettingsUseCase>(
        () => _i793.OpenDevSettingsUseCase(gh<_i805.IDevSettingsRepository>()));
    gh.lazySingleton<_i375.RequestAddTileUseCase>(
        () => _i375.RequestAddTileUseCase(gh<_i805.IDevSettingsRepository>()));
    gh.lazySingleton<_i939.WatchDevSettingsUseCase>(() =>
        _i939.WatchDevSettingsUseCase(gh<_i805.IDevSettingsRepository>()));
    gh.lazySingleton<_i907.ToggleDevOptionsUseCase>(() =>
        _i907.ToggleDevOptionsUseCase(gh<_i805.IDevSettingsRepository>()));
    gh.lazySingleton<_i423.GetDevSettingsStatusUseCase>(() =>
        _i423.GetDevSettingsStatusUseCase(gh<_i805.IDevSettingsRepository>()));
    gh.factory<_i539.DevSettingsCubit>(() => _i539.DevSettingsCubit(
          gh<_i423.GetDevSettingsStatusUseCase>(),
          gh<_i907.ToggleDevOptionsUseCase>(),
          gh<_i375.RequestAddTileUseCase>(),
          gh<_i810.GrantRootPermissionUseCase>(),
          gh<_i793.OpenDevSettingsUseCase>(),
          gh<_i444.OpenAppSettingsUseCase>(),
          gh<_i939.WatchDevSettingsUseCase>(),
        ));
    return this;
  }
}
