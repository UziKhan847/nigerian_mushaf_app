import 'package:flutter/material.dart';
import 'package:nigerian_mushaf_app/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_rail_button.dart';
import 'package:nigerian_mushaf_app/providers/is_zoomed_provider.dart';

class ZoomPageItem extends ConsumerWidget {
  const ZoomPageItem({super.key, required this.removeOverlay});
  final VoidCallback removeOverlay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isZoom = ref.watch(isZoomedInProvider);
    return NavRailButton(
      icon: isZoom ? Icons.zoom_out_rounded : Icons.zoom_in_rounded,
      label: isZoom
          ? AppLocalizations.of(context).navExitZoom
          : AppLocalizations.of(context).navZoomPage,
      isActive: isZoom,
      onPressed: () {
        if (isZoom) {
          ref.read(isZoomedInProvider.notifier).setZoomed(false);
          removeOverlay();
        } else {
          removeOverlay();
          ref.read(isZoomedInProvider.notifier).setZoomed(true);
        }
      },
    );
  }
}
