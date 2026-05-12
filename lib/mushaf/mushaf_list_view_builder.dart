import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/extensions/context_extensions.dart';
import 'package:nigerian_mushaf_app/mushaf/mushaf_page.dart';
import 'package:nigerian_mushaf_app/providers/is_zoomed_provider.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_controller_registry.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_scroll_ctrl_provider.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_view_settings_provider.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_rail_bar.dart';

const _kTotalPages = 604;

class MushafListViewBuilder extends ConsumerStatefulWidget {
  const MushafListViewBuilder({super.key});

  @override
  ConsumerState<MushafListViewBuilder> createState() =>
      _MushafListViewBuilderState();
}

class _MushafListViewBuilderState
    extends ConsumerState<MushafListViewBuilder> {
  ScrollController _listCtrl = ScrollController();
  OverlayEntry? _overlay;

  @override
  void initState() {
    super.initState();
    _registerRegistry();
    // Reset zoom state whenever the visible page changes.
    ref.read(mushafPageCtrlProvider).addListener(_onPageChange);
  }

  @override
  void dispose() {
    _listCtrl.dispose();
    super.dispose();
  }

  void _onPageChange() {
    if (ref.read(isZoomedInProvider)) {
      ref.read(isZoomedInProvider.notifier).setZoomed(false);
    }
  }

  void _registerRegistry() {
    final reg = ref.read(mushafControllerRegistryProvider);
    reg.pageController = ref.read(mushafPageCtrlProvider);
    reg.listController = _listCtrl;
    final s = ref.read(mushafViewSettingsProvider);
    reg.isSlideMode = s.isSlideMode;
    reg.isDualPage  = s.isDualPageEnabled;
  }

  // ── Overlay ────────────────────────────────────────────────────────────────

  void _toggleOverlay() {
    if (_overlay != null) { _removeOverlay(); return; }
    _overlay = context.insertOverlay(
      onTapOutside: _removeOverlay,
      children: [NavRailBar(removeOverlay: _removeOverlay)],
    );
  }

  void _removeOverlay() {
    if (_overlay != null) {
      context.removeOverlayEntry(_overlay);
      _overlay = null;
    }
  }

  // ── Page navigation helpers ────────────────────────────────────────────────

  void _goToPrevPage() {
    final ctrl = ref.read(mushafPageCtrlProvider);
    if (ctrl.hasClients) {
      ctrl.previousPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToNextPage() {
    final ctrl = ref.read(mushafPageCtrlProvider);
    if (ctrl.hasClients) {
      ctrl.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  // ── Dual-page ──────────────────────────────────────────────────────────────

  bool _resolveIsDual(MushafViewSettings s) => s.isDualPageEnabled;

  // ── Smooth mode switch ─────────────────────────────────────────────────────

  void _onSettingsChanged(MushafViewSettings next) {
    final reg    = ref.read(mushafControllerRegistryProvider);
    final saved  = reg.currentPage;
    final isDual = _resolveIsDual(next);
    final spread = isDual ? saved ~/ 2 : saved;
    final size   = MediaQuery.of(context).size;
    final extent = next.scrollDirection == Axis.vertical
        ? size.height : size.width;

    if (next.isSlideMode) {
      setState(() {
        _listCtrl.dispose();
        _listCtrl = ScrollController(
          initialScrollOffset: (spread * extent).clamp(0.0, double.maxFinite),
        );
        reg.listController = _listCtrl;
        reg.pageController = ref.read(mushafPageCtrlProvider);
        reg.itemExtent  = extent;
        reg.isSlideMode = true;
        reg.isDualPage  = isDual;
      });
    } else {
      ref.read(mushafPageCtrlProvider.notifier).reset(spread);
      setState(() {
        reg.pageController = ref.read(mushafPageCtrlProvider);
        reg.itemExtent  = extent;
        reg.isSlideMode = false;
        reg.isDualPage  = isDual;
      });
    }
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final s          = ref.watch(mushafViewSettingsProvider);
    final isZoomedIn = ref.watch(isZoomedInProvider);
    final size       = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;

    ref.listen(mushafViewSettingsProvider, (prev, next) {
      if (prev == null) return;
      final changed =
          prev.isSlideMode       != next.isSlideMode       ||
          prev.scrollDirection   != next.scrollDirection   ||
          prev.isDualPageEnabled != next.isDualPageEnabled;
      if (changed) _onSettingsChanged(next);
    });

    final isDual = _resolveIsDual(s);

    // Landscape horizontal zoom: 90 % width, internal vertical scroll.
    final landscapeHorizZoom =
        isLandscape && !isDual && s.scrollDirection == Axis.horizontal;

    // Landscape vertical swipe zoom: per-page internal scroll with edge nav.
    // Only in PageView (swipe) mode.
    final landscapeVertZoom =
        isLandscape && !isDual &&
        s.scrollDirection == Axis.vertical &&
        !s.isSlideMode;

    // Landscape vertical slide zoom: 90 % width, outer ListView scrolls.
    final landscapeVertSlideZoom =
        isLandscape && !isDual &&
        s.scrollDirection == Axis.vertical &&
        s.isSlideMode;

    final extent = s.scrollDirection == Axis.vertical ? size.height : size.width;
    final double itemExtent;
    if (landscapeVertSlideZoom) {
      // Each item must be tall enough for the full 90%-width image.
      itemExtent = size.width * 0.90 * (2480.0 / 1930.0) + 28;
    } else {
      itemExtent = extent;
    }

    final totalItems = isDual ? (_kTotalPages / 2).ceil() : _kTotalPages;

    final reg = ref.read(mushafControllerRegistryProvider);
    reg.pageController = ref.read(mushafPageCtrlProvider);
    reg.listController = _listCtrl;
    reg.itemExtent     = itemExtent;
    reg.isSlideMode    = s.isSlideMode;
    reg.isDualPage     = isDual;

    // ── Item builder ─────────────────────────────────────────────────────────
    Widget makeItem(BuildContext ctx, int viewIndex) {
      Widget content;

      if (isDual) {
        content = _SpreadPage(spreadIndex: viewIndex);
      } else if (landscapeVertZoom) {
        // Per-page vertical scrolling with overscroll page navigation.
        content = LandscapeVerticalPage(
          index: viewIndex,
          onPrevPage: _goToPrevPage,
          onNextPage: _goToNextPage,
        );
      } else {
        content = MushafPage(
          index: viewIndex,
          landscapeZoom: landscapeHorizZoom,
          ninetyPercentWidth: landscapeVertSlideZoom,
        );
      }

      // Tap opens nav rail (not for LandscapeVerticalPage which handles its own scroll).
      if (!landscapeVertZoom) {
        content = GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _toggleOverlay,
          child: content,
        );
      } else {
        content = GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: _toggleOverlay,
          child: content,
        );
      }

      return content;
    }

    // ── Scroll physics ────────────────────────────────────────────────────────
    // Disable outer scroll when:
    //   1. User is pinch-zoomed in (inner pan handles movement), OR
    //   2. Landscape vertical zoom mode (inner SingleChildScrollView handles scroll).
    final disableOuterScroll = isZoomedIn || landscapeVertZoom;

    Widget scrollWidget;

    if (s.isSlideMode) {
      scrollWidget = ListView.builder(
        controller:      _listCtrl,
        scrollDirection: s.scrollDirection,
        itemCount:       totalItems,
        itemExtent:      itemExtent,
        physics:         disableOuterScroll
            ? const NeverScrollableScrollPhysics()
            : null,
        itemBuilder:     makeItem,
      );
    } else {
      final pageCtrl = ref.watch(mushafPageCtrlProvider);
      scrollWidget = PageView.builder(
        controller:      pageCtrl,
        scrollDirection: s.scrollDirection,
        physics:         disableOuterScroll
            ? const NeverScrollableScrollPhysics()
            : const PageScrollPhysics(),
        itemCount:       totalItems,
        itemBuilder:     makeItem,
      );
    }

    if (s.scrollDirection == Axis.horizontal) {
      scrollWidget = Directionality(
        textDirection: TextDirection.rtl,
        child: scrollWidget,
      );
    }

    // ── Floating zoom navigation ──────────────────────────────────────────────
    // When pinch-zoomed in, the swipe gesture is consumed by InteractiveViewer.
    // Show explicit prev/next buttons so the user can still navigate pages.
    if (!isZoomedIn) return scrollWidget;

    return Stack(
      children: [
        scrollWidget,
        Positioned(
          right: 16,
          bottom: 40,
          child: _ZoomNavButtons(
            onPrev: _goToPrevPage,
            onNext: _goToNextPage,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Dual-page spread
// ─────────────────────────────────────────────────────────────────────────────

class _SpreadPage extends StatelessWidget {
  const _SpreadPage({required this.spreadIndex});
  final int spreadIndex;

  @override
  Widget build(BuildContext context) {
    final rightIndex = spreadIndex * 2;
    final leftIndex  = spreadIndex * 2 + 1;
    return Row(
      textDirection: TextDirection.ltr,
      children: [
        Expanded(
          child: leftIndex < _kTotalPages
              ? MushafPage(index: leftIndex)
              : const SizedBox.shrink(),
        ),
        Expanded(child: MushafPage(index: rightIndex)),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Floating prev/next buttons shown when pinch-zoomed in
// ─────────────────────────────────────────────────────────────────────────────

class _ZoomNavButtons extends StatelessWidget {
  const _ZoomNavButtons({required this.onPrev, required this.onNext});
  final VoidCallback onPrev;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: cs.surface.withAlpha(220),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(60),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_upward_rounded),
            tooltip: 'Previous page',
            onPressed: onPrev,
          ),
          Divider(height: 1, thickness: 0.5, color: cs.outlineVariant),
          IconButton(
            icon: const Icon(Icons.arrow_downward_rounded),
            tooltip: 'Next page',
            onPressed: onNext,
          ),
        ],
      ),
    );
  }
}
