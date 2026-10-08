import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../core/errors/failures.dart';
import '../repositories/dev_settings_repository.dart';

@lazySingleton
class GrantRootPermissionUseCase {
  final IDevSettingsRepository _repository;
  const GrantRootPermissionUseCase(this._repository);

  Future<Either<Failure, bool>> call() {
    return _repository.grantRootPermission();
  }
}
