import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/context_extensions.dart';
import '../../../core/widgets/app_status_badge.dart';
import '../../../core/widgets/base_card.dart';
import '../../l10n/generated/app_localizations.dart';
import '../bloc/dev_settings_cubit.dart';
import '../bloc/dev_settings_state.dart';

class StatusHeroCard extends StatelessWidget {
  final DevSettingsState state;

  const StatusHeroCard({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final isEnabled = state.info.isDevOptionsEnabled;
    final hasPermission = state.info.hasPermission;
    final l10n = context.l10n;

    final activeColor = AppColors.primaryGreen;

    final bg = isDark
        ? (isEnabled
              ? const Color(0xFF064E3B).withValues(alpha: 0.3)
              : const Color(0xFF1E293B).withValues(alpha: 0.5))
        : (isEnabled ? const Color(0xFFECFDF5) : const Color(0xFFFFFFFF));

    final borderColor = isEnabled
        ? activeColor.withValues(alpha: 0.6)
        : (isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0));

    return BaseCard(
      padding: const EdgeInsets.all(22),
      backgroundColor: bg,
      borderColor: borderColor,
      borderWidth: isEnabled ? 1.4 : 0.8,
      borderRadius: AppRadius.softBorder,
      boxShadow: isEnabled
          ? [
              BoxShadow(
                color: activeColor.withValues(alpha: 0.12),
                blurRadius: 28,
                offset: const Offset(0, 8),
              ),
            ]
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _IconBox(isEnabled: isEnabled, isDark: isDark),
              const SizedBox(width: 14),
              Expanded(
                child: _StatusTextView(
                  isEnabled: isEnabled,
                  isDark: isDark,
                  l10n: l10n,
                ),
              ),
              _SwitchView(
                isEnabled: isEnabled,
                hasPermission: hasPermission,
                isDark: isDark,
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            isEnabled ? l10n.devOptionsDescActive : l10n.devOptionsDescDisabled,
            style: context.textTheme.bodyMedium?.copyWith(
              color: isDark ? const Color(0xFFCBD5E1) : const Color(0xFF475569),
            ),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, thickness: 0.8),
          const SizedBox(height: 14),
          _BottomActionsRow(state: state),
        ],
      ),
    );
  }
}

class _IconBox extends StatelessWidget {
  final bool isEnabled;
  final bool isDark;

  const _IconBox({required this.isEnabled, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final activeColor = AppColors.primaryGreen;
    final inactiveColor = isDark
        ? AppColors.inactiveGrey
        : const Color(0xFF64748B);

    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: isEnabled
            ? activeColor.withValues(alpha: 0.18)
            : (isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9)),
        borderRadius: AppRadius.softBorder,
      ),
      child: Icon(
        isEnabled
            ? Icons.developer_mode_rounded
            : Icons.developer_mode_outlined,
        color: isEnabled ? activeColor : inactiveColor,
        size: 26,
      ),
    );
  }
}

class _StatusTextView extends StatelessWidget {
  final bool isEnabled;
  final bool isDark;
  final AppLocalizations l10n;

  const _StatusTextView({
    required this.isEnabled,
    required this.isDark,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isEnabled ? l10n.devOptionsEnabled : l10n.devOptionsDisabled,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
            color: isEnabled
                ? (isDark
                      ? AppColors.primaryGreenLight
                      : const Color(0xFF047857))
                : (isDark ? const Color(0xFFF1F5F9) : const Color(0xFF0F172A)),
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isEnabled ? AppColors.primaryGreen : Colors.grey,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              isEnabled ? l10n.statusActive : l10n.statusInactive,
              style: AppTypography.code(
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                color: isEnabled
                    ? (isDark
                          ? AppColors.primaryGreenLight
                          : const Color(0xFF059669))
                    : (isDark
                          ? const Color(0xFF94A3B8)
                          : const Color(0xFF64748B)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SwitchView extends StatelessWidget {
  final bool isEnabled;
  final bool hasPermission;
  final bool isDark;

  const _SwitchView({
    required this.isEnabled,
    required this.hasPermission,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.05,
      child: Switch(
        value: isEnabled,
        thumbColor: const WidgetStatePropertyAll<Color>(Colors.white),
        trackColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryGreen;
          }
          return isDark ? const Color(0xFF475569) : const Color(0xFFCBD5E1);
        }),
        onChanged: hasPermission
            ? (_) {
                context.read<DevSettingsCubit>().toggleDevOptions();
              }
            : null,
      ),
    );
  }
}

class _BottomActionsRow extends StatelessWidget {
  final DevSettingsState state;

  const _BottomActionsRow({required this.state});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final l10n = context.l10n;
    final isUsbOn = state.info.isUsbDebuggingEnabled;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        AppStatusBadge(
          label:
              '${l10n.usbDebugging}: ${isUsbOn ? l10n.active : l10n.inactive}',
          icon: Icons.usb_rounded,
          color: isUsbOn
              ? (isDark ? AppColors.accentCyan : const Color(0xFF0E7490))
              : Colors.grey,
        ),
        InkWell(
          onTap: () => context.read<DevSettingsCubit>().openDevSettings(),
          borderRadius: AppRadius.subtleBorder,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.openSystemDevSettings,
                  style: context.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: isDark
                        ? const Color(0xFF38BDF8)
                        : const Color(0xFF0284C7),
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 11,
                  color: isDark
                      ? const Color(0xFF38BDF8)
                      : const Color(0xFF0284C7),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
