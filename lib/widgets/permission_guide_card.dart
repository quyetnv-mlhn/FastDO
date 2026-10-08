import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../l10n/translations.dart';
import '../models/dev_settings_state.dart';
import '../providers/dev_settings_provider.dart';
import '../services/dev_settings_service.dart';
import '../theme/app_theme.dart';

class PermissionGuideCard extends StatelessWidget {
  final DevSettingsState state;
  final DevSettingsProvider provider;

  const PermissionGuideCard({
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
        color: isDark ? const Color(0xFF261C14) : const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? const Color(0xFF78350F) : const Color(0xFFFDE68A),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Warning Header
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.accentAmber.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.vpn_key_rounded,
                  color: AppTheme.accentAmber,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.permissionRequired,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: isDark
                            ? const Color(0xFFFDE68A)
                            : const Color(0xFF92400E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppStrings.permissionDesc,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.4,
                        color: isDark
                            ? const Color(0xFFD1D5DB)
                            : const Color(0xFF78350F),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // ADB Command Box
          Text(
            AppStrings.adbCommandTitle,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF0F172A) : const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isDark ? const Color(0xFF334155) : const Color(0xFF475569),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SelectableText(
                  DevSettingsService.adbGrantCommand,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                    color: Color(0xFF34D399),
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Clipboard.setData(
                        const ClipboardData(text: DevSettingsService.adbGrantCommand),
                      );
                      HapticFeedback.lightImpact();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(AppStrings.commandCopied),
                          backgroundColor: AppTheme.primaryGreenDark,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.copy_rounded, size: 16),
                    label: Text(AppStrings.copyCommand),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryGreen,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      textStyle: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),
          // ADB Steps
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF1F2937).withValues(alpha: 0.5)
                  : const Color(0xFFFEF3C7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              AppStrings.adbSteps,
              style: TextStyle(
                fontSize: 12.5,
                height: 1.5,
                color: isDark ? const Color(0xFFCBD5E1) : const Color(0xFF78350F),
              ),
            ),
          ),

          const SizedBox(height: 16),
          // Buttons Row
          Row(
            children: [
              // Check Permission Button
              Expanded(
                child: FilledButton.icon(
                  onPressed: () async {
                    await provider.refreshAll();
                    if (context.mounted) {
                      if (provider.state.hasPermission) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(AppStrings.isVietnamese
                                ? 'Quyền đã được cấp thành công!'
                                : 'Permission verified successfully!'),
                            backgroundColor: AppTheme.primaryGreenDark,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(AppStrings.isVietnamese
                                ? 'Chưa nhận được quyền. Vui lòng chạy lệnh ADB trước.'
                                : 'Permission not granted yet. Please run ADB command first.'),
                            backgroundColor: Colors.redAccent,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    }
                  },
                  icon: const Icon(Icons.refresh_rounded, size: 18),
                  label: Text(AppStrings.checkPermissionAgain),
                  style: FilledButton.styleFrom(
                    backgroundColor: isDark
                        ? const Color(0xFF334155)
                        : const Color(0xFF0F172A),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),

              if (state.isRootAvailable) ...[
                const SizedBox(width: 10),
                // Root Grant Button
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      final success = await provider.grantRootPermission();
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(success
                                ? AppStrings.rootSuccess
                                : AppStrings.rootFailed),
                            backgroundColor: success
                                ? AppTheme.primaryGreenDark
                                : Colors.redAccent,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.security_rounded, size: 18),
                    label: Text(AppStrings.grantViaRoot),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.accentAmber,
                      side: const BorderSide(color: AppTheme.accentAmber),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
