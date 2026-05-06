import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/extensions/context_extensions.dart';
import 'package:nigerian_mushaf_app/mushaf/mushaf_page.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_scroll_ctrl_provider.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_view_settings_provider.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_rail_bar.dart';

/// Main reading view: 480-page [PageView] with configurable scroll direction
/// and navigation mode (swipe gesture vs. tap-zone slide).
class MushafListViewBuilder extends ConsumerStatefulWidget {
  const MushafListViewBuilder({super.key});

  @override
  ConsumerState<MushafListViewBuilder> createState() =>
      _MushafListViewBuilderState();
}

class _MushafListViewBuilderState
    extends ConsumerState<MushafListViewBuilder> {
  OverlayEntry? _overlay;

  void _toggleOverlay(BuildContext context) {
    if (_overlay != null) {
      _removeOverlay();
      return;
    }
    _overlay = context.insertOverlay(
      onTapOutside: _removeOverlay,
      children: [
        NavRailBar(removeOverlay: _removeOverlay),
      ],
    );
  }

  void _removeOverlay() {
    if (_overlay != null) {
      context.removeOverlayEntry(_overlay);
      _overlay = null;
    }
  }

  void _goToPrev() {
    final ctrl = ref.read(mushafScrollCtrlProvider);
    if (ctrl.hasClients) {
      ctrl.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToNext() {
    final ctrl = ref.read(mushafScrollCtrlProvider);
    if (ctrl.hasClients) {
      ctrl.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final pageCtrl = ref.watch(mushafScrollCtrlProvider);
    final viewSettings = ref.watch(mushafViewSettingsProvider);
    final isSlide = viewSettings.isSlideMode;
    final direction = viewSettings.scrollDirection;

    return Stack(
      children: [
        // ── PageView ──────────────────────────────────────────────────────────
        PageView.builder(
          controller: pageCtrl,
          scrollDirection: direction,
          // In slide mode, disable the swipe gesture so taps register cleanly.
          physics: isSlide
              ? const NeverScrollableScrollPhysics()
              : const PageScrollPhysics(),
          itemCount: 480,
          itemBuilder: (context, index) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _toggleOverlay(context),
              child: MushafPage(index: index),
            );
          },
        ),

        // ── Slide-mode tap zones ──────────────────────────────────────────────
        if (isSlide) ...[
          // Left / top zone → previous page
          Positioned.fill(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: _goToPrev,
                  ),
                ),
                // Centre zone opens the nav rail
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => _toggleOverlay(context),
                  ),
                ),
                // Right / bottom zone → next page
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: _goToNext,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
