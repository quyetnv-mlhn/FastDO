import 'package:flutter/material.dart';

import '../l10n/translations.dart';
import '../models/dev_settings_state.dart';
import '../providers/dev_settings_provider.dart';
import '../theme/app_theme.dart';

class QuickSettingsTileCard extends StatelessWidget {
  final DevSettingsState state;
  final DevSettingsProvider provider;

  const QuickSettingsTileCard({
    super.key,
    required this.state,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.dashboard_customize_rounded,
                  color: AppTheme.primaryGreen,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.qsTileTitle,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      AppStrings.qsTileSubtitle,
                      style: TextStyle(
                        fontSize: 12.5,
                        height: 1.35,
                        color: isDark
                            ? const Color(0xFF94A3B8)
                            : const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Action button for Android 13+ (Add Tile directly)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () async {
                final requested = await provider.requestAddTile();
                if (context.mounted) {
                  if (requested) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(AppStrings.tileAddedNotice),
                        backgroundColor: AppTheme.primaryGreenDark,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  } else {
                    // Show manual instructions
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text(AppStrings.qsTileTitle),
                        content: Text(AppStrings.howToAddTileManual),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                }
              },
              icon: const Icon(Icons.add_to_photos_rounded, size: 18),
              label: Text(AppStrings.addTileButton),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryGreen,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                textStyle: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),
          // How to add manually note
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF0F172A).withValues(alpha: 0.6)
                  : const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark
                    ? const Color(0xFF334155)
                    : const Color(0xFFE2E8F0),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.touch_app_outlined,
                  size: 18,
                  color: AppTheme.primaryGreen,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    AppStrings.howToAddTileManual,
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.45,
                      color: isDark
                          ? const Color(0xFFCBD5E1)
                          : const Color(0xFF475569),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
