import 'package:flutter_test/flutter_test.dart';
import 'package:fastdo/services/dev_settings_service.dart';
import 'package:fastdo/providers/dev_settings_provider.dart';

class FakeDevSettingsService extends DevSettingsService {
  bool requestedState = false;

  @override
  Future<bool> checkPermission() async => true;

  @override
  Future<bool> isDevOptionsEnabled() async => false;

  @override
  Future<bool> isUsbDebuggingEnabled() async => false;

  @override
  Future<bool> isRootAvailable() async => false;

  @override
  Future<bool> setDevOptionsEnabled(bool enabled) async {
    requestedState = enabled;
    return true;
  }

  @override
  Stream<Map<String, dynamic>> get settingsStream => const Stream.empty();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'toggle passes the requested state and synchronizes USB state',
    () async {
      final service = FakeDevSettingsService();
      final provider = DevSettingsProvider(service: service);
      await provider.init();

      final success = await provider.toggleDevOptions(true);

      expect(success, isTrue);
      expect(service.requestedState, isTrue);
      expect(provider.state.isDevOptionsEnabled, isTrue);
      expect(provider.state.isUsbDebuggingEnabled, isTrue);
      provider.dispose();
    },
  );
}
