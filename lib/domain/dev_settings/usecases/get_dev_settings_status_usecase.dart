import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../core/errors/failures.dart';
import '../models/dev_settings_info.dart';
import '../repositories/dev_settings_repository.dart';

@lazySingleton
class GetDevSettingsStatusUseCase {
  final IDevSettingsRepository _repository;
  const GetDevSettingsStatusUseCase(this._repository);

  Future<Either<Failure, DevSettingsInfo>> call() {
    return _repository.getStatus();
  }
}
