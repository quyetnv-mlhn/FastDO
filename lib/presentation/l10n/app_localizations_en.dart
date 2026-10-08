// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'FastDO';

  @override
  String get appTagline => 'One-tap Quick Toggle for Android Developer Options';

  @override
  String get devOptionsEnabled => 'DEVELOPER OPTIONS ENABLED';

  @override
  String get devOptionsDisabled => 'DEVELOPER OPTIONS DISABLED';

  @override
  String get statusActive => 'Status: ON';

  @override
  String get statusInactive => 'Status: OFF';

  @override
  String get devOptionsDescActive =>
      'Banking & security apps may block access. Tap to quickly disable.';

  @override
  String get devOptionsDescDisabled =>
      'Safe for banking & fintech apps. Tap to re-enable when coding.';

  @override
  String get usbDebugging => 'USB Debugging';

  @override
  String get active => 'Active';

  @override
  String get inactive => 'Inactive';

  @override
  String get openSystemDevSettings => 'Open System Dev Settings';

  @override
  String get qsTileTitle => 'Quick Settings Tile';

  @override
  String get qsTileSubtitle =>
      'Add a tile to your notification shade to toggle anytime without opening the app.';

  @override
  String get addTileButton => 'Add to Quick Settings (Android 13+)';

  @override
  String get tileAddedNotice => 'Quick Settings tile request sent!';

  @override
  String get howToAddTileManual =>
      'Manual setup: Pull down notification shade twice -> Tap Edit (Pencil icon) -> Drag \"Dev Options\" tile into your active panel.';

  @override
  String get permissionRequired => 'WRITE_SECURE_SETTINGS Required';

  @override
  String get permissionDesc =>
      'Android requires this secure system permission to modify developer settings. Setup is only required once via ADB or Root.';

  @override
  String get adbCommandTitle => 'ADB Command (Recommended):';

  @override
  String get copyCommand => 'Copy Command';

  @override
  String get commandCopied => 'ADB command copied to clipboard!';

  @override
  String get adbSteps =>
      '1. Enable USB Debugging in your phone settings\n2. Connect phone to computer via USB cable\n3. Open Terminal / CMD on your PC and run the command above\n4. Tap \"Check Permission\" below';

  @override
  String get grantViaRoot => 'Grant via Root (SU)';

  @override
  String get checkPermission => 'Check Permission';

  @override
  String get permissionGrantedSuccess => 'Permission verified successfully!';

  @override
  String get permissionNotGranted =>
      'Permission not granted yet. Please run ADB command first.';

  @override
  String get rootSuccess => 'Permission granted via Root successfully!';

  @override
  String get rootFailed => 'Root grant failed. Please use the ADB command.';

  @override
  String get whyTitle => 'Why do you need FastDO?';

  @override
  String get whyProblem =>
      '• The Problem: Banking apps & fintech strictly block access when Developer Options is enabled.\n• Before: Navigate Settings -> System -> Developer Options -> Turn off -> Open bank app -> Navigate back -> Turn on. Tedious!\n• With FastDO: One tap from notification shade. Switch off for banking, switch on for coding!';

  @override
  String get privacyTitle => 'Privacy & Security First';

  @override
  String get privacyPoints =>
      '✓ 100% Offline, zero INTERNET permissions\n✓ No ads, no analytics, no tracking\n✓ Only modifies DEVELOPMENT_SETTINGS_ENABLED\n✓ Open source & transparent';

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
  String get toggleSuccess => 'Developer Options status updated successfully!';

  @override
  String get toggleFailed => 'Failed to toggle Developer Options.';
}
