import 'package:injectable/injectable.dart';

import '../models/dev_settings_info.dart';
import '../repositories/dev_settings_repository.dart';

@lazySingleton
class WatchDevSettingsUseCase {
  final IDevSettingsRepository _repository;
  const WatchDevSettingsUseCase(this._repository);

  Stream<DevSettingsInfo> call() {
    return _repository.watchDevSettings();
  }
}
