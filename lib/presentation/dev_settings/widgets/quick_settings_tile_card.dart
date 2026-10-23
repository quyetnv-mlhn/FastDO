import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/context_extensions.dart';
import '../../../core/widgets/base_card.dart';
import '../bloc/dev_settings_cubit.dart';
import '../bloc/dev_settings_state.dart';

class QuickSettingsTileCard extends StatelessWidget {
  final DevSettingsState state;

  const QuickSettingsTileCard({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final l10n = context.l10n;
    final isDevEnabled = state.info.isDevOptionsEnabled;
    final isWifiEnabled = state.info.isWifiDebuggingEnabled;

    return BaseCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.accentCyan.withValues(alpha: 0.15),
                  borderRadius: AppRadius.subtleBorder,
                ),
                child: const Icon(
                  Icons.widgets_rounded,
                  color: AppColors.accentCyan,
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.qsTileTitle,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.qsTileSubtitle,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: isDark
                            ? const Color(0xFF94A3B8)
                            : const Color(0xFF64748B),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Android Quick Settings Tile Mockup Showcase
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9),
              borderRadius: AppRadius.softBorder,
              border: Border.all(
                color: isDark
                    ? const Color(0xFF1E293B)
                    : const Color(0xFFE2E8F0),
                width: 0.8,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.touch_app_rounded,
                      size: 14,
                      color: AppColors.accentCyan,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      l10n.qsSimulatorTitle,
                      style: AppTypography.code(
                        fontSize: 11,
                        color: isDark
                            ? const Color(0xFF94A3B8)
                            : const Color(0xFF64748B),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _SimulatedTile(
                        icon: Icons.developer_mode_rounded,
                        title: 'Dev Options',
                        subtitle: isDevEnabled ? l10n.active : l10n.inactive,
                        isActive: isDevEnabled,
                        isDark: isDark,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _SimulatedTile(
                        icon: Icons.wifi_tethering_rounded,
                        title: 'Wireless ADB',
                        subtitle: isWifiEnabled ? l10n.active : l10n.inactive,
                        isActive: isWifiEnabled,
                        isDark: isDark,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Action Button
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton.icon(
              onPressed: () async {
                HapticFeedback.lightImpact();
                final requested = await context
                    .read<DevSettingsCubit>()
                    .requestAddTile();
                if (context.mounted) {
                  if (requested) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(l10n.tileAddedNotice),
                        backgroundColor: AppColors.primaryGreenDark,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  } else {
                    _showManualSetupDialog(context);
                  }
                }
              },
              icon: const Icon(Icons.add_circle_outline_rounded, size: 18),
              label: Text(
                l10n.addTileButton,
                style: context.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                foregroundColor: Colors.black,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: AppRadius.subtleBorder,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Help hint box
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF1E293B).withValues(alpha: 0.5)
                  : const Color(0xFFF8FAFC),
              borderRadius: AppRadius.subtleBorder,
              border: Border.all(
                color: isDark
                    ? const Color(0xFF334155)
                    : const Color(0xFFE2E8F0),
                width: 0.8,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Icon(
                    Icons.info_outline_rounded,
                    size: 15,
                    color: AppColors.accentCyan,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l10n.howToAddTileManual,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: isDark
                          ? const Color(0xFF94A3B8)
                          : const Color(0xFF64748B),
                      fontSize: 12,
                      height: 1.4,
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

  void _showManualSetupDialog(BuildContext context) {
    final l10n = context.l10n;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.softBorder),
        title: Row(
          children: [
            const Icon(Icons.widgets_rounded, color: AppColors.accentCyan),
            const SizedBox(width: 10),
            Expanded(child: Text(l10n.qsTileTitle)),
          ],
        ),
        content: Text(
          l10n.howToAddTileManual,
          style: context.textTheme.bodyMedium?.copyWith(height: 1.5),
        ),
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

class _SimulatedTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isActive;
  final bool isDark;

  const _SimulatedTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isActive,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final activeBg = isDark
        ? AppColors.primaryGreen.withValues(alpha: 0.22)
        : AppColors.primaryGreen.withValues(alpha: 0.18);
    final inactiveBg = isDark
        ? const Color(0xFF1E293B)
        : const Color(0xFFE2E8F0);

    final activeBorder = AppColors.primaryGreen.withValues(alpha: 0.6);
    final inactiveBorder = isDark
        ? const Color(0xFF334155)
        : const Color(0xFFCBD5E1);

    final activeFg = AppColors.primaryGreen;
    final inactiveFg = isDark
        ? const Color(0xFF94A3B8)
        : const Color(0xFF64748B);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isActive ? activeBg : inactiveBg,
        borderRadius: AppRadius.softBorder,
        border: Border.all(
          color: isActive ? activeBorder : inactiveBorder,
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.primaryGreen.withValues(alpha: 0.25)
                  : (isDark ? const Color(0xFF0F172A) : Colors.white),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 16,
              color: isActive ? activeFg : inactiveFg,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: isActive
                        ? (isDark ? Colors.white : const Color(0xFF0F172A))
                        : inactiveFg,
                    fontSize: 12,
                  ),
                ),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.code(
                    fontSize: 10,
                    color: isActive ? activeFg : inactiveFg,
                    fontWeight: FontWeight.w600,
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
