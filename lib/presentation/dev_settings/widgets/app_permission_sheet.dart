import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/context_extensions.dart';
import '../../../core/widgets/base_button.dart';
import '../../l10n/generated/app_localizations.dart';
import '../bloc/dev_settings_cubit.dart';
import '../bloc/dev_settings_state.dart';

class AppPermissionSheet extends StatelessWidget {
  static const String adbCommand =
      'adb shell pm grant com.quyetnv.fastdo android.permission.WRITE_SECURE_SETTINGS';

  const AppPermissionSheet({super.key});

  static void show(BuildContext context) {
    HapticFeedback.mediumImpact();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<DevSettingsCubit>(),
        child: const AppPermissionSheet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final l10n = context.l10n;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F172A) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        border: Border.all(
          color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
          width: 0.8,
        ),
      ),
      padding: EdgeInsets.only(
        top: 12,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: BlocBuilder<DevSettingsCubit, DevSettingsState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF475569)
                          : const Color(0xFFCBD5E1),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.accentAmber.withValues(alpha: 0.15),
                        borderRadius: AppRadius.subtleBorder,
                      ),
                      child: const Icon(
                        Icons.admin_panel_settings_rounded,
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
                            style: context.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            l10n.permissionDesc,
                            style: context.textTheme.bodySmall?.copyWith(
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
                const SizedBox(height: 18),
                Text(
                  l10n.adbCommandTitle,
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                _CommandBlock(command: adbCommand, l10n: l10n, isDark: isDark),
                const SizedBox(height: 16),
                _StepsGuide(l10n: l10n, isDark: isDark),
                const SizedBox(height: 20),
                _ActionRow(state: state, l10n: l10n),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CommandBlock extends StatelessWidget {
  final String command;
  final AppLocalizations l10n;
  final bool isDark;

  const _CommandBlock({
    required this.command,
    required this.l10n,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF030712) : const Color(0xFF0F172A),
        borderRadius: AppRadius.subtleBorder,
        border: Border.all(
          color: isDark ? const Color(0xFF1F2937) : const Color(0xFF334155),
          width: 0.8,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: SelectableText(
              command,
              style: AppTypography.code(
                fontSize: 11.5,
                color: const Color(0xFF34D399),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: command));
              HapticFeedback.lightImpact();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(l10n.commandCopied),
                  backgroundColor: AppColors.primaryGreenDark,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            tooltip: l10n.copyCommand,
            icon: const Icon(Icons.copy_rounded, size: 18),
            color: AppColors.primaryGreenLight,
          ),
        ],
      ),
    );
  }
}

class _StepsGuide extends StatelessWidget {
  final AppLocalizations l10n;
  final bool isDark;

  const _StepsGuide({required this.l10n, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _StepTile(
          num: '1',
          title: l10n.step1Title,
          desc: l10n.step1Desc,
          isDark: isDark,
        ),
        const SizedBox(height: 8),
        _StepTile(
          num: '2',
          title: l10n.step2Title,
          desc: l10n.step2Desc,
          isDark: isDark,
        ),
        const SizedBox(height: 8),
        _StepTile(
          num: '3',
          title: l10n.step3Title,
          desc: l10n.step3Desc,
          isDark: isDark,
        ),
      ],
    );
  }
}

class _StepTile extends StatelessWidget {
  final String num;
  final String title;
  final String desc;
  final bool isDark;

  const _StepTile({
    required this.num,
    required this.title,
    required this.desc,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 22,
          height: 22,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
          ),
          child: Text(
            num,
            style: AppTypography.code(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: isDark ? Colors.white : const Color(0xFF0F172A),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _ActionRow extends StatelessWidget {
  final DevSettingsState state;
  final AppLocalizations l10n;

  const _ActionRow({required this.state, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BaseButton(
          width: double.infinity,
          onPressed: () async {
            await context.read<DevSettingsCubit>().loadStatus();
            if (context.mounted) {
              final hasPerm = context
                  .read<DevSettingsCubit>()
                  .state
                  .info
                  .hasPermission;
              if (hasPerm) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l10n.permissionGrantedSuccess),
                    backgroundColor: AppColors.primaryGreenDark,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              } else {
                HapticFeedback.heavyImpact();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l10n.permissionNotGranted),
                    backgroundColor: Colors.redAccent,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            }
          },
          icon: const Icon(Icons.verified_user_rounded, size: 18),
          label: l10n.checkPermission,
        ),
        if (state.info.isRootAvailable) ...[
          const SizedBox(height: 10),
          BaseButton(
            width: double.infinity,
            variant: ButtonVariant.outline,
            onPressed: () async {
              final success = await context
                  .read<DevSettingsCubit>()
                  .grantRootPermission();
              if (context.mounted) {
                if (success) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.rootSuccess),
                      backgroundColor: AppColors.primaryGreenDark,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.rootFailed),
                      backgroundColor: Colors.redAccent,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              }
            },
            icon: const Icon(Icons.bolt_rounded, size: 18),
            label: l10n.grantViaRoot,
          ),
        ],
      ],
    );
  }
}
