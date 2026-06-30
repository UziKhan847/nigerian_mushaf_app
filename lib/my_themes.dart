import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// AppTheme — the APP CHROME only (nav rail, sheets, index pages, About…).
//
// The mushaf PAGE colour is independent (ThemeState.pageColor, default white)
// and is chosen with the Page Colour picker. The two only interact in Dark and
// OLED, where the page is always rendered inverted on a dark container.
// ─────────────────────────────────────────────────────────────────────────────

enum AppTheme {
  light    ('Light',      Icons.wb_sunny_outlined),
  dark     ('Dark',       Icons.nightlight_round),
  oledBlack('OLED Black', Icons.brightness_1);

  const AppTheme(this.label, this.icon);
  final String label;
  final IconData icon;
}

// ─────────────────────────────────────────────────────────────────────────────
// MyThemes
// ─────────────────────────────────────────────────────────────────────────────

class MyThemes {
  // Warm amber seed (matches the cream-and-orange design language).
  static const _seed = Color(0xFFD97E22);

  // Light palette (from the reference design):
  static const _cream      = Color(0xFFF8F2E5); // scaffold / surface
  static const _creamCard  = Color(0xFFFFFDF7); // cards / sheets
  static const _warmInk    = Color(0xFF33291B); // primary text
  static const _warmInkDim = Color(0xFF6F6353); // secondary text

  // ── Color schemes ──────────────────────────────────────────────────────────

  static final ColorScheme _lightScheme = ColorScheme.fromSeed(
    seedColor: _seed,
    brightness: Brightness.light,
  ).copyWith(
    surface:                 _cream,
    onSurface:               _warmInk,
    onSurfaceVariant:        _warmInkDim,
    surfaceDim:              const Color(0xFFEFE7D6),
    surfaceBright:           _creamCard,
    surfaceContainerLowest:  Colors.white,
    surfaceContainerLow:     _creamCard,
    surfaceContainer:        const Color(0xFFFBF7EC),
    surfaceContainerHigh:    const Color(0xFFF3ECDD),
    surfaceContainerHighest: const Color(0xFFEDE4D2),
  );

  static final ColorScheme _darkScheme =
      ColorScheme.fromSeed(seedColor: _seed, brightness: Brightness.dark);

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

  // ── ThemeData ──────────────────────────────────────────────────────────────

  static ThemeData get lightTheme =>
      _build(_lightScheme, Brightness.light, scaffoldBg: _cream);
  static ThemeData get darkTheme  => _build(_darkScheme, Brightness.dark);
  static ThemeData get oledBlackTheme =>
      _build(_oledScheme, Brightness.dark, scaffoldBg: Colors.black);

  static ThemeData themeFor(AppTheme t) {
    switch (t) {
      case AppTheme.light:     return lightTheme;
      case AppTheme.dark:      return darkTheme;
      case AppTheme.oledBlack: return oledBlackTheme;
    }
  }

  // ── Mushaf page rendering (independent of app chrome, except dark/OLED) ────

  static bool _isNearWhite(Color c) =>
      c.r > 0.97 && c.g > 0.97 && c.b > 0.97;

  /// Filter for the CONTENT layer only (the ink). The BORDER layer (coloured
  /// decorations) is always stacked on top unfiltered, preserving its colours.
  static ColorFilter? pageColorFilter(AppTheme theme, Color pageColor) {
    switch (theme) {
      case AppTheme.dark:
      case AppTheme.oledBlack:
        // Always inverted: black ink → white, white paper → black; the black
        // merges with the dark container. pageColor is intentionally ignored.
        return _invert;

      case AppTheme.light:
        if (_isNearWhite(pageColor)) return null; // default: show as-is
        if (HSLColor.fromColor(pageColor).lightness < 0.5) {
          // Dark page colour chosen → invert ink so it stays readable.
          return _invert;
        }
        // Light tint: multiply (white paper picks up the colour, ink stays).
        return _multiplyFilter(pageColor);
    }
  }

  /// Container colour painted around/behind the page image.
  static Color pageBackgroundColor(AppTheme theme, Color pageColor) {
    switch (theme) {
      case AppTheme.dark:      return const Color(0xFF1A0D05);
      case AppTheme.oledBlack: return Colors.black;
      case AppTheme.light:
        final hsl = HSLColor.fromColor(pageColor);
        return hsl
            .withLightness((hsl.lightness - 0.07).clamp(0.0, 1.0))
            .toColor();
    }
  }

  static Color pageHeaderInkColor(AppTheme theme, Color pageColor) {
    switch (theme) {
      case AppTheme.dark:      return const Color(0xFFE8D0B0);
      case AppTheme.oledBlack: return Colors.white;
      case AppTheme.light:
        return HSLColor.fromColor(pageColor).lightness < 0.5
            ? Colors.white
            : Colors.black87;
    }
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  static const _invert = ColorFilter.matrix(<double>[
    -1, 0, 0, 0, 255,
     0,-1, 0, 0, 255,
     0, 0,-1, 0, 255,
     0, 0, 0, 1,   0,
  ]);

  static ThemeData _build(ColorScheme scheme, Brightness brightness,
      {Color? scaffoldBg}) {
    return ThemeData(
      colorScheme: scheme,
      brightness: brightness,
      useMaterial3: true,
      fontFamily: 'Ruwudu',
      scaffoldBackgroundColor: scaffoldBg,
      appBarTheme: AppBarTheme(
        backgroundColor: scaffoldBg ?? scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 1,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: scheme.surfaceContainerLow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surfaceContainerLow,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: scheme.primary,
        thumbColor: scheme.primary,
      ),
    );
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
