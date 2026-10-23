import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../core/errors/failures.dart';
import '../repositories/dev_settings_repository.dart';

@lazySingleton
class ToggleWifiDebuggingUseCase {
  final IDevSettingsRepository _repository;
  const ToggleWifiDebuggingUseCase(this._repository);

  Future<Either<Failure, bool>> call(bool enabled) {
    return _repository.setWifiDebuggingEnabled(enabled);
  }
}
