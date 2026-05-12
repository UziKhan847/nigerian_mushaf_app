import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/my_themes.dart';
import 'package:nigerian_mushaf_app/providers/shared_prefs_provider.dart';

class ThemeState {
  const ThemeState({required this.appTheme, required this.customBgColor});

  final AppTheme appTheme;
  final Color customBgColor;

  ThemeState copyWith({AppTheme? appTheme, Color? customBgColor}) => ThemeState(
    appTheme: appTheme ?? this.appTheme,
    customBgColor: customBgColor ?? this.customBgColor,
  );
}

final themeProvider = NotifierProvider<ThemeNotifier, ThemeState>(
  ThemeNotifier.new,
);

class ThemeNotifier extends Notifier<ThemeState> {
  static const _themeKey    = 'appTheme';
  static const _customBgKey = 'customBgColor';

  @override
  ThemeState build() {
    final prefs = ref.read(sharedPrefsProv);

    // Theme
    final themeName = prefs.getString(_themeKey);
    AppTheme appTheme = AppTheme.light;
    if (themeName != null) {
      appTheme = AppTheme.values.firstWhere(
        (e) => e.name == themeName,
        orElse: () => AppTheme.light,
      );
    } else {
      // Migrate legacy isDarkMode flag.
      final wasDark = prefs.getBool('isDarkMode') ?? false;
      appTheme = wasDark ? AppTheme.dark : AppTheme.light;
    }

    // Custom background colour — toARGB32() replaces the deprecated .value
    final colorInt = prefs.getInt(_customBgKey) ??
        const Color(0xFFE4D2B7).toARGB32();
    final customBg = Color(colorInt);

    return ThemeState(appTheme: appTheme, customBgColor: customBg);
  }

  void setTheme(AppTheme theme) {
    state = state.copyWith(appTheme: theme);
    ref.read(sharedPrefsProv).setString(_themeKey, theme.name);
  }

  void setCustomBgColor(Color color) {
    state = state.copyWith(customBgColor: color);
    // toARGB32() is the non-deprecated replacement for Color.value
    ref.read(sharedPrefsProv).setInt(_customBgKey, color.toARGB32());
  }
}
