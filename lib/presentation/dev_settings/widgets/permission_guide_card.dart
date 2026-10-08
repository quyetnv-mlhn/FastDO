import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/utils/context_extensions.dart';
import '../../../core/widgets/base_button.dart';
import '../../../core/widgets/base_card.dart';
import '../bloc/dev_settings_cubit.dart';
import '../bloc/dev_settings_state.dart';

class PermissionGuideCard extends StatelessWidget {
  static const String adbCommand =
      'adb shell pm grant com.quyetnv.fastdo android.permission.WRITE_SECURE_SETTINGS';

  final DevSettingsState state;

  const PermissionGuideCard({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final l10n = context.l10n;

    return BaseCard(
      padding: const EdgeInsets.all(20),
      backgroundColor:
          isDark ? const Color(0xFF261C14) : const Color(0xFFFFFBEB),
      borderColor: isDark ? const Color(0xFF78350F) : const Color(0xFFFDE68A),
      borderWidth: 1.2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.accentAmber.withValues(alpha: 0.15),
                  borderRadius: AppRadius.subtleBorder,
                ),
                child: const Icon(
                  Icons.vpn_key_rounded,
                  color: AppColors.accentAmber,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.permissionRequired,
                      style: TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w700,
                        color: isDark
                            ? const Color(0xFFFDE68A)
                            : const Color(0xFF92400E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.permissionDesc,
                      style: TextStyle(
                        fontSize: 12.5,
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
          Text(
            l10n.adbCommandTitle,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          _AdbCommandBox(adbCommand: adbCommand),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF1F2937).withValues(alpha: 0.5)
                  : const Color(0xFFFEF3C7),
              borderRadius: AppRadius.subtleBorder,
            ),
            child: Text(
              l10n.adbSteps,
              style: TextStyle(
                fontSize: 12,
                height: 1.5,
                color:
                    isDark ? const Color(0xFFCBD5E1) : const Color(0xFF78350F),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _ActionButtonsRow(state: state),
        ],
      ),
    );
  }
}

class _AdbCommandBox extends StatelessWidget {
  final String adbCommand;

  const _AdbCommandBox({required this.adbCommand});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final l10n = context.l10n;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F172A) : const Color(0xFF1E293B),
        borderRadius: AppRadius.subtleBorder,
        border: Border.all(
          color: isDark ? const Color(0xFF334155) : const Color(0xFF475569),
          width: 0.8,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SelectableText(
            adbCommand,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
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
                Clipboard.setData(ClipboardData(text: adbCommand));
                HapticFeedback.lightImpact();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l10n.commandCopied),
                    backgroundColor: AppColors.primaryGreenDark,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              icon: const Icon(Icons.copy_rounded, size: 15),
              label: Text(l10n.copyCommand),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                foregroundColor: Colors.white,
                elevation: 0,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                textStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: AppRadius.subtleBorder,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButtonsRow extends StatelessWidget {
  final DevSettingsState state;

  const _ActionButtonsRow({required this.state});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Row(
      children: [
        Expanded(
          child: BaseButton(
            onPressed: () async {
              await context.read<DevSettingsCubit>().loadStatus();
              if (context.mounted) {
                final hasPerm =
                    context.read<DevSettingsCubit>().state.info.hasPermission;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      hasPerm
                          ? l10n.permissionGrantedSuccess
                          : l10n.permissionNotGranted,
                    ),
                    backgroundColor:
                        hasPerm ? AppColors.primaryGreenDark : Colors.redAccent,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            variant: ButtonVariant.secondary,
            icon: const Icon(Icons.refresh_rounded, size: 18),
            label: l10n.checkPermission,
          ),
        ),
        if (state.info.isRootAvailable) ...[
          const SizedBox(width: 10),
          Expanded(
            child: BaseButton(
              onPressed: () async {
                final success = await context
                    .read<DevSettingsCubit>()
                    .grantRootPermission();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        success ? l10n.rootSuccess : l10n.rootFailed,
                      ),
                      backgroundColor: success
                          ? AppColors.primaryGreenDark
                          : Colors.redAccent,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              variant: ButtonVariant.outline,
              icon: const Icon(Icons.security_rounded, size: 18),
              label: l10n.grantViaRoot,
            ),
          ),
        ],
      ],
    );
  }
}
