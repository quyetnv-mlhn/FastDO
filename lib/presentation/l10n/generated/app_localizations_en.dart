import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'FastDO';

  @override
  String get appTagline => 'Fast Developer Options Controller';

  @override
  String get devOptionsEnabled => 'Developer Options Enabled';

  @override
  String get devOptionsDisabled => 'Developer Options Disabled';

  @override
  String get statusActive => 'STATUS: ACTIVE';

  @override
  String get statusInactive => 'STATUS: DISABLED';

  @override
  String get devOptionsDescActive =>
      'Banking and security-sensitive apps may restrict access while active. Tap to toggle off instantly.';

  @override
  String get devOptionsDescDisabled =>
      'Your device is in normal mode. All banking and fintech apps will open smoothly. Tap to re-enable when developing.';

  @override
  String get usbDebugging => 'USB Debugging';

  @override
  String get active => 'Active';

  @override
  String get inactive => 'Inactive';

  @override
  String get openSystemDevSettings => 'System Settings';

  @override
  String get qsTileTitle => 'Quick Settings Tile';

  @override
  String get qsTileSubtitle =>
      'Toggle Developer Options directly from your notification panel without opening the app.';

  @override
  String get addTileButton => 'Add Tile to Quick Settings';

  @override
  String get tileAddedNotice => 'Quick Settings tile request sent!';

  @override
  String get howToAddTileManual =>
      'Manual setup: Swipe down the notification panel twice -> Tap the Edit (Pencil) icon -> Drag the \'Dev Options\' tile to your active shortcuts.';

  @override
  String get permissionRequired => 'System Permission Required';

  @override
  String get permissionDesc =>
      'Android requires WRITE_SECURE_SETTINGS permission to control developer settings. Setup is only needed once via ADB or Root.';

  @override
  String get adbCommandTitle => 'ADB Setup Command';

  @override
  String get copyCommand => 'Copy Command';

  @override
  String get commandCopied => 'ADB command copied to clipboard!';

  @override
  String get adbSteps =>
      '1. Turn on USB Debugging on your phone\n2. Connect phone to your computer via USB\n3. Run the command above in your terminal\n4. Tap \'Verify Permission\' below';

  @override
  String get grantViaRoot => 'Grant via Root (SU)';

  @override
  String get checkPermission => 'Verify Permission';

  @override
  String get permissionGrantedSuccess => 'Permission verified successfully!';

  @override
  String get permissionNotGranted =>
      'Permission not detected. Please run the ADB command first.';

  @override
  String get rootSuccess => 'Permission granted via Root successfully!';

  @override
  String get rootFailed => 'Root grant failed. Please use the ADB command.';

  @override
  String get whyTitle => 'Why FastDO?';

  @override
  String get whyProblem =>
      'Banking & fintech apps frequently block devices with Developer Options enabled.\n• Before FastDO: Settings -> System -> Developer Options -> Turn off -> Open bank -> Settings -> Turn on.\n• With FastDO: One tap from notification shade. Quick, seamless, and frictionless.';

  @override
  String get privacyTitle => '100% Offline & Private';

  @override
  String get privacyPoints =>
      '✓ No internet permission (100% offline)\n✓ Zero tracking, zero analytics, zero ads\n✓ Modifies only DEVELOPMENT_SETTINGS_ENABLED';

  @override
  String get theme => 'Theme';

  @override
  String get language => 'Language';

  @override
  String get systemMode => 'System';

  @override
  String get darkMode => 'Dark';

  @override
  String get lightMode => 'Light';

  @override
  String get toggleSuccess => 'Developer Options updated successfully!';

  @override
  String get toggleFailed => 'Failed to toggle Developer Options.';

  @override
  String get footerTagline => 'FastDO • Fast Developer Options Controller';

  @override
  String get versionInfo => 'Version 1.0.0';
}
