<p align="center">
  <br />
  <h1 align="center">⚡ FastDO</h1>
  <p align="center">
    <b>One-Tap Quick Settings Toggle for Android Developer Options</b>
  </p>
  <p align="center">
    <i>Tắt / Bật nhanh Tùy chọn nhà phát triển với 1 chạm — Tránh bị các ứng dụng ngân hàng và tài chính chặn khi đang lập trình.</i>
  </p>
  <p align="center">
    <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-10B981.svg?style=for-the-badge" alt="License: MIT"></a>
    <img src="https://img.shields.io/badge/Platform-Android_7.0+-3DDC84?style=for-the-badge&logo=android&logoColor=white" alt="Platform: Android">
    <img src="https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter 3.x">
    <img src="https://img.shields.io/badge/Architecture-Clean_Architecture-0D9488?style=for-the-badge" alt="Clean Architecture">
    <img src="https://img.shields.io/badge/Privacy-100%25_Offline-059669?style=for-the-badge" alt="100% Offline">
  </p>
  <br />
</p>

---

## 📌 Table of Contents

- [Overview](#-overview)
- [The Problem vs The Solution](#-the-problem-vs-the-solution)
- [Key Features](#-key-features)
- [One-Time ADB Setup](#-one-time-adb-setup)
- [Quick Settings Tile Setup](#-quick-settings-tile-setup)
- [Clean Architecture & Tech Stack](#-clean-architecture--tech-stack)
- [Build from Source](#-build-from-source)
- [CI/CD & Automated Releases](#-cicd--automated-releases)
- [Privacy & Security Guarantee](#-privacy--security-guarantee)
- [Contributing & License](#-contributing--license)

---

## 📖 Overview

**FastDO** is a lightweight, open-source Android utility designed specifically for mobile developers. It enables you to instantly toggle `Settings.Global.DEVELOPMENT_SETTINGS_ENABLED` on and off directly from the **Android Quick Settings panel (Notification Shade)** or from an in-app toggle without navigating deep into Android system menus.

---

## 💡 The Problem vs The Solution

### 🛑 The Problem
If you are an Android or Flutter developer, **Developer Options** is almost always kept enabled for USB/Wireless debugging. However, many banking, fintech, and enterprise apps (Vietcombank, MB Bank, Techcombank, VPBank, MoMo, Cake, etc.) detect this state and strictly block access for security reasons.

| The Old Way (6+ Steps) 😫 | The FastDO Way (1 Tap) 🚀 |
| :--- | :--- |
| 1. Open device **Settings**<br>2. Navigate to **System**<br>3. Tap **Developer Options**<br>4. Toggle it **OFF**<br>5. Open and use your banking app<br>6. Re-open Settings and toggle it **ON** again | 1. Swipe down the notification panel.<br>2. Tap the **Dev Options** tile.<br><br>👉 **Done in 0.5 seconds!** |

---

## ✨ Key Features

- ⚡ **1-Tap Quick Settings Tile**: Seamlessly integrated into Android's native Quick Settings (`TileService`).
- 🔄 **Real-Time State Synchronization**: Uses Android `ContentObserver` to monitor system settings changes and update the UI/Tile in real-time.
- 🛡️ **100% Offline & Zero Network Permissions**: Contains **no** `android.permission.INTERNET` permission. Zero analytics, zero telemetry, zero ads.
- 🔌 **USB Debugging Monitor**: Real-time ADB status detection (`ADB_ENABLED`).
- 🛠️ **Built-in Setup Wizard & Root Support**: Easy one-click ADB command copy with clear instructions, plus instant Root (`su`) grant for rooted devices.
- 🎨 **Material 3 Design & Bilingual**: Smooth dark/light themes with 3-tier radius system, supporting English 🇺🇸 and Tiếng Việt 🇻🇳.

---

## 🔑 One-Time ADB Setup

Because modifying secure system settings requires `WRITE_SECURE_SETTINGS` permission, Android requires this permission to be granted **once** via ADB or Root:

### Option A: Via ADB from PC (Recommended)

1. Enable **USB Debugging** on your Android device (`Settings` ➔ `Developer Options` ➔ `USB Debugging`).
2. Connect your device to your computer via USB cable.
3. Open Terminal / Command Prompt on your computer and execute:

```bash
adb shell pm grant com.quyetnv.fastdo android.permission.WRITE_SECURE_SETTINGS
```

4. Return to the FastDO app and tap **"Verify Permission"**.

### Option B: For Rooted Devices (SU)
If your device is rooted (Magisk / KernelSU / APatch), open FastDO and tap **"Grant via Root (SU)"** to activate the permission instantly.

---

## 📱 Quick Settings Tile Setup

<p align="center">
  <b>Add the FastDO tile to your Android Quick Settings in 3 easy steps:</b>
</p>

```
[ Swipe Down 2x ]  ➔  [ Tap Edit (Pencil Icon) ]  ➔  [ Drag "Dev Options" Tile Up ]
```

1. Swipe down from the top of your screen twice to expand the full Quick Settings panel.
2. Tap the **Edit (Pencil)** icon.
3. Locate the **"Dev Options"** tile and drag it to your active shortcuts.
4. Tap the tile anytime to toggle Developer Options on/off!

---

## 🏗️ Clean Architecture & Tech Stack

FastDO strictly adheres to **Clean Architecture** and industry best practices:

```text
lib/
├── core/                           # Shared infrastructure & base components
│   ├── errors/                     # Typed Failures & Exceptions (fpdart)
│   ├── services/                   # Dependency Injection (GetIt + Injectable)
│   ├── theme/                      # AppTheme, AppColors, 3-Tier AppRadius
│   ├── utils/                      # GoRouter config, context extensions
│   └── widgets/                    # BaseCard, BaseButton, AppStatusBadge
├── data/                           # Data Layer
│   └── dev_settings/
│       ├── datasources/            # Native MethodChannel & EventChannel implementation
│       ├── dtos/                   # DevSettingsDto (@freezed + toDomain())
│       └── repositories/           # DevSettingsRepositoryImpl (Either<Failure, T>)
├── domain/                         # Domain Layer (Pure Dart)
│   └── dev_settings/
│       ├── models/                 # DevSettingsInfo Entity (@freezed)
│       ├── repositories/           # IDevSettingsRepository (Abstract interface)
│       └── usecases/               # Single-responsibility UseCases (@lazySingleton)
├── presentation/                   # Presentation Layer
│   ├── bloc/                       # AppSettingsCubit (ThemeMode & Locale)
│   ├── dev_settings/
│   │   ├── bloc/                   # DevSettingsCubit (@injectable) & DevSettingsState
│   │   ├── pages/                  # HomePage (StatelessWidget)
│   │   └── widgets/                # StatusHeroCard, PermissionGuideCard, TileCard...
│   └── l10n/                       # ARB Localizations (app_en.arb, app_vi.arb)
├── app.dart                        # MaterialApp.router + GoRouter + L10n delegates
└── main.dart                       # App entry point & DI initialization
```

### 🧰 Tech Stack & Libraries
- **State Management:** `flutter_bloc`
- **Dependency Injection:** `get_it` + `injectable`
- **Routing:** `go_router`
- **Immutability & Serialization:** `freezed` + `json_serializable`
- **Functional Error Handling:** `fpdart` (`Either<Failure, T>`)
- **Localization:** `flutter_localizations` (ARB)

---

## 🚀 Build from Source

### Prerequisites
- [Flutter SDK](https://flutter.dev/) `^3.27.x` or [FVM](https://fvm.app/)
- Android SDK & Platform Tools

```bash
# 1. Clone the repository
git clone https://github.com/quyetnv-mlhn/fastdo.git
cd fastdo

# 2. Install dependencies
fvm flutter pub get

# 3. Generate Freezed, Injectable & Localization files
fvm flutter gen-l10n
fvm dart run build_runner build --delete-conflicting-outputs

# 4. Run static analysis & test suite
fvm flutter analyze
fvm flutter test

# 5. Build Release APK
fvm flutter build apk --release
```

### 🛠️ Quick Makefile Commands
```bash
make setup      # Install dependencies & generate all code
make check      # Run format, fix, analyze, and test
make gen        # Generate l10n & build_runner
make build-apk  # Build release APK
make grant-adb  # Grant WRITE_SECURE_SETTINGS via ADB
```

---

## 🤖 CI/CD & Automated Releases

FastDO includes production-ready **GitHub Actions workflows**:
- **`ci.yml`**: Automatically runs code formatting checks, static analysis (`flutter analyze`), and all unit/widget tests on every commit and pull request.
- **`release.yml`**: Automatically builds the Android Release APK and creates a GitHub Release whenever a version tag is pushed (e.g., `v1.0.0`):

```bash
git tag v1.0.0
git push origin v1.0.0
```

---

## 🔒 Privacy & Security Guarantee

- **Zero Network Access:** FastDO does not declare the `android.permission.INTERNET` permission in its `AndroidManifest.xml`.
- **Zero Data Collection:** No personal data, device identifiers, or analytics are ever collected, stored, or transmitted.
- **Minimal System Footprint:** FastDO only interacts with the single `DEVELOPMENT_SETTINGS_ENABLED` setting.

---

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

Developed with ❤️ by **[QuyetNV](https://github.com/quyetnv-mlhn)**.
