import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/context_extensions.dart';
import '../../../core/widgets/base_button.dart';
import '../../../core/widgets/base_card.dart';
import '../../l10n/generated/app_localizations.dart';
import '../bloc/dev_settings_cubit.dart';
import '../bloc/dev_settings_state.dart';
import 'app_permission_sheet.dart';

class WirelessDebuggingCard extends StatelessWidget {
  final DevSettingsState state;

  const WirelessDebuggingCard({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final isWifiOn = state.info.isWifiDebuggingEnabled;
    final hasPermission = state.info.hasPermission;
    final l10n = context.l10n;

    final activeColor = AppColors.accentCyan;

    final bg = isDark
        ? (isWifiOn
              ? const Color(0xFF083344).withValues(alpha: 0.32)
              : const Color(0xFF1E293B).withValues(alpha: 0.5))
        : (isWifiOn ? const Color(0xFFECFEFF) : const Color(0xFFFFFFFF));

    final borderColor = isWifiOn
        ? activeColor.withValues(alpha: 0.6)
        : (isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0));

    final effectivePort = state.info.wifiPort;

    return BaseCard(
      padding: const EdgeInsets.all(20),
      backgroundColor: bg,
      borderColor: borderColor,
      borderWidth: isWifiOn ? 1.4 : 0.8,
      borderRadius: AppRadius.softBorder,
      boxShadow: isWifiOn
          ? [
              BoxShadow(
                color: activeColor.withValues(alpha: 0.12),
                blurRadius: 24,
                offset: const Offset(0, 6),
              ),
            ]
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _WifiIconBox(isEnabled: isWifiOn, isDark: isDark),
              const SizedBox(width: 14),
              Expanded(
                child: _WifiStatusText(
                  isEnabled: isWifiOn,
                  isDark: isDark,
                  l10n: l10n,
                ),
              ),
              _WifiSwitch(
                isEnabled: isWifiOn,
                hasPermission: hasPermission,
                isDark: isDark,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            isWifiOn
                ? l10n.wifiDebuggingDescActive
                : l10n.wifiDebuggingDescDisabled,
            style: context.textTheme.bodyMedium?.copyWith(
              height: 1.45,
              color: isDark ? const Color(0xFFCBD5E1) : const Color(0xFF475569),
            ),
          ),
          if (isWifiOn && state.info.wifiIpAddress != null) ...[
            const SizedBox(height: 14),
            _IpCommandView(
              ipAddress: state.info.wifiIpAddress!,
              port: effectivePort,
              isDark: isDark,
              l10n: l10n,
            ),
          ],
          const SizedBox(height: 14),
          _ActionsRow(l10n: l10n),
        ],
      ),
    );
  }
}

class _WifiIconBox extends StatelessWidget {
  final bool isEnabled;
  final bool isDark;

  const _WifiIconBox({required this.isEnabled, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final activeColor = AppColors.accentCyan;
    final inactiveColor = isDark
        ? AppColors.inactiveGrey
        : const Color(0xFF64748B);

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: isEnabled
            ? activeColor.withValues(alpha: 0.18)
            : (isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9)),
        borderRadius: AppRadius.softBorder,
      ),
      child: Icon(
        Icons.wifi_tethering_rounded,
        color: isEnabled ? activeColor : inactiveColor,
        size: 24,
      ),
    );
  }
}

class _WifiStatusText extends StatelessWidget {
  final bool isEnabled;
  final bool isDark;
  final AppLocalizations l10n;

  const _WifiStatusText({
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
          l10n.wifiDebugging,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 3),
        Row(
          children: [
            Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isEnabled ? AppColors.accentCyan : Colors.grey,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              isEnabled ? l10n.statusActive : l10n.statusInactive,
              style: AppTypography.code(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: isEnabled
                    ? (isDark
                          ? AppColors.accentCyanLight
                          : const Color(0xFF0891B2))
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

class _WifiSwitch extends StatelessWidget {
  final bool isEnabled;
  final bool hasPermission;
  final bool isDark;

  const _WifiSwitch({
    required this.isEnabled,
    required this.hasPermission,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !hasPermission ? () => AppPermissionSheet.show(context) : null,
      behavior: HitTestBehavior.opaque,
      child: IgnorePointer(
        ignoring: !hasPermission,
        child: Transform.scale(
          scale: 1.02,
          child: Switch(
            value: isEnabled,
            thumbColor: const WidgetStatePropertyAll<Color>(Colors.white),
            trackColor: WidgetStateProperty.resolveWith<Color>((states) {
              if (states.contains(WidgetState.selected)) {
                return AppColors.accentCyan;
              }
              return isDark ? const Color(0xFF475569) : const Color(0xFFCBD5E1);
            }),
            onChanged: hasPermission
                ? (_) => context.read<DevSettingsCubit>().toggleWifiDebugging()
                : (_) => AppPermissionSheet.show(context),
          ),
        ),
      ),
    );
  }
}

class _IpCommandView extends StatelessWidget {
  final String ipAddress;
  final String? port;
  final bool isDark;
  final AppLocalizations l10n;

  const _IpCommandView({
    required this.ipAddress,
    required this.port,
    required this.isDark,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final isDetected = port != null;
    final command = isDetected ? 'adb connect $ipAddress:$port' : null;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF030712) : const Color(0xFF0F172A),
        borderRadius: AppRadius.subtleBorder,
        border: Border.all(
          color: isDark ? const Color(0xFF1F2937) : const Color(0xFF334155),
          width: 0.8,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.adbWifiCommandTitle,
            style: AppTypography.code(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF94A3B8),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              if (isDetected) ...[
                Expanded(
                  child: SelectableText(
                    command!,
                    style: AppTypography.code(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF38BDF8),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: command));
                    HapticFeedback.lightImpact();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(l10n.adbWifiCommandCopied),
                        backgroundColor: AppColors.accentCyanDark,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  tooltip: l10n.copyCommand,
                  icon: const Icon(Icons.copy_rounded, size: 18),
                  color: AppColors.accentCyanLight,
                ),
              ] else ...[
                const SizedBox(
                  width: 12,
                  height: 12,
                  child: CircularProgressIndicator(
                    strokeWidth: 1.8,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.accentCyan,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l10n.detectingWifiPort,
                    style: AppTypography.code(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF94A3B8),
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

class _ActionsRow extends StatelessWidget {
  final AppLocalizations l10n;

  const _ActionsRow({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BaseButton(
            variant: ButtonVariant.secondary,
            height: 42,
            onPressed: () => context
                .read<DevSettingsCubit>()
                .openWirelessDebuggingSettings(),
            icon: const Icon(Icons.phonelink_setup_rounded, size: 16),
            label: l10n.openWirelessDevSettings,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: BaseButton(
            variant: ButtonVariant.outline,
            height: 42,
            onPressed: () async {
              final requested = await context
                  .read<DevSettingsCubit>()
                  .requestAddWifiTile();
              if (context.mounted) {
                if (requested) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.wirelessTileAddedNotice),
                      backgroundColor: AppColors.accentCyanDark,
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
                      title: Text(l10n.qsWifiTileTitle),
                      content: Text(l10n.howToAddWifiTileManual),
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
            icon: const Icon(Icons.add_to_home_screen_rounded, size: 16),
            label: l10n.addWifiTileButton,
          ),
        ),
      ],
    );
  }
}
