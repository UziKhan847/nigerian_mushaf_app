import 'package:flutter/material.dart';
import 'package:nigerian_mushaf_app/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_rail_button.dart';
import 'package:nigerian_mushaf_app/providers/screen_dim_provider.dart';

class BrightnessItem extends ConsumerWidget {
  const BrightnessItem({super.key, required this.removeOverlay});
  final VoidCallback removeOverlay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dimmed = ref.watch(screenDimProvider) > 0.01;
    return NavRailButton(
      icon:  dimmed ? Icons.brightness_3 : Icons.brightness_5,
      label: AppLocalizations.of(context).navBrightness,
      isActive: dimmed,
      onPressed: () {
        final ctx = context;
        removeOverlay();
        showModalBottomSheet(
          context: ctx,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          builder: (_) => const _BrightnessSheet(),
        );
      },
    );
  }
}

class _BrightnessSheet extends ConsumerWidget {
  const _BrightnessSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs  = Theme.of(context).colorScheme;
    final dim = ref.watch(screenDimProvider);
    // Slider shows brightness (1.0 = full). brightness = 1 - dim.
    final brightness = 1.0 - dim;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40, height: 4,
                decoration: BoxDecoration(
                  color: cs.onSurfaceVariant.withAlpha(80),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(AppLocalizations.of(context).brightnessTitle, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context).brightnessHint,
              style: TextStyle(color: cs.onSurfaceVariant, fontSize: 13),
            ),
            const SizedBox(height: 12),
            Row(children: [
              const Icon(Icons.brightness_3, size: 20),
              Expanded(
                child: Slider(
                  value: brightness.clamp(
                      1.0 - ScreenDimNotifier.maxDim, 1.0),
                  min: 1.0 - ScreenDimNotifier.maxDim,
                  max: 1.0,
                  onChanged: (v) =>
                      ref.read(screenDimProvider.notifier).set(1.0 - v),
                ),
              ),
              const Icon(Icons.brightness_5, size: 20),
            ]),
          ],
        ),
      ),
    );
  }
}
