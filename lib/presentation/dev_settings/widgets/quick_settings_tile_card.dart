import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/utils/context_extensions.dart';
import '../../../core/widgets/base_button.dart';
import '../../../core/widgets/base_card.dart';
import '../bloc/dev_settings_cubit.dart';
import '../bloc/dev_settings_state.dart';

class QuickSettingsTileCard extends StatelessWidget {
  final DevSettingsState state;

  const QuickSettingsTileCard({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final l10n = context.l10n;

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
                  color: AppColors.primaryGreen.withValues(alpha: 0.15),
                  borderRadius: AppRadius.subtleBorder,
                ),
                child: const Icon(
                  Icons.dashboard_customize_rounded,
                  color: AppColors.primaryGreen,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.qsTileTitle,
                      style: TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.qsTileSubtitle,
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
          BaseButton(
            width: double.infinity,
            onPressed: () async {
              final requested =
                  await context.read<DevSettingsCubit>().requestAddTile();
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
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      shape: const RoundedRectangleBorder(
                        borderRadius: AppRadius.softBorder,
                      ),
                      title: Text(l10n.qsTileTitle),
                      content: Text(l10n.howToAddTileManual),
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
            label: l10n.addTileButton,
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF0F172A).withValues(alpha: 0.6)
                  : const Color(0xFFF8FAFC),
              borderRadius: AppRadius.subtleBorder,
              border: Border.all(
                color:
                    isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                width: 0.8,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.touch_app_outlined,
                  size: 18,
                  color: AppColors.primaryGreen,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    l10n.howToAddTileManual,
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
