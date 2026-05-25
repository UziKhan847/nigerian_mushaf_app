import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// AppTheme — enum with constructor (no separate extension needed)
// ─────────────────────────────────────────────────────────────────────────────

enum AppTheme {
  light('Light', Icons.wb_sunny_outlined),
  white('White', Icons.brightness_high_outlined),
  yellowCream('Yellow Cream', Icons.auto_awesome_outlined),
  dark('Dark', Icons.nightlight_round),
  oledBlack('OLED Black', Icons.brightness_1),
  custom('Custom', Icons.palette_outlined);

  const AppTheme(this.label, this.icon);
  final String label;
  final IconData icon;
}

// ─────────────────────────────────────────────────────────────────────────────
// MyThemes
// ─────────────────────────────────────────────────────────────────────────────

class MyThemes {
  static const _seed = Color(0xFFB54040);

  // ── Color schemes ──────────────────────────────────────────────────────────

  static final ColorScheme _lightScheme = ColorScheme.fromSeed(
    seedColor: _seed,
    brightness: Brightness.light,
  );
  static final ColorScheme _darkScheme = ColorScheme.fromSeed(
    seedColor: _seed,
    brightness: Brightness.dark,
  );

  // OLED: force every surface token to true black so the NavRail, cards,
  // dialogs, and bottom sheets are all black — not just the scaffold.
  static final ColorScheme _oledScheme =
      ColorScheme.fromSeed(
        seedColor: _seed,
        brightness: Brightness.dark,
      ).copyWith(
        surface: Colors.black,
        surfaceDim: Colors.black,
        surfaceBright: const Color(0xFF111111),
        surfaceContainerLowest: Colors.black,
        surfaceContainerLow: const Color(0xFF080808),
        surfaceContainer: const Color(0xFF0D0D0D),
        surfaceContainerHigh: const Color(0xFF111111),
        surfaceContainerHighest: const Color(0xFF161616),
        onSurface: Colors.white,
        onSurfaceVariant: const Color(0xFFCCCCCC),
      );

  // ── ThemeData getters ──────────────────────────────────────────────────────

  static ThemeData get lightTheme => _build(_lightScheme, Brightness.light);
  static ThemeData get whiteTheme =>
      _build(_lightScheme, Brightness.light, scaffoldBg: Colors.white);
  static ThemeData get darkTheme => _build(_darkScheme, Brightness.dark);
  static ThemeData get yellowCreamTheme => _build(
    _lightScheme,
    Brightness.light,
    scaffoldBg: const Color(0xFFF7EEC7),
  );
  static ThemeData get oledBlackTheme =>
      _build(_oledScheme, Brightness.dark, scaffoldBg: Colors.black);

  static ThemeData themeFor(AppTheme t) {
    switch (t) {
      case AppTheme.light:
        return lightTheme;
      case AppTheme.white:
        return whiteTheme;
      case AppTheme.dark:
        return darkTheme;
      case AppTheme.yellowCream:
        return yellowCreamTheme;
      case AppTheme.oledBlack:
        return oledBlackTheme;
      case AppTheme.custom:
        return lightTheme;
    }
  }

  // ── Mushaf page colour filters ─────────────────────────────────────────────

  static ColorFilter? pageColorFilter(AppTheme theme, Color customBg) {
    switch (theme) {
      case AppTheme.light:
      case AppTheme.white:
        return null; // show as-is

      case AppTheme.yellowCream:
        // Warm yellow-cream tint matching high-quality printed Arabic books.
        return _multiplyFilter(const Color(0xFFF7EEC7));

      case AppTheme.dark:
      case AppTheme.oledBlack:
        // Applied to the CONTENT layer only (text/black parts of the page).
        // The BORDER layer (coloured decorations) is stacked on top without
        // any filter, so all original colours are always preserved.
        //
        // Simple invert:  black text → white,  white paper → black.
        // The black areas merge with the dark container behind the page.
        // Dark vs OLED differ only in the container colour, not this filter.
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

      case AppTheme.custom:
        final hsl = HSLColor.fromColor(customBg);
        if (hsl.lightness < 0.5) {
          // Dark custom: invert content so text is readable on dark bg.
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
        // Light custom: multiply-tint content (white areas pick up the colour).
        return _multiplyFilter(customBg);
    }
  }

  static Color pageBackgroundColor(AppTheme theme, Color customBg) {
    switch (theme) {
      case AppTheme.light:
        return const Color(0xFFE4D2B7);
      case AppTheme.white:
        return Colors.white;
      case AppTheme.dark:
        return const Color(0xFF1A0D05);
      case AppTheme.yellowCream:
        return const Color(0xFFE8D994);
      case AppTheme.oledBlack:
        return Colors.black;
      case AppTheme.custom:
        final hsl = HSLColor.fromColor(customBg);
        return hsl
            .withLightness(
              (hsl.lightness + (hsl.lightness < 0.5 ? -0.05 : -0.08)).clamp(
                0.0,
                1.0,
              ),
            )
            .toColor();
    }
  }

  static Color pageHeaderInkColor(AppTheme theme, Color customBg) {
    switch (theme) {
      case AppTheme.light:
      case AppTheme.white:
      case AppTheme.yellowCream:
        return Colors.black87;
      case AppTheme.dark:
        return const Color(0xFFE8D0B0);
      case AppTheme.oledBlack:
        return Colors.white;
      case AppTheme.custom:
        return HSLColor.fromColor(customBg).lightness < 0.5
            ? Colors.white
            : Colors.black87;
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
      fontFamily: 'Ruwudu',
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
    final r = (color.r * 255.0).round().clamp(0, 255).toDouble();
    final g = (color.g * 255.0).round().clamp(0, 255).toDouble();
    final b = (color.b * 255.0).round().clamp(0, 255).toDouble();
    return ColorFilter.matrix(<double>[
      r / 255,
      0,
      0,
      0,
      0,
      0,
      g / 255,
      0,
      0,
      0,
      0,
      0,
      b / 255,
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
