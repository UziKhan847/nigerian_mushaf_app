import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_rail_button.dart';
import 'package:nigerian_mushaf_app/my_themes.dart';
import 'package:nigerian_mushaf_app/providers/theme_provider.dart';

class BgColorItem extends ConsumerWidget {
  const BgColorItem({super.key, required this.removeOverlay});

  final VoidCallback removeOverlay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final isCustom = themeState.appTheme == AppTheme.custom;

    return NavRailButton(
      icon: Icons.color_lens_outlined,
      label: 'Page\nColour',
      isActive: isCustom,
      onPressed: () {
        // Capture context BEFORE overlay removal unmounts this widget.
        final capturedContext = context;
        final currentColor = themeState.customBgColor;
        removeOverlay();
        _showColorPicker(capturedContext, currentColor);
      },
    );
  }

  void _showColorPicker(BuildContext context, Color initialColor) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      // Consumer owns its own ref — safe even after nav rail is unmounted.
      builder: (_) => Consumer(
        builder: (ctx, ref, _) {
          final state = ref.watch(themeProvider);
          return _BgColorSheet(
            currentColor: state.customBgColor,
            onColorChanged: (color) {
              ref.read(themeProvider.notifier).setCustomBgColor(color);
              // Auto-switch to custom theme so the colour is applied immediately.
              if (state.appTheme != AppTheme.custom) {
                ref.read(themeProvider.notifier).setTheme(AppTheme.custom);
              }
            },
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _BgColorSheet extends StatefulWidget {
  const _BgColorSheet({
    required this.currentColor,
    required this.onColorChanged,
  });

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
    // Keep slider positions in sync if the colour changes externally.
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

    return Padding(
      padding: EdgeInsets.fromLTRB(
        24,
        16,
        24,
        MediaQuery.of(context).viewInsets.bottom + 32,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: cs.onSurfaceVariant.withAlpha(80),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),

          Row(
            children: [
              Text(
                'Page Background Colour',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              // Live preview swatch
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: current,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: cs.outline.withAlpha(80),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          _SliderRow(
            label: 'Hue',
            value: _hsl.hue / 360.0,
            gradient: LinearGradient(
              colors: List.generate(
                13,
                (i) => HSLColor.fromAHSL(
                  1,
                  i * 30.0,
                  _hsl.saturation.clamp(0.1, 1.0),
                  _hsl.lightness,
                ).toColor(),
              ),
            ),
            onChanged: (v) => _update(_hsl.withHue(v * 360.0)),
          ),
          const SizedBox(height: 16),

          _SliderRow(
            label: 'Saturation',
            value: _hsl.saturation,
            gradient: LinearGradient(colors: [
              HSLColor.fromAHSL(1, _hsl.hue, 0, _hsl.lightness).toColor(),
              HSLColor.fromAHSL(1, _hsl.hue, 1, _hsl.lightness).toColor(),
            ]),
            onChanged: (v) => _update(_hsl.withSaturation(v)),
          ),
          const SizedBox(height: 16),

          _SliderRow(
            label: 'Lightness',
            value: _hsl.lightness,
            gradient: LinearGradient(colors: [
              Colors.black,
              HSLColor.fromAHSL(1, _hsl.hue, _hsl.saturation, 0.5).toColor(),
              Colors.white,
            ]),
            onChanged: (v) => _update(_hsl.withLightness(v)),
          ),
          const SizedBox(height: 24),

          // Quick presets
          Text('Presets', style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _presets.map((c) {
              final selected =
                  (current.r - c.r).abs() < 2 &&
                  (current.g - c.g).abs() < 2 &&
                  (current.b - c.b).abs() < 2;
              return GestureDetector(
                onTap: () => _update(HSLColor.fromColor(c)),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: c,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: selected ? cs.primary : cs.outline.withAlpha(80),
                      width: selected ? 2.5 : 1,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  static const List<Color> _presets = [
    Color(0xFFFFFFFF),
    Color(0xFFE4D2B7), // warm parchment
    Color(0xFFD4C5A0), // aged cream
    Color(0xFFC8E6C9), // soft green
    Color(0xFFBBDEFB), // soft blue
    Color(0xFFF8BBD0), // soft pink
    Color(0xFFE1BEE7), // soft lavender
    Color(0xFFFFF9C4), // soft yellow
    Color(0xFF263238), // dark slate
    Color(0xFF1A1A1A), // near-black
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
