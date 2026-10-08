import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

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
    final isAndroid = defaultTargetPlatform == TargetPlatform.android;

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

                  if (isAndroid) ...[
                    StatusHeroCard(state: state, provider: provider),
                    const SizedBox(height: 16),
                    if (!state.hasPermission) ...[
                      PermissionGuideCard(state: state, provider: provider),
                      const SizedBox(height: 16),
                    ],
                    QuickSettingsTileCard(state: state, provider: provider),
                    const SizedBox(height: 16),
                    const FeaturesInfoCard(),
                    const SizedBox(height: 16),
                  ] else ...[
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E293B) : Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: isDark
                              ? const Color(0xFF334155)
                              : const Color(0xFFE2E8F0),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.phone_iphone_rounded,
                            color: AppTheme.accentCyan,
                            size: 30,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            AppStrings.androidOnlyTitle,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: isDark
                                  ? Colors.white
                                  : const Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            AppStrings.androidOnlyDesc,
                            style: TextStyle(
                              fontSize: 13,
                              height: 1.5,
                              color: isDark
                                  ? const Color(0xFFCBD5E1)
                                  : const Color(0xFF475569),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

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
