import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../core/errors/failures.dart';
import '../repositories/dev_settings_repository.dart';

@lazySingleton
class ToggleDevOptionsUseCase {
  final IDevSettingsRepository _repository;
  const ToggleDevOptionsUseCase(this._repository);

  Future<Either<Failure, bool>> call(bool enabled) {
    return _repository.setDevOptionsEnabled(enabled);
  }
}
