import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'l10n/translations.dart';
import 'providers/dev_settings_provider.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const FastDoApp());
}

class FastDoApp extends StatefulWidget {
  const FastDoApp({super.key});

  @override
  State<FastDoApp> createState() => _FastDoAppState();
}

class _FastDoAppState extends State<FastDoApp> {
  late final DevSettingsProvider _provider;
  ThemeMode _themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    _provider = DevSettingsProvider();
  }

  @override
  void dispose() {
    _provider.dispose();
    super.dispose();
  }

  void _toggleTheme() {
    setState(() {
      if (_themeMode == ThemeMode.system) {
        _themeMode = ThemeMode.dark;
      } else if (_themeMode == ThemeMode.dark) {
        _themeMode = ThemeMode.light;
      } else {
        _themeMode = ThemeMode.system;
      }
    });
  }

  void _toggleLanguage() {
    setState(() {
      AppStrings.isVietnamese = !AppStrings.isVietnamese;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FastDO',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: _themeMode,
      home: HomeScreen(
        provider: _provider,
        onToggleTheme: _toggleTheme,
        onToggleLanguage: _toggleLanguage,
        currentThemeMode: _themeMode,
      ),
    );
  }
}
