import 'package:flutter/material.dart';

/// The set of built-in app themes.
enum AppTheme { light, dark, monochrome, oledBlack, custom }

extension AppThemeLabel on AppTheme {
  String get label {
    switch (this) {
      case AppTheme.light:
        return 'Light';
      case AppTheme.dark:
        return 'Dark';
      case AppTheme.monochrome:
        return 'Monochrome';
      case AppTheme.oledBlack:
        return 'OLED Black';
      case AppTheme.custom:
        return 'Custom';
    }
  }

  IconData get icon {
    switch (this) {
      case AppTheme.light:
        return Icons.wb_sunny_outlined;
      case AppTheme.dark:
        return Icons.nightlight_round;
      case AppTheme.monochrome:
        return Icons.tonality;
      case AppTheme.oledBlack:
        return Icons.brightness_1;
      case AppTheme.custom:
        return Icons.palette_outlined;
    }
  }
}

class MyThemes {
  // ── Seed & accent colours ──────────────────────────────────────────────────
  static const _seedColor = Color(0xFFB54040); // deep warm red
  static const _monoSeed = Color(0xFF555555);

  // ── Material colour schemes ────────────────────────────────────────────────
  static final ColorScheme _lightScheme = ColorScheme.fromSeed(
    seedColor: _seedColor,
    brightness: Brightness.light,
  );
  static final ColorScheme _darkScheme = ColorScheme.fromSeed(
    seedColor: _seedColor,
    brightness: Brightness.dark,
  );
  static final ColorScheme _monoScheme = ColorScheme.fromSeed(
    seedColor: _monoSeed,
    brightness: Brightness.light,
  );
  static final ColorScheme _oledScheme = ColorScheme.fromSeed(
    seedColor: _seedColor,
    brightness: Brightness.dark,
  ).copyWith(surface: Colors.black, onSurface: Colors.white);

  // ── Public theme getters ───────────────────────────────────────────────────
  static ThemeData get lightTheme => _build(_lightScheme, Brightness.light);
  static ThemeData get darkTheme => _build(_darkScheme, Brightness.dark);
  static ThemeData get monochromeTheme => _build(
    _monoScheme,
    Brightness.light,
    scaffoldBg: const Color(0xFFF5F5F5),
  );
  static ThemeData get oledBlackTheme =>
      _build(_oledScheme, Brightness.dark, scaffoldBg: Colors.black);

  static ThemeData themeFor(AppTheme appTheme) {
    switch (appTheme) {
      case AppTheme.light:
        return lightTheme;
      case AppTheme.dark:
        return darkTheme;
      case AppTheme.monochrome:
        return monochromeTheme;
      case AppTheme.oledBlack:
        return oledBlackTheme;
      case AppTheme.custom:
        return lightTheme; // base; page BG is handled by colour filter
    }
  }

  // ── Mushaf page colour filter matrices ────────────────────────────────────

  /// Returns a [ColorFilter] that re-colours the mushaf page PNG for the
  /// given theme.  The pages are scanned with a white background and black
  /// ink, so a multiply-style matrix works perfectly:
  ///   white  × colour → colour   (background picks up the tint)
  ///   black  × any   → black     (ink stays dark)
  static ColorFilter? pageColorFilter(AppTheme theme, Color customBg) {
    switch (theme) {
      case AppTheme.light:
        return null; // show as-is

      case AppTheme.custom:
        return _multiplyFilter(customBg);

      case AppTheme.dark:
        // warm dark parchment
        return _multiplyFilter(const Color(0xFF2A1A0A));

      case AppTheme.monochrome:
        return const ColorFilter.matrix(<double>[
          0.2126,
          0.7152,
          0.0722,
          0,
          0,
          0.2126,
          0.7152,
          0.0722,
          0,
          0,
          0.2126,
          0.7152,
          0.0722,
          0,
          0,
          0,
          0,
          0,
          1,
          0,
        ]);

      case AppTheme.oledBlack:
        // Invert: white bg → black, black ink → white
        return const ColorFilter.matrix(<double>[
          -1,
          0,
          0,
          0,
          255,
          0,
          -1,
          0,
          0,
          255,
          0,
          0,
          -1,
          0,
          255,
          0,
          0,
          0,
          1,
          0,
        ]);
    }
  }

  /// Background colour shown behind (and around) the mushaf page PNG.
  static Color pageBackgroundColor(AppTheme theme, Color customBg) {
    switch (theme) {
      case AppTheme.light:
        return const Color(0xFFE4D2B7);
      case AppTheme.dark:
        return const Color(0xFF1A0D05);
      case AppTheme.monochrome:
        return const Color(0xFFDDDDDD);
      case AppTheme.oledBlack:
        return Colors.black;
      case AppTheme.custom:
        // Slightly darken the custom colour for the surrounding area.
        final hsl = HSLColor.fromColor(customBg);
        return hsl
            .withLightness((hsl.lightness - 0.08).clamp(0.0, 1.0))
            .toColor();
    }
  }

  // ── Helpers ────────────────────────────────────────────────────────────────
  static ThemeData _build(
    ColorScheme scheme,
    Brightness brightness, {
    Color? scaffoldBg,
  }) {
    return ThemeData(
      colorScheme: scheme,
      brightness: brightness,
      useMaterial3: true,
      scaffoldBackgroundColor: scaffoldBg,
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 1,
      ),
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      ),
    );
  }

  static ColorFilter _multiplyFilter(Color color) {
    return ColorFilter.matrix(<double>[
      color.r,
      0,
      0,
      0,
      0,
      0,
      color.g,
      0,
      0,
      0,
      0,
      0,
      color.b,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]);
  }
}
