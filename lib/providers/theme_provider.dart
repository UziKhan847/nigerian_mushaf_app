import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/my_themes.dart';
import 'package:nigerian_mushaf_app/providers/shared_prefs_provider.dart';

/// App chrome theme + independent mushaf page colour.
///
/// [pageColor] (default white) only affects the page rendering in the light
/// theme; Dark and OLED always render the page inverted on a dark container.
class ThemeState {
  const ThemeState({required this.appTheme, required this.pageColor});

  final AppTheme appTheme;
  final Color pageColor;

  ThemeState copyWith({AppTheme? appTheme, Color? pageColor}) => ThemeState(
    appTheme:  appTheme  ?? this.appTheme,
    pageColor: pageColor ?? this.pageColor,
  );
}

final themeProvider = NotifierProvider<ThemeNotifier, ThemeState>(
  ThemeNotifier.new,
);

class ThemeNotifier extends Notifier<ThemeState> {
  static const _themeKey = 'appTheme';
  // Key kept from the old "custom background" feature so existing users keep
  // their saved colour.
  static const _pageColorKey = 'customBgColor';

  @override
  ThemeState build() {
    final prefs = ref.read(sharedPrefsProv);

    final saved = prefs.getString(_themeKey);
    AppTheme appTheme;
    Color? legacyPageColor;
    switch (saved) {
      case 'light':     appTheme = AppTheme.light; break;
      case 'dark':      appTheme = AppTheme.dark; break;
      case 'oledBlack': appTheme = AppTheme.oledBlack; break;
      // Legacy values from when the app theme and page colour were coupled:
      case 'white':
        appTheme = AppTheme.light;
        legacyPageColor = Colors.white;
        break;
      case 'yellowCream':
        appTheme = AppTheme.light;
        legacyPageColor = const Color(0xFFF7EEC7);
        break;
      case 'custom':
        appTheme = AppTheme.light; // saved colour below still applies
        break;
      default:
        final wasDark = prefs.getBool('isDarkMode') ?? false;
        appTheme = wasDark ? AppTheme.dark : AppTheme.light;
    }

    final pageColor = legacyPageColor ??
        Color(prefs.getInt(_pageColorKey) ?? Colors.white.toARGB32());

    return ThemeState(appTheme: appTheme, pageColor: pageColor);
  }

  void setTheme(AppTheme theme) {
    state = state.copyWith(appTheme: theme);
    ref.read(sharedPrefsProv).setString(_themeKey, theme.name);
  }

  void setPageColor(Color color) {
    state = state.copyWith(pageColor: color);
    ref.read(sharedPrefsProv).setInt(_pageColorKey, color.toARGB32());
  }
}
