import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../core/errors/failures.dart';
import '../repositories/dev_settings_repository.dart';

@lazySingleton
class OpenWirelessDebuggingSettingsUseCase {
  final IDevSettingsRepository _repository;
  const OpenWirelessDebuggingSettingsUseCase(this._repository);

  Future<Either<Failure, void>> call() {
    return _repository.openWirelessDebuggingSettings();
  }
}
