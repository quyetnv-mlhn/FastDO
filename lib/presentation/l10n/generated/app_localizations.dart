import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi')
  ];

  /// Application name
  ///
  /// In en, this message translates to:
  /// **'FastDO'**
  String get appName;

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'Fast Developer Options Controller'**
  String get appTagline;

  /// No description provided for @devOptionsEnabled.
  ///
  /// In en, this message translates to:
  /// **'Developer Options Enabled'**
  String get devOptionsEnabled;

  /// No description provided for @devOptionsDisabled.
  ///
  /// In en, this message translates to:
  /// **'Developer Options Disabled'**
  String get devOptionsDisabled;

  /// No description provided for @statusActive.
  ///
  /// In en, this message translates to:
  /// **'STATUS: ACTIVE'**
  String get statusActive;

  /// No description provided for @statusInactive.
  ///
  /// In en, this message translates to:
  /// **'STATUS: DISABLED'**
  String get statusInactive;

  /// No description provided for @devOptionsDescActive.
  ///
  /// In en, this message translates to:
  /// **'Banking and security-sensitive apps may restrict access while active. Tap to toggle off instantly.'**
  String get devOptionsDescActive;

  /// No description provided for @devOptionsDescDisabled.
  ///
  /// In en, this message translates to:
  /// **'Your device is in normal mode. All banking and fintech apps will open smoothly. Tap to re-enable when developing.'**
  String get devOptionsDescDisabled;

  /// No description provided for @usbDebugging.
  ///
  /// In en, this message translates to:
  /// **'USB Debugging'**
  String get usbDebugging;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @inactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive;

  /// No description provided for @openSystemDevSettings.
  ///
  /// In en, this message translates to:
  /// **'System Settings'**
  String get openSystemDevSettings;

  /// No description provided for @qsTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick Settings Tile'**
  String get qsTileTitle;

  /// No description provided for @qsTileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Toggle Developer Options directly from your notification panel without opening the app.'**
  String get qsTileSubtitle;

  /// No description provided for @addTileButton.
  ///
  /// In en, this message translates to:
  /// **'Add Tile to Quick Settings'**
  String get addTileButton;

  /// No description provided for @tileAddedNotice.
  ///
  /// In en, this message translates to:
  /// **'Quick Settings tile request sent!'**
  String get tileAddedNotice;

  /// No description provided for @howToAddTileManual.
  ///
  /// In en, this message translates to:
  /// **'Manual setup: Swipe down the notification panel twice -> Tap the Edit (Pencil) icon -> Drag the \'Dev Options\' tile to your active shortcuts.'**
  String get howToAddTileManual;

  /// No description provided for @permissionRequired.
  ///
  /// In en, this message translates to:
  /// **'System Permission Required'**
  String get permissionRequired;

  /// No description provided for @permissionDesc.
  ///
  /// In en, this message translates to:
  /// **'Android requires WRITE_SECURE_SETTINGS permission to control developer settings. Setup is only needed once via ADB or Root.'**
  String get permissionDesc;

  /// No description provided for @adbCommandTitle.
  ///
  /// In en, this message translates to:
  /// **'ADB Setup Command'**
  String get adbCommandTitle;

  /// No description provided for @copyCommand.
  ///
  /// In en, this message translates to:
  /// **'Copy Command'**
  String get copyCommand;

  /// No description provided for @commandCopied.
  ///
  /// In en, this message translates to:
  /// **'ADB command copied to clipboard!'**
  String get commandCopied;

  /// No description provided for @adbSteps.
  ///
  /// In en, this message translates to:
  /// **'1. Turn on USB Debugging on your phone\n2. Connect phone to your computer via USB\n3. Run the command above in your terminal\n4. Tap \'Verify Permission\' below'**
  String get adbSteps;

  /// No description provided for @grantViaRoot.
  ///
  /// In en, this message translates to:
  /// **'Grant via Root (SU)'**
  String get grantViaRoot;

  /// No description provided for @checkPermission.
  ///
  /// In en, this message translates to:
  /// **'Verify Permission'**
  String get checkPermission;

  /// No description provided for @permissionGrantedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Permission verified successfully!'**
  String get permissionGrantedSuccess;

  /// No description provided for @permissionNotGranted.
  ///
  /// In en, this message translates to:
  /// **'Permission not detected. Please run the ADB command first.'**
  String get permissionNotGranted;

  /// No description provided for @rootSuccess.
  ///
  /// In en, this message translates to:
  /// **'Permission granted via Root successfully!'**
  String get rootSuccess;

  /// No description provided for @rootFailed.
  ///
  /// In en, this message translates to:
  /// **'Root grant failed. Please use the ADB command.'**
  String get rootFailed;

  /// No description provided for @whyTitle.
  ///
  /// In en, this message translates to:
  /// **'Why FastDO?'**
  String get whyTitle;

  /// No description provided for @whyProblem.
  ///
  /// In en, this message translates to:
  /// **'Banking & fintech apps frequently block devices with Developer Options enabled.\n• Before FastDO: Settings -> System -> Developer Options -> Turn off -> Open bank -> Settings -> Turn on.\n• With FastDO: One tap from notification shade. Quick, seamless, and frictionless.'**
  String get whyProblem;

  /// No description provided for @privacyTitle.
  ///
  /// In en, this message translates to:
  /// **'100% Offline & Private'**
  String get privacyTitle;

  /// No description provided for @privacyPoints.
  ///
  /// In en, this message translates to:
  /// **'✓ No internet permission (100% offline)\n✓ Zero tracking, zero analytics, zero ads\n✓ Modifies only DEVELOPMENT_SETTINGS_ENABLED'**
  String get privacyPoints;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @systemMode.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get systemMode;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get darkMode;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get lightMode;

  /// No description provided for @toggleSuccess.
  ///
  /// In en, this message translates to:
  /// **'Developer Options updated successfully!'**
  String get toggleSuccess;

  /// No description provided for @toggleFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to toggle Developer Options.'**
  String get toggleFailed;

  /// No description provided for @footerTagline.
  ///
  /// In en, this message translates to:
  /// **'FastDO • Fast Developer Options Controller'**
  String get footerTagline;

  /// No description provided for @versionInfo.
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0'**
  String get versionInfo;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
