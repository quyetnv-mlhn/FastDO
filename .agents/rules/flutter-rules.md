---
trigger: always_on
---

# Standard Flutter Clean Architecture Rules & Guidelines

## 1. Project Tech Stack & Standard Libraries
- **State Management:** `flutter_bloc` (Bloc for complex flows/events, Cubit for local/simple UI state).
- **Dependency Injection:** `get_it` + `injectable` (auto-registered via `build_runner`).
- **Routing:** `go_router` (centralized via `AppRoutes`, with type-safe parameters and guards).
- **Serialization & Immutability:** `freezed` + `json_serializable` (mandatory for Entities, DTOs, BLoC Events/States).
- **Functional Error Handling:** `fpdart` (all UseCases and Repositories return `Future<Either<Failure, T>>`).
- **Localization:** `flutter_localizations` with ARB files in `lib/presentation/l10n/` or `lib/l10n/`.

## 2. Flutter & Dart Tooling & Commands
- **Always use `fvm` prefix** for Flutter and Dart commands:
  - `fvm flutter analyze`
  - `fvm dart run build_runner build --delete-conflicting-outputs`
  - `fvm dart fix --apply`
  - `fvm dart format .`
  - `fvm flutter gen-l10n`

## 3. Architecture & Folder Structure (Clean Architecture)
```text
lib/
├── core/                   # Shared config, theme, routing, utils, errors, base widgets
│   ├── config/             # Environment, AppConfig, API endpoints
│   ├── errors/             # Failures, Exceptions, ErrorMessageMapper
│   ├── helpers/            # RequestHelper, RepositoryHelper
│   ├── logging/            # AppLogger, AppBlocObserver
│   ├── services/           # GetIt setup, SnackbarManager, DialogManager
│   ├── theme/              # AppTheme, Colors, Typography, Spacing, Radius
│   ├── utils/              # AppRoutes, AppRouter, Formatters, Validators
│   └── widgets/            # Reusable Base Widgets (BaseCard, BaseButton, AppTextField...)
├── data/                   # Data Layer (DataSources, DTOs, Repositories Implementation)
│   └── {feature}/
│       ├── datasources/    # Remote & Local DataSources
│       ├── dtos/           # Data Transfer Objects (@freezed + toDomain())
│       └── repositories/   # Repository Implementations (calls DataSource & maps to Domain)
├── domain/                 # Domain Layer (Pure Dart: Entities, Contracts, UseCases)
│   └── {feature}/
│       ├── models/         # Domain Entities (@freezed, immutable)
│       ├── repositories/   # Abstract Repository Interfaces
│       └── usecases/       # Single-responsibility UseCases (@lazySingleton)
├── presentation/           # Presentation Layer (BLoC/Cubit, Pages, Widgets, L10n)
│   ├── {feature}/
│   │   ├── bloc/           # BLoC / Cubit (@injectable)
│   │   ├── pages/          # Full Screen Pages (StatelessWidget)
│   │   └── widgets/        # Feature-specific sub-widgets
│   └── l10n/               # ARB Localization files
├── app.dart                # MaterialApp.router, Theme, Localization Config
└── main.dart               # Bootstrap, Dependency Injection, App Entry
```

## 4. Layer Rules
### 4.1. Domain Layer Rules
- **Pure Dart:** No Flutter UI dependencies (`material.dart`, `widgets.dart`...).
- **Entities:** Defined using `@freezed` (immutable).
- **Repositories:** Abstract interfaces only (`abstract class`).
- **UseCases:** Single business action per class, returns `Future<Either<Failure, T>>`.

### 4.2. Data Layer Rules
- **DTOs:** Suffix with `Dto` (`UserDto`), use `@freezed` + `@JsonSerializable`, implement `toDomain()`.
- **Repositories Implementation:** Wrap DataSource calls with error handling, map exceptions to typed `Failure` instances. Never leak raw JSON maps to the UI.

### 4.3. Presentation Layer Rules
- **BLoC / Cubit:** No business logic in widgets; widgets only render state and dispatch events.
- **Widget Optimization:** Prefer `StatelessWidget`. Use `const` constructors wherever possible.
- **No Hardcoding:** Use `AppRoutes`, `InputValidators`, `Theme.of(context).colorScheme`, and `Theme.of(context).textTheme`.

## 5. Code Readability & Maintainability Rules
- **File & Widget Size:** Keep widgets and files under ~250–300 lines; decompose complex widgets into smaller, single-responsibility sub-widgets.
- **Dedicated Widgets over `_build...()` Methods:** Prefer private/public `StatelessWidget` classes (`class _HeaderView extends StatelessWidget`) over helper methods (`Widget _buildHeader()`).
- **Isolate Mappers:** Extract status-to-color, icon maps, and large switch cases out of widget build methods into separate helpers or extensions.
- **Widget Nesting:** Keep nesting depth <= 4–5 levels.
- **Dark/Light Theme:** Never hardcode hex colors (`Color(0xFF...)`) for surfaces, backgrounds, or borders.

## 6. Base Widget Rules (Rule of Three)
- Extract any UI component used in **3 or more places** into `lib/core/widgets/`.
- Standardized naming: prefix with `Base` or `App` (`BaseCard`, `BaseButton`, `AppTextField`, `BaseBottomSheet`, `AppEmptyState`, `AppSkeleton`).
- Design base widgets to accept theme-driven styling and support `const` constructors.

## 7. Localization (L10n) Rules
- Never hardcode user-visible strings in UI.
- Use `context.l10n.keyName` or `AppLocalizations.of(context)!.keyName`.
- Update the template ARB (`app_en.arb`) and synchronize all supported language ARB files.
- Run `fvm flutter gen-l10n` after modifying ARB files.

## 8. Design Aesthetics & UI Polish
- **Typography:** Clear hierarchy with Serif for display/editorial titles, Sans-serif for system UI, Monospace for numbers/timers/IDs.
- **3-Tier Radius System:**
  - Sharp (4–6 dp): Tags, badges, chips.
  - Subtle (8–10 dp): Inputs, standard buttons, standard cards.
  - Soft (12–16 dp max): Bottom sheets, dialogs, hero cards.
- **Hairline Borders:** Use thin borders (`0.5–0.8 dp`) instead of heavy muddy shadows for separating sections.

## 9. Verification Checklist
```bash
fvm dart fix --apply
fvm dart format .
fvm flutter analyze
fvm dart run build_runner build --delete-conflicting-outputs
fvm flutter gen-l10n
```
