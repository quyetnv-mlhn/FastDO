# FastDO (Fast Developer Options) 🚀

<p align="center">
  <img src="https://img.shields.io/badge/License-MIT-emerald.svg" alt="License: MIT">
  <img src="https://img.shields.io/badge/platform-Android-3DDC84?logo=android" alt="Platform: Android">
  <img src="https://img.shields.io/badge/minSdk-24-blue" alt="Min SDK: 24">
  <img src="https://img.shields.io/badge/Architecture-Clean%20Architecture-teal" alt="Architecture: Clean Architecture">
  <img src="https://img.shields.io/badge/Privacy-100%25%20Offline-success" alt="Privacy: 100% Offline">
  <img src="https://img.shields.io/badge/PRs-welcome-brightgreen.svg" alt="PRs Welcome">
</p>

<p align="center"><b>A one-tap Quick Settings toggle for Android Developer Options — so your banking apps stop throwing a fit while you're building.</b></p>

---

## 🎯 The Problem & The Solution

If you're an Android or Flutter developer, **Developer Options** is almost always turned on for USB/Wireless debugging. However, many banking, fintech, and enterprise apps (Vietcombank, MB, Techcombank, VPBank, Cake, MoMo, etc.) strictly refuse to open or degrade security while Developer Options is active.

### The tedious old way:
> Settings ➔ System ➔ Developer Options ➔ Toggle Off ➔ Open banking app ➔ Navigate back ➔ Toggle On.

### The FastDO way:
**FastDO** turns that hassle into a single tap right from your **Quick Settings notification panel** or home screen.

---

## ✨ Features

- ⚡ **1-Tap Quick Settings Tile**: Pull down the notification shade and tap to toggle on/off instantly.
- 🔄 **Real-Time State Sync**: Syncs state automatically via `ContentObserver` whenever changed from system settings or the tile.
- 🛡️ **100% Offline & Private (Zero Network Permissions)**:
  - No `INTERNET` permission declared in AndroidManifest.
  - No analytics, no tracking, no ads, no remote connections.
  - Modifies strictly `Settings.Global.DEVELOPMENT_SETTINGS_ENABLED` and nothing else.
- 🔌 **USB Debugging Indicator**: Real-time status display of ADB connection.
- 🛠️ **Setup Wizard & Root Grant**: One-click ADB command copy with step-by-step instructions, plus instant Root (`su`) grant support for rooted devices.
- 🎨 **Material 3 & Bilingual Support**:
  - Dark Mode, Light Mode, and System Theme.
  - Full English 🇺🇸 and Vietnamese 🇻🇳 localization.

---

## 🔑 One-Time Permission Setup

Android requires `WRITE_SECURE_SETTINGS` permission to modify system developer options. This setup only needs to be performed **once**:

### Option 1: Via ADB from Computer (Recommended)
1. Enable **USB Debugging** in your phone's Developer Options.
2. Connect your phone to your computer via USB.
3. Open Terminal / Command Prompt and run:

```bash
adb shell pm grant com.quyetnv.fastdo android.permission.WRITE_SECURE_SETTINGS
```

### Option 2: Rooted Device (SU)
Open FastDO and tap **"Grant via Root (SU)"** to activate the permission instantly.

---

## 📱 Quick Settings Tile Setup

1. Swipe down the notification panel twice.
2. Tap the **Edit (Pencil)** icon.
3. Locate the **"Dev Options"** tile and drag it into your active tile list.
4. Tap the tile anytime to toggle Developer Options on/off.

---

## 🏗️ Architecture (Clean Architecture)

FastDO is built following modern Flutter Clean Architecture:

```text
lib/
├── core/                   # Theme, AppRadius, AppColors, Routing, Base Widgets, Failures
│   ├── errors/             # Typed failures & exceptions
│   ├── services/           # GetIt + Injectable dependency injection
│   ├── theme/              # Material 3 Theme & 3-Tier radius system
│   ├── utils/              # AppRouter (GoRouter), context extensions
│   └── widgets/            # BaseCard, BaseButton, AppStatusBadge
├── data/                   # Data Layer
│   └── dev_settings/       # DataSource (MethodChannel/EventChannel), DTOs, Repository Impl
├── domain/                 # Domain Layer (Pure Dart)
│   └── dev_settings/       # Entities (@freezed), IDevSettingsRepository, Single-purpose UseCases
├── presentation/           # Presentation Layer
│   ├── bloc/               # AppSettingsCubit (Theme & Language)
│   ├── dev_settings/       # DevSettingsCubit (@injectable), DevSettingsState (@freezed), Pages & Sub-widgets
│   └── l10n/               # ARB Localizations (en, vi)
├── app.dart                # MaterialApp.router, GoRouter, L10n config
└── main.dart               # Bootstrap & Dependency Injection setup
```

---

## 🚀 Getting Started & Building

```bash
# Clone the repository
git clone https://github.com/quyetnv/fastdo.git
cd fastdo

# Install dependencies
fvm flutter pub get

# Generate code & localizations
fvm flutter gen-l10n
fvm dart run build_runner build --delete-conflicting-outputs

# Verify code quality & run tests
fvm flutter analyze
fvm flutter test

# Build release APK
fvm flutter build apk --release
```

---

## 🤝 Contributing

Contributions are welcome! Please check out [CONTRIBUTING.md](CONTRIBUTING.md) for contribution guidelines.

---

## 📄 License & Privacy

- **License**: Released under the [MIT License](LICENSE).
- **Privacy**: Read our [Privacy Policy](PRIVACY.md).
