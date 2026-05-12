import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// AppTheme — enum with constructor (no separate extension needed)
// ─────────────────────────────────────────────────────────────────────────────

enum AppTheme {
  light     ('Light',       Icons.wb_sunny_outlined),
  white     ('White',       Icons.brightness_high_outlined),
  dark      ('Dark',        Icons.nightlight_round),
  monochrome('Monochrome',  Icons.tonality),
  oledBlack ('OLED Black',  Icons.brightness_1),
  custom    ('Custom',      Icons.palette_outlined);

  const AppTheme(this.label, this.icon);
  final String label;
  final IconData icon;
}

// ─────────────────────────────────────────────────────────────────────────────
// MyThemes
// ─────────────────────────────────────────────────────────────────────────────

class MyThemes {
  static const _seed     = Color(0xFFB54040);
  static const _monoSeed = Color(0xFF555555);

  // ── Color schemes ──────────────────────────────────────────────────────────

  static final ColorScheme _lightScheme =
      ColorScheme.fromSeed(seedColor: _seed, brightness: Brightness.light);
  static final ColorScheme _darkScheme =
      ColorScheme.fromSeed(seedColor: _seed, brightness: Brightness.dark);
  static final ColorScheme _monoScheme =
      ColorScheme.fromSeed(seedColor: _monoSeed, brightness: Brightness.light);

  // OLED: force every surface token to true black so the NavRail, cards,
  // dialogs, and bottom sheets are all black — not just the scaffold.
  static final ColorScheme _oledScheme = ColorScheme.fromSeed(
    seedColor: _seed,
    brightness: Brightness.dark,
  ).copyWith(
    surface:                 Colors.black,
    surfaceDim:              Colors.black,
    surfaceBright:           const Color(0xFF111111),
    surfaceContainerLowest:  Colors.black,
    surfaceContainerLow:     const Color(0xFF080808),
    surfaceContainer:        const Color(0xFF0D0D0D),
    surfaceContainerHigh:    const Color(0xFF111111),
    surfaceContainerHighest: const Color(0xFF161616),
    onSurface:               Colors.white,
    onSurfaceVariant:        const Color(0xFFCCCCCC),
  );

  // ── ThemeData getters ──────────────────────────────────────────────────────

  static ThemeData get lightTheme      => _build(_lightScheme, Brightness.light);
  static ThemeData get whiteTheme      => _build(_lightScheme, Brightness.light,
                                              scaffoldBg: Colors.white);
  static ThemeData get darkTheme       => _build(_darkScheme,  Brightness.dark);
  static ThemeData get monochromeTheme => _build(_monoScheme,  Brightness.light,
                                              scaffoldBg: const Color(0xFFF0F0F0));
  static ThemeData get oledBlackTheme  => _build(_oledScheme,  Brightness.dark,
                                              scaffoldBg: Colors.black);

  static ThemeData themeFor(AppTheme t) {
    switch (t) {
      case AppTheme.light:       return lightTheme;
      case AppTheme.white:       return whiteTheme;
      case AppTheme.dark:        return darkTheme;
      case AppTheme.monochrome:  return monochromeTheme;
      case AppTheme.oledBlack:   return oledBlackTheme;
      case AppTheme.custom:      return lightTheme;
    }
  }

  // ── Mushaf page colour filters ─────────────────────────────────────────────

  static ColorFilter? pageColorFilter(AppTheme theme, Color customBg) {
    switch (theme) {
      case AppTheme.light:
      case AppTheme.white:
        return null; // show as-is

      case AppTheme.monochrome:
        return _multiplyFilter(const Color(0xFFE0E0E0));

      case AppTheme.dark:
        // Luminance-preserving inversion (k=1.8):
        // black → warm cream (232,208,176), white → dark brown (28,4,0).
        // Coloured pixels (red Quranic markings) stay orange-red, not teal.
        return const ColorFilter.matrix(<double>[
           0.61732, -1.28736, -0.12996, 0, 232,
          -0.38268, -0.28736, -0.12996, 0, 208,
          -0.38268, -1.28736,  0.87004, 0, 176,
           0,        0,        0,       1,   0,
        ]);

      case AppTheme.oledBlack:
        return const ColorFilter.matrix(<double>[
          -1, 0, 0, 0, 255,
           0,-1, 0, 0, 255,
           0, 0,-1, 0, 255,
           0, 0, 0, 1,   0,
        ]);

      case AppTheme.custom:
        final hsl = HSLColor.fromColor(customBg);
        if (hsl.lightness < 0.5) {
          final lightTarget = hsl
              .withLightness(0.88)
              .withSaturation((hsl.saturation * 0.3).clamp(0.0, 1.0))
              .toColor();
          return _remapFilter(darkTarget: customBg, lightTarget: lightTarget);
        }
        return _multiplyFilter(customBg);
    }
  }

  static Color pageBackgroundColor(AppTheme theme, Color customBg) {
    switch (theme) {
      case AppTheme.light:      return const Color(0xFFE4D2B7);
      case AppTheme.white:      return Colors.white;
      case AppTheme.dark:       return const Color(0xFF1A0D05);
      case AppTheme.monochrome: return const Color(0xFFCCCCCC);
      case AppTheme.oledBlack:  return Colors.black;
      case AppTheme.custom:
        final hsl = HSLColor.fromColor(customBg);
        return hsl.withLightness(
          (hsl.lightness + (hsl.lightness < 0.5 ? -0.05 : -0.08)).clamp(0.0, 1.0),
        ).toColor();
    }
  }

  static Color pageHeaderInkColor(AppTheme theme, Color customBg) {
    switch (theme) {
      case AppTheme.light:
      case AppTheme.white:
      case AppTheme.monochrome:  return Colors.black87;
      case AppTheme.dark:        return const Color(0xFFE8D0B0);
      case AppTheme.oledBlack:   return Colors.white;
      case AppTheme.custom:
        return HSLColor.fromColor(customBg).lightness < 0.5
            ? Colors.white
            : Colors.black87;
    }
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  static ThemeData _build(ColorScheme scheme, Brightness brightness,
      {Color? scaffoldBg}) {
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

  static ColorFilter _remapFilter({
    required Color darkTarget,
    required Color lightTarget,
  }) {
    double ch(Color c, double Function(Color) g) =>
        (g(c) * 255.0).round().clamp(0, 255).toDouble();
    final dr = ch(darkTarget,  (c) => c.r);
    final dg = ch(darkTarget,  (c) => c.g);
    final db = ch(darkTarget,  (c) => c.b);
    final lr = ch(lightTarget, (c) => c.r);
    final lg = ch(lightTarget, (c) => c.g);
    final lb = ch(lightTarget, (c) => c.b);
    return ColorFilter.matrix(<double>[
      (dr - lr) / 255, 0, 0, 0, lr,
      0, (dg - lg) / 255, 0, 0, lg,
      0, 0, (db - lb) / 255, 0, lb,
      0, 0, 0, 1, 0,
    ]);
  }

  static ColorFilter _multiplyFilter(Color color) {
    final r = (color.r * 255.0).round().clamp(0, 255).toDouble();
    final g = (color.g * 255.0).round().clamp(0, 255).toDouble();
    final b = (color.b * 255.0).round().clamp(0, 255).toDouble();
    return ColorFilter.matrix(<double>[
      r / 255, 0, 0, 0, 0,
      0, g / 255, 0, 0, 0,
      0, 0, b / 255, 0, 0,
      0, 0, 0, 1, 0,
    ]);
  }
}
