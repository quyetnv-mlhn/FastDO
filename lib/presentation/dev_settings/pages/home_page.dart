import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/injection.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radius.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/context_extensions.dart';
import '../../bloc/app_settings_cubit.dart';
import '../bloc/dev_settings_cubit.dart';
import '../bloc/dev_settings_state.dart';
import '../widgets/features_info_card.dart';
import '../widgets/permission_guide_card.dart';
import '../widgets/privacy_card.dart';
import '../widgets/quick_settings_tile_card.dart';
import '../widgets/status_hero_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DevSettingsCubit>(),
      child: const _HomePageView(),
    );
  }
}

class _HomePageView extends StatelessWidget {
  const _HomePageView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<DevSettingsCubit, DevSettingsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: AppColors.primaryGreen.withValues(alpha: 0.15),
                    borderRadius: AppRadius.sharpBorder,
                  ),
                  child: const Icon(
                    Icons.bolt_rounded,
                    color: AppColors.primaryGreen,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  l10n.appName,
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            actions: const [
              _LanguageButton(),
              _ThemeButton(),
              SizedBox(width: 8),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () => context.read<DevSettingsCubit>().loadStatus(),
            color: AppColors.primaryGreen,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text(
                      l10n.appTagline,
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  StatusHeroCard(state: state),
                  const SizedBox(height: 16),
                  if (!state.info.hasPermission) ...[
                    PermissionGuideCard(state: state),
                    const SizedBox(height: 16),
                  ],
                  QuickSettingsTileCard(state: state),
                  const SizedBox(height: 16),
                  const FeaturesInfoCard(),
                  const SizedBox(height: 16),
                  const PrivacyCard(),
                  const SizedBox(height: 24),
                  const _FooterView(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LanguageButton extends StatelessWidget {
  const _LanguageButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsCubit, AppSettingsState>(
      builder: (context, state) {
        final isVi = state.locale.languageCode == 'vi';

        return TextButton(
          onPressed: () => context.read<AppSettingsCubit>().toggleLocale(),
          style: TextButton.styleFrom(
            minimumSize: const Size(40, 36),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            shape: const RoundedRectangleBorder(
              borderRadius: AppRadius.subtleBorder,
            ),
          ),
          child: Text(
            isVi ? '🇻🇳 VI' : '🇺🇸 EN',
            style: context.textTheme.labelLarge,
          ),
        );
      },
    );
  }
}

class _ThemeButton extends StatelessWidget {
  const _ThemeButton();

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return BlocBuilder<AppSettingsCubit, AppSettingsState>(
      builder: (context, state) {
        return IconButton(
          onPressed: () => context.read<AppSettingsCubit>().toggleTheme(),
          tooltip: context.l10n.theme,
          icon: Icon(
            state.themeMode == ThemeMode.dark
                ? Icons.dark_mode_rounded
                : (state.themeMode == ThemeMode.light
                      ? Icons.light_mode_rounded
                      : Icons.brightness_auto_rounded),
            color: isDark ? Colors.white : const Color(0xFF0F172A),
            size: 20,
          ),
        );
      },
    );
  }
}

class _FooterView extends StatelessWidget {
  const _FooterView();

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final l10n = context.l10n;

    return Center(
      child: Column(
        children: [
          Text(
            l10n.footerTagline,
            style: context.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.versionInfo,
            style: AppTypography.code(
              fontSize: 11,
              color: isDark ? const Color(0xFF475569) : const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }
}
