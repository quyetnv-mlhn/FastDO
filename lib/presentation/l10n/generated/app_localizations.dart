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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
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
  /// **'One-tap Quick Toggle for Android Developer Options'**
  String get appTagline;

  /// No description provided for @devOptionsEnabled.
  ///
  /// In en, this message translates to:
  /// **'DEVELOPER OPTIONS ENABLED'**
  String get devOptionsEnabled;

  /// No description provided for @devOptionsDisabled.
  ///
  /// In en, this message translates to:
  /// **'DEVELOPER OPTIONS DISABLED'**
  String get devOptionsDisabled;

  /// No description provided for @statusActive.
  ///
  /// In en, this message translates to:
  /// **'Status: ON'**
  String get statusActive;

  /// No description provided for @statusInactive.
  ///
  /// In en, this message translates to:
  /// **'Status: OFF'**
  String get statusInactive;

  /// No description provided for @devOptionsDescActive.
  ///
  /// In en, this message translates to:
  /// **'Banking & security apps may block access. Tap to quickly disable.'**
  String get devOptionsDescActive;

  /// No description provided for @devOptionsDescDisabled.
  ///
  /// In en, this message translates to:
  /// **'Safe for banking & fintech apps. Tap to re-enable when coding.'**
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
  /// **'Open System Dev Settings'**
  String get openSystemDevSettings;

  /// No description provided for @qsTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick Settings Tile'**
  String get qsTileTitle;

  /// No description provided for @qsTileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add a tile to your notification shade to toggle anytime without opening the app.'**
  String get qsTileSubtitle;

  /// No description provided for @addTileButton.
  ///
  /// In en, this message translates to:
  /// **'Add to Quick Settings (Android 13+)'**
  String get addTileButton;

  /// No description provided for @tileAddedNotice.
  ///
  /// In en, this message translates to:
  /// **'Quick Settings tile request sent!'**
  String get tileAddedNotice;

  /// No description provided for @howToAddTileManual.
  ///
  /// In en, this message translates to:
  /// **'Manual setup: Pull down notification shade twice -> Tap Edit (Pencil icon) -> Drag \"Dev Options\" tile into your active panel.'**
  String get howToAddTileManual;

  /// No description provided for @permissionRequired.
  ///
  /// In en, this message translates to:
  /// **'WRITE_SECURE_SETTINGS Required'**
  String get permissionRequired;

  /// No description provided for @permissionDesc.
  ///
  /// In en, this message translates to:
  /// **'Android requires this secure system permission to modify developer settings. Setup is only required once via ADB or Root.'**
  String get permissionDesc;

  /// No description provided for @adbCommandTitle.
  ///
  /// In en, this message translates to:
  /// **'ADB Command (Recommended):'**
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
  /// **'1. Enable USB Debugging in your phone settings\n2. Connect phone to computer via USB cable\n3. Open Terminal / CMD on your PC and run the command above\n4. Tap \"Check Permission\" below'**
  String get adbSteps;

  /// No description provided for @grantViaRoot.
  ///
  /// In en, this message translates to:
  /// **'Grant via Root (SU)'**
  String get grantViaRoot;

  /// No description provided for @checkPermission.
  ///
  /// In en, this message translates to:
  /// **'Check Permission'**
  String get checkPermission;

  /// No description provided for @permissionGrantedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Permission verified successfully!'**
  String get permissionGrantedSuccess;

  /// No description provided for @permissionNotGranted.
  ///
  /// In en, this message translates to:
  /// **'Permission not granted yet. Please run ADB command first.'**
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
  /// **'Why do you need FastDO?'**
  String get whyTitle;

  /// No description provided for @whyProblem.
  ///
  /// In en, this message translates to:
  /// **'• The Problem: Banking apps & fintech strictly block access when Developer Options is enabled.\n• Before: Navigate Settings -> System -> Developer Options -> Turn off -> Open bank app -> Navigate back -> Turn on. Tedious!\n• With FastDO: One tap from notification shade. Switch off for banking, switch on for coding!'**
  String get whyProblem;

  /// No description provided for @privacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Security First'**
  String get privacyTitle;

  /// No description provided for @privacyPoints.
  ///
  /// In en, this message translates to:
  /// **'✓ 100% Offline, zero INTERNET permissions\n✓ No ads, no analytics, no tracking\n✓ Only modifies DEVELOPMENT_SETTINGS_ENABLED\n✓ Open source & transparent'**
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
  /// **'Developer Options status updated successfully!'**
  String get toggleSuccess;

  /// No description provided for @toggleFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to toggle Developer Options.'**
  String get toggleFailed;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'vi': return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
