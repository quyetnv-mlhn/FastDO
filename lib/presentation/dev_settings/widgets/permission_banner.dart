import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/utils/context_extensions.dart';
import '../../../core/widgets/base_card.dart';
import 'app_permission_sheet.dart';

class PermissionBanner extends StatelessWidget {
  const PermissionBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final l10n = context.l10n;

    return BaseCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      backgroundColor: isDark
          ? const Color(0xFF231B14)
          : const Color(0xFFFFFBEB),
      borderColor: isDark ? const Color(0xFF78350F) : const Color(0xFFFDE68A),
      borderWidth: 1.0,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.accentAmber.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.lock_clock_rounded,
              color: AppColors.accentAmber,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.permissionBannerTitle,
                  style: context.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: isDark
                        ? const Color(0xFFFDE68A)
                        : const Color(0xFF92400E),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  l10n.permissionBannerSubtitle,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: isDark
                        ? const Color(0xFFD1D5DB)
                        : const Color(0xFF78350F),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () => AppPermissionSheet.show(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentAmber,
              foregroundColor: Colors.black,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: const RoundedRectangleBorder(
                borderRadius: AppRadius.subtleBorder,
              ),
              textStyle: context.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            child: Text(l10n.setupPermissionButton),
          ),
        ],
      ),
    );
  }
}
