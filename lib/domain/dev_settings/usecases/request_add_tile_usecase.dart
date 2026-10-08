import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../core/errors/failures.dart';
import '../repositories/dev_settings_repository.dart';

@lazySingleton
class RequestAddTileUseCase {
  final IDevSettingsRepository _repository;
  const RequestAddTileUseCase(this._repository);

  Future<Either<Failure, bool>> call() {
    return _repository.requestAddTile();
  }
}
