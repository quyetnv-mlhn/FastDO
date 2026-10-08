# Contributing to FastDO

Thank you for your interest in contributing to **FastDO**! We welcome bug reports, feature suggestions, localization improvements, and pull requests.

---

## 🛠️ Development Setup

1. **Prerequisites:**
   - Flutter SDK `^3.27.x` (or `fvm`)
   - Android SDK with platform tools (`adb`)

2. **Clone & Install Dependencies:**
   ```bash
   git clone https://github.com/quyetnv/fastdo.git
   cd fastdo
   fvm flutter pub get
   ```

3. **Code Generation:**
   ```bash
   fvm flutter gen-l10n
   fvm dart run build_runner build --delete-conflicting-outputs
   ```

4. **Verify Quality Guidelines:**
   Before submitting a PR, make sure all tests and lints pass:
   ```bash
   fvm dart format .
   fvm flutter analyze
   fvm flutter test
   ```

---

## 📐 Architecture Guidelines

FastDO strictly follows **Clean Architecture**:
- **Core Layer (`lib/core`)**: Theme, routing, base widgets, utilities.
- **Data Layer (`lib/data`)**: Native data sources, DTOs, repository implementations.
- **Domain Layer (`lib/domain`)**: Pure Dart models, repository interfaces, use cases.
- **Presentation Layer (`lib/presentation`)**: Flutter BLoC/Cubit, pages, sub-widgets, ARB localizations.

---

## 📄 License
By contributing to FastDO, you agree that your contributions will be licensed under the [MIT License](LICENSE).
