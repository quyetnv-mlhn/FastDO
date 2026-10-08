import 'package:flutter/material.dart';
import '../l10n/translations.dart';
import '../providers/dev_settings_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/features_info_card.dart';
import '../widgets/permission_guide_card.dart';
import '../widgets/privacy_card.dart';
import '../widgets/quick_settings_tile_card.dart';
import '../widgets/status_hero_card.dart';

class HomeScreen extends StatelessWidget {
  final DevSettingsProvider provider;
  final VoidCallback onToggleTheme;
  final VoidCallback onToggleLanguage;
  final ThemeMode currentThemeMode;

  const HomeScreen({
    super.key,
    required this.provider,
    required this.onToggleTheme,
    required this.onToggleLanguage,
    required this.currentThemeMode,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListenableBuilder(
      listenable: provider,
      builder: (context, _) {
        final state = provider.state;

        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.terminal_rounded,
                    color: AppTheme.primaryGreen,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  AppStrings.appName,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ],
            ),
            actions: [
              // Language Switcher
              TextButton(
                onPressed: onToggleLanguage,
                style: TextButton.styleFrom(
                  minimumSize: const Size(40, 36),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  AppStrings.isVietnamese ? '🇻🇳 VI' : '🇺🇸 EN',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                  ),
                ),
              ),
              // Theme Switcher
              IconButton(
                onPressed: onToggleTheme,
                tooltip: AppStrings.theme,
                icon: Icon(
                  currentThemeMode == ThemeMode.dark
                      ? Icons.dark_mode_rounded
                      : (currentThemeMode == ThemeMode.light
                          ? Icons.light_mode_rounded
                          : Icons.brightness_auto_rounded),
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                  size: 20,
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              await provider.refreshAll();
            },
            color: AppTheme.primaryGreen,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Subtitle / Tagline
                  Center(
                    child: Text(
                      AppStrings.appTagline,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: isDark
                            ? const Color(0xFF94A3B8)
                            : const Color(0xFF64748B),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // 1. Hero Card: Big Toggle & Status
                  StatusHeroCard(
                    state: state,
                    provider: provider,
                  ),
                  const SizedBox(height: 16),

                  // 2. Permission Setup Card (if permission not granted)
                  if (!state.hasPermission) ...[
                    PermissionGuideCard(
                      state: state,
                      provider: provider,
                    ),
                    const SizedBox(height: 16),
                  ],

                  // 3. Quick Settings Tile Configuration Card
                  QuickSettingsTileCard(
                    state: state,
                    provider: provider,
                  ),
                  const SizedBox(height: 16),

                  // 4. Why FastDO Card (Banking apps problem)
                  const FeaturesInfoCard(),
                  const SizedBox(height: 16),

                  // 5. Privacy & Security Card
                  const PrivacyCard(),
                  const SizedBox(height: 24),

                  // Footer Info
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'FastDO v1.0.0 • Package: com.quyetnv.fastdo',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark
                                ? const Color(0xFF64748B)
                                : const Color(0xFF94A3B8),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Inspired by Loophole (shubhang-d/loophole)',
                          style: TextStyle(
                            fontSize: 11.5,
                            color: isDark
                                ? const Color(0xFF475569)
                                : const Color(0xFFCBD5E1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
