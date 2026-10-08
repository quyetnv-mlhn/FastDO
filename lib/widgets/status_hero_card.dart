import 'package:flutter/material.dart';

import '../l10n/translations.dart';
import '../models/dev_settings_state.dart';
import '../providers/dev_settings_provider.dart';
import '../theme/app_theme.dart';

class StatusHeroCard extends StatelessWidget {
  final DevSettingsState state;
  final DevSettingsProvider provider;

  const StatusHeroCard({
    super.key,
    required this.state,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isEnabled = state.isDevOptionsEnabled;
    final hasPermission = state.hasPermission;

    final activeColor = AppTheme.primaryGreen;
    final inactiveColor = isDark
        ? AppTheme.inactiveGrey
        : const Color(0xFF64748B);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark
            ? (isEnabled
                  ? const Color(0xFF064E3B).withValues(alpha: 0.35)
                  : const Color(0xFF1E293B).withValues(alpha: 0.6))
            : (isEnabled ? const Color(0xFFECFDF5) : const Color(0xFFF1F5F9)),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isEnabled
              ? activeColor.withValues(alpha: 0.6)
              : (isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1)),
          width: isEnabled ? 2 : 1,
        ),
        boxShadow: isEnabled
            ? [
                BoxShadow(
                  color: activeColor.withValues(alpha: 0.15),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ]
            : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Icon + Main Switch
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: isEnabled
                      ? activeColor.withValues(alpha: 0.2)
                      : (isDark
                            ? const Color(0xFF334155)
                            : const Color(0xFFE2E8F0)),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(
                  isEnabled
                      ? Icons.developer_mode_rounded
                      : Icons.developer_mode_outlined,
                  color: isEnabled ? activeColor : inactiveColor,
                  size: 30,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isEnabled
                          ? AppStrings.devOptionsActive
                          : AppStrings.devOptionsDisabled,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.3,
                        color: isEnabled
                            ? (isDark
                                  ? AppTheme.primaryGreenLight
                                  : const Color(0xFF047857))
                            : (isDark
                                  ? const Color(0xFF94A3B8)
                                  : const Color(0xFF475569)),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isEnabled ? activeColor : Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          isEnabled
                              ? (AppStrings.isVietnamese
                                    ? 'Trạng thái: BẬT'
                                    : 'Status: ON')
                              : (AppStrings.isVietnamese
                                    ? 'Trạng thái: TẮT'
                                    : 'Status: OFF'),
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: isDark
                                ? const Color(0xFF94A3B8)
                                : const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Big Switch
              Transform.scale(
                scale: 1.1,
                child: Switch(
                  value: isEnabled,
                  activeThumbColor: Colors.white,
                  activeTrackColor: activeColor,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: isDark
                      ? const Color(0xFF475569)
                      : const Color(0xFFCBD5E1),
                  onChanged: hasPermission && !state.isLoading
                      ? (val) async {
                          if (val && !isEnabled) {
                            final confirmed = await showDialog<bool>(
                              context: context,
                              builder: (dialogContext) => AlertDialog(
                                title: Text(AppStrings.enableUsbWarningTitle),
                                content: Text(AppStrings.enableUsbWarningDesc),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(dialogContext, false),
                                    child: Text(AppStrings.cancel),
                                  ),
                                  FilledButton(
                                    onPressed: () =>
                                        Navigator.pop(dialogContext, true),
                                    child: Text(AppStrings.continueAction),
                                  ),
                                ],
                              ),
                            );
                            if (confirmed != true || !context.mounted) return;
                          }
                          await provider.toggleDevOptions(val);
                        }
                      : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Description
          Text(
            isEnabled
                ? AppStrings.devOptionsDescActive
                : AppStrings.devOptionsDescDisabled,
            style: TextStyle(
              fontSize: 13,
              height: 1.4,
              color: isDark ? const Color(0xFFCBD5E1) : const Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, thickness: 1),
          const SizedBox(height: 12),
          // Bottom Info: Wrap layout to prevent overflow on any screen width
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              // USB Debugging Chip
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF1E293B)
                      : const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.usb_rounded,
                      size: 15,
                      color: state.isUsbDebuggingEnabled
                          ? AppTheme.accentCyan
                          : Colors.grey,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '${AppStrings.usbDebugging}: ${state.isUsbDebuggingEnabled ? AppStrings.active : AppStrings.inactive}',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: state.isUsbDebuggingEnabled
                            ? (isDark
                                  ? AppTheme.accentCyan
                                  : const Color(0xFF0E7490))
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              // Open Settings button
              InkWell(
                onTap: () => provider.openDevSettings(),
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppStrings.openSystemSettings,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? const Color(0xFF38BDF8)
                              : const Color(0xFF0284C7),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.open_in_new_rounded,
                        size: 13,
                        color: isDark
                            ? const Color(0xFF38BDF8)
                            : const Color(0xFF0284C7),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
