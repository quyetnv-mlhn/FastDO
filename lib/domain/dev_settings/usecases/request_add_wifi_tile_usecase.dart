import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../core/errors/failures.dart';
import '../repositories/dev_settings_repository.dart';

@lazySingleton
class RequestAddWifiTileUseCase {
  final IDevSettingsRepository _repository;
  const RequestAddWifiTileUseCase(this._repository);

  Future<Either<Failure, bool>> call() {
    return _repository.requestAddWifiTile();
  }
}
