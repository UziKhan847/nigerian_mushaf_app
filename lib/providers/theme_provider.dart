import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/my_themes.dart';
import 'package:nigerian_mushaf_app/providers/shared_prefs_provider.dart';

// ─────────────────────────────────────────────────────────────────────────────
// State
// ─────────────────────────────────────────────────────────────────────────────

class ThemeState {
  const ThemeState({required this.appTheme, required this.customBgColor});

  final AppTheme appTheme;
  final Color customBgColor;

  ThemeState copyWith({AppTheme? appTheme, Color? customBgColor}) => ThemeState(
    appTheme: appTheme ?? this.appTheme,
    customBgColor: customBgColor ?? this.customBgColor,
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Provider
// ─────────────────────────────────────────────────────────────────────────────

final themeProvider = NotifierProvider<ThemeNotifier, ThemeState>(
  ThemeNotifier.new,
);

class ThemeNotifier extends Notifier<ThemeState> {
  static const _themeKey = 'appTheme';
  static const _customBgKey = 'customBgColor';

  @override
  ThemeState build() {
    final prefs = ref.read(sharedPrefsProv);

    final themeName = prefs.getString(_themeKey);
    AppTheme appTheme = AppTheme.light;
    if (themeName != null) {
      appTheme = AppTheme.values.firstWhere(
        (e) => e.name == themeName,
        orElse: () => AppTheme.light,
      );
    } else {
      // Migrate legacy isDarkMode flag
      final wasDark = prefs.getBool('isDarkMode') ?? false;
      appTheme = wasDark ? AppTheme.dark : AppTheme.light;
    }

    final colorInt =
        prefs.getInt(_customBgKey) ?? const Color(0xFFE4D2B7).toARGB32();
    final customBg = Color(colorInt);

    return ThemeState(appTheme: appTheme, customBgColor: customBg);
  }

  void setTheme(AppTheme theme) {
    final prefs = ref.read(sharedPrefsProv);
    state = state.copyWith(appTheme: theme);
    prefs.setString(_themeKey, theme.name);
  }

  void setCustomBgColor(Color color) {
    final prefs = ref.read(sharedPrefsProv);
    state = state.copyWith(customBgColor: color);
    prefs.setInt(_customBgKey, color.toARGB32());
  }
}
