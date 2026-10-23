import 'package:fastdo/core/errors/failures.dart';
import 'package:fastdo/domain/dev_settings/models/dev_settings_info.dart';
import 'package:fastdo/domain/dev_settings/repositories/dev_settings_repository.dart';
import 'package:fastdo/domain/dev_settings/usecases/get_dev_settings_status_usecase.dart';
import 'package:fastdo/domain/dev_settings/usecases/grant_root_permission_usecase.dart';
import 'package:fastdo/domain/dev_settings/usecases/open_app_settings_usecase.dart';
import 'package:fastdo/domain/dev_settings/usecases/open_dev_settings_usecase.dart';
import 'package:fastdo/domain/dev_settings/usecases/open_wireless_debugging_settings_usecase.dart';
import 'package:fastdo/domain/dev_settings/usecases/request_add_tile_usecase.dart';
import 'package:fastdo/domain/dev_settings/usecases/request_add_wifi_tile_usecase.dart';
import 'package:fastdo/domain/dev_settings/usecases/toggle_dev_options_usecase.dart';
import 'package:fastdo/domain/dev_settings/usecases/toggle_wifi_debugging_usecase.dart';
import 'package:fastdo/domain/dev_settings/usecases/watch_dev_settings_usecase.dart';
import 'package:fastdo/presentation/dev_settings/bloc/dev_settings_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

class MockDevSettingsRepository implements IDevSettingsRepository {
  bool isDevEnabled = true;
  bool isWifiEnabled = false;
  bool hasPerm = true;

  @override
  Future<Either<Failure, DevSettingsInfo>> getStatus() async {
    return Right(
      DevSettingsInfo(
        hasPermission: hasPerm,
        isDevOptionsEnabled: isDevEnabled,
        isUsbDebuggingEnabled: true,
        isWifiDebuggingEnabled: isWifiEnabled,
        isRootAvailable: false,
        wifiIpAddress: '192.168.1.50',
        wifiPort: '38291',
      ),
    );
  }

  @override
  Future<Either<Failure, bool>> setDevOptionsEnabled(bool enabled) async {
    isDevEnabled = enabled;
    return const Right(true);
  }

  @override
  Future<Either<Failure, bool>> setWifiDebuggingEnabled(bool enabled) async {
    isWifiEnabled = enabled;
    return const Right(true);
  }

  @override
  Future<Either<Failure, bool>> requestAddTile() async => const Right(true);

  @override
  Future<Either<Failure, bool>> requestAddWifiTile() async => const Right(true);

  @override
  Future<Either<Failure, bool>> grantRootPermission() async =>
      const Right(true);

  @override
  Future<Either<Failure, void>> openDevSettings() async => const Right(null);

  @override
  Future<Either<Failure, void>> openWirelessDebuggingSettings() async =>
      const Right(null);

  @override
  Future<Either<Failure, void>> openAppSettings() async => const Right(null);

  @override
  Stream<DevSettingsInfo> watchDevSettings() => const Stream.empty();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockDevSettingsRepository mockRepo;
  late DevSettingsCubit cubit;

  setUp(() {
    mockRepo = MockDevSettingsRepository();
    cubit = DevSettingsCubit(
      GetDevSettingsStatusUseCase(mockRepo),
      ToggleDevOptionsUseCase(mockRepo),
      ToggleWifiDebuggingUseCase(mockRepo),
      RequestAddTileUseCase(mockRepo),
      RequestAddWifiTileUseCase(mockRepo),
      GrantRootPermissionUseCase(mockRepo),
      OpenDevSettingsUseCase(mockRepo),
      OpenWirelessDebuggingSettingsUseCase(mockRepo),
      OpenAppSettingsUseCase(mockRepo),
      WatchDevSettingsUseCase(mockRepo),
    );
  });

  tearDown(() {
    cubit.close();
  });

  test('initial state loads status correctly', () async {
    await Future.delayed(const Duration(milliseconds: 50));
    expect(cubit.state.info.isDevOptionsEnabled, isTrue);
    expect(cubit.state.info.hasPermission, isTrue);
    expect(cubit.state.info.wifiIpAddress, equals('192.168.1.50'));
    expect(cubit.state.info.wifiPort, equals('38291'));
  });

  test('toggleDevOptions toggles state', () async {
    await Future.delayed(const Duration(milliseconds: 50));
    final result = await cubit.toggleDevOptions();
    expect(result, isTrue);
    expect(cubit.state.info.isDevOptionsEnabled, isFalse);
  });

  test('toggleWifiDebugging toggles state', () async {
    await Future.delayed(const Duration(milliseconds: 50));
    final result = await cubit.toggleWifiDebugging();
    expect(result, isTrue);
    expect(cubit.state.info.isWifiDebuggingEnabled, isTrue);
  });
}
