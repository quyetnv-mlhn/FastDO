import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../core/errors/failures.dart';
import '../repositories/dev_settings_repository.dart';

@lazySingleton
class OpenAppSettingsUseCase {
  final IDevSettingsRepository _repository;
  const OpenAppSettingsUseCase(this._repository);

  Future<Either<Failure, void>> call() {
    return _repository.openAppSettings();
  }
}
