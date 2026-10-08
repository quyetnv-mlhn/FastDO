import 'package:fpdart/fpdart.dart';
import '../../../core/errors/failures.dart';
import '../models/dev_settings_info.dart';

abstract class IDevSettingsRepository {
  Future<Either<Failure, DevSettingsInfo>> getStatus();
  Future<Either<Failure, bool>> setDevOptionsEnabled(bool enabled);
  Future<Either<Failure, bool>> requestAddTile();
  Future<Either<Failure, bool>> grantRootPermission();
  Future<Either<Failure, void>> openDevSettings();
  Future<Either<Failure, void>> openAppSettings();
  Stream<DevSettingsInfo> watchDevSettings();
}
