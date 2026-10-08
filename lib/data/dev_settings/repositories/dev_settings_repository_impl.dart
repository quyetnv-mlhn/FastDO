import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/errors/failures.dart';
import '../../../domain/dev_settings/models/dev_settings_info.dart';
import '../../../domain/dev_settings/repositories/dev_settings_repository.dart';
import '../datasources/dev_settings_local_datasource.dart';

@LazySingleton(as: IDevSettingsRepository)
class DevSettingsRepositoryImpl implements IDevSettingsRepository {
  final IDevSettingsLocalDataSource _dataSource;

  const DevSettingsRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, DevSettingsInfo>> getStatus() async {
    try {
      final dto = await _dataSource.getStatus();
      return Right(dto.toDomain());
    } on PlatformExceptionWrapper catch (e) {
      return Left(PlatformFailure(e.message, code: e.code));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> setDevOptionsEnabled(bool enabled) async {
    try {
      final result = await _dataSource.setDevOptionsEnabled(enabled);
      return Right(result);
    } on PlatformExceptionWrapper catch (e) {
      return Left(PlatformFailure(e.message, code: e.code));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> requestAddTile() async {
    try {
      final result = await _dataSource.requestAddTile();
      return Right(result);
    } on PlatformExceptionWrapper catch (e) {
      return Left(PlatformFailure(e.message, code: e.code));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> grantRootPermission() async {
    try {
      final result = await _dataSource.grantRootPermission();
      return Right(result);
    } on PlatformExceptionWrapper catch (e) {
      return Left(PlatformFailure(e.message, code: e.code));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> openDevSettings() async {
    try {
      await _dataSource.openDevSettings();
      return const Right(null);
    } on PlatformExceptionWrapper catch (e) {
      return Left(PlatformFailure(e.message, code: e.code));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> openAppSettings() async {
    try {
      await _dataSource.openAppSettings();
      return const Right(null);
    } on PlatformExceptionWrapper catch (e) {
      return Left(PlatformFailure(e.message, code: e.code));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Stream<DevSettingsInfo> watchDevSettings() {
    return _dataSource.watchSettings().map((dto) => dto.toDomain());
  }
}
