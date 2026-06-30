import 'package:flutter/material.dart';
import 'package:nigerian_mushaf_app/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_rail_button.dart';
import 'package:nigerian_mushaf_app/providers/theme_provider.dart';

class BgColorItem extends ConsumerWidget {
  const BgColorItem({super.key, required this.removeOverlay});
  final VoidCallback removeOverlay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Active when the page colour differs from the default (white).
    final pageColor = ref.watch(themeProvider).pageColor;
    final isTinted =
        pageColor.r <= 0.97 || pageColor.g <= 0.97 || pageColor.b <= 0.97;
    return NavRailButton(
      icon: Icons.color_lens_outlined,
      label: AppLocalizations.of(context).navPageColour,
      isActive: isTinted,
      onPressed: () {
        final ctx = context;
        removeOverlay();
        showModalBottomSheet(
          context: ctx,
          isScrollControlled: true,   // ← prevents overflow
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          builder: (_) => Consumer(
            builder: (sheetCtx, ref, _) {
              final ts = ref.watch(themeProvider);
              return _BgColorSheet(
                currentColor: ts.pageColor,
                onColorChanged: (c) =>
                    ref.read(themeProvider.notifier).setPageColor(c),
              );
            },
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _BgColorSheet extends StatefulWidget {
  const _BgColorSheet({required this.currentColor, required this.onColorChanged});
  final Color currentColor;
  final ValueChanged<Color> onColorChanged;

  @override
  State<_BgColorSheet> createState() => _BgColorSheetState();
}

class _BgColorSheetState extends State<_BgColorSheet> {
  late HSLColor _hsl;

  @override
  void initState() {
    super.initState();
    _hsl = HSLColor.fromColor(widget.currentColor);
  }

  @override
  void didUpdateWidget(covariant _BgColorSheet old) {
    super.didUpdateWidget(old);
    if (old.currentColor != widget.currentColor) {
      _hsl = HSLColor.fromColor(widget.currentColor);
    }
  }

  void _update(HSLColor hsl) {
    setState(() => _hsl = hsl);
    widget.onColorChanged(hsl.toColor());
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final current = _hsl.toColor();

    return SafeArea(
      child: SingleChildScrollView(
        // SingleChildScrollView handles the case where the sheet content
        // is taller than the available space (e.g. small / landscape screens).
        padding: EdgeInsets.fromLTRB(
          24, 16, 24,
          // Extra bottom padding so the preset circles clear the nav bar.
          MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40, height: 4,
                decoration: BoxDecoration(
                  color: cs.onSurfaceVariant.withAlpha(80),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 18),

            // Title + preview swatch
            Row(children: [
              Text(AppLocalizations.of(context).colourPickerTitle,
                  style: Theme.of(context).textTheme.titleLarge),
              const Spacer(),
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(
                  color: current,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: cs.outline.withAlpha(80)),
                ),
              ),
            ]),
            const SizedBox(height: 20),

            _SliderRow(
              label: AppLocalizations.of(context).colourPickerHue,
              value: _hsl.hue / 360.0,
              gradient: LinearGradient(colors: List.generate(13,
                  (i) => HSLColor.fromAHSL(
                    1, i * 30.0,
                    _hsl.saturation.clamp(0.1, 1.0),
                    _hsl.lightness,
                  ).toColor())),
              onChanged: (v) => _update(_hsl.withHue(v * 360.0)),
            ),
            const SizedBox(height: 14),

            _SliderRow(
              label: AppLocalizations.of(context).colourPickerSaturation,
              value: _hsl.saturation,
              gradient: LinearGradient(colors: [
                HSLColor.fromAHSL(1, _hsl.hue, 0, _hsl.lightness).toColor(),
                HSLColor.fromAHSL(1, _hsl.hue, 1, _hsl.lightness).toColor(),
              ]),
              onChanged: (v) => _update(_hsl.withSaturation(v)),
            ),
            const SizedBox(height: 14),

            _SliderRow(
              label: AppLocalizations.of(context).colourPickerLightness,
              value: _hsl.lightness,
              gradient: LinearGradient(colors: [
                Colors.black,
                HSLColor.fromAHSL(1, _hsl.hue, _hsl.saturation, 0.5).toColor(),
                Colors.white,
              ]),
              onChanged: (v) => _update(_hsl.withLightness(v)),
            ),
            const SizedBox(height: 20),

            Text(AppLocalizations.of(context).colourPickerPresets, style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10, runSpacing: 10,
              children: _presets.map((c) {
                final sel =
                    (current.r - c.r).abs() < 0.01 &&
                    (current.g - c.g).abs() < 0.01 &&
                    (current.b - c.b).abs() < 0.01;
                return GestureDetector(
                  onTap: () => _update(HSLColor.fromColor(c)),
                  child: Container(
                    width: 36, height: 36,
                    decoration: BoxDecoration(
                      color: c,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: sel ? cs.primary : cs.outline.withAlpha(80),
                        width: sel ? 2.5 : 1,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  static const _presets = [
    Color(0xFFFFFFFF), // default (white)
    Color(0xFFF7EEC7), // yellow cream
    Color(0xFFE4D2B7),
    Color(0xFFD4C5A0),
    Color(0xFFC8E6C9),
    Color(0xFFBBDEFB),
    Color(0xFFF8BBD0),
    Color(0xFFE1BEE7),
    Color(0xFFFFF9C4),
    Color(0xFF263238),
    Color(0xFF1A1A1A),
  ];
}

// ─────────────────────────────────────────────────────────────────────────────

class _SliderRow extends StatelessWidget {
  const _SliderRow({
    required this.label,
    required this.value,
    required this.gradient,
    required this.onChanged,
  });
  final String label;
  final double value;
  final LinearGradient gradient;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Container(
            height: 24,
            decoration: BoxDecoration(gradient: gradient),
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 24,
                activeTrackColor: Colors.transparent,
                inactiveTrackColor: Colors.transparent,
                thumbColor: Colors.white,
                overlayColor: Colors.white.withAlpha(40),
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
              ),
              child: Slider(value: value, onChanged: onChanged),
            ),
          ),
        ),
      ],
    );
  }
}
