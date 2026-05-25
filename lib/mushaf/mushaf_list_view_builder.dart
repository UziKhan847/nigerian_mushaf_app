import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/extensions/context_extensions.dart';
import 'package:nigerian_mushaf_app/mushaf/mushaf_page.dart';
import 'package:nigerian_mushaf_app/providers/current_page_provider.dart';
import 'package:nigerian_mushaf_app/providers/is_zoomed_provider.dart';
import 'package:nigerian_mushaf_app/providers/screen_dim_provider.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_controller_registry.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_view_settings_provider.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_rail_bar.dart';

const _kTotalPages = 604;
const _kAspect = 2480.0 / 1930.0; // height / width

// Layouts:
//   page → PageView (portrait both, landscape-horizontal, dual). Scroll mode =
//          pageSnapping:false (smooth); Swipe = snapping.
//   list → landscape-vertical + Scroll. Tall 90 %-width items, continuous scroll.
//   edge → landscape-vertical + Swipe. Tall page scrolls inside itself; over-
//          scrolling at the bottom/top animates to the next/previous page.
enum _Layout { page, list, edge }

class MushafListViewBuilder extends ConsumerStatefulWidget {
  const MushafListViewBuilder({super.key});
  @override
  ConsumerState<MushafListViewBuilder> createState() => _State();
}

class _State extends ConsumerState<MushafListViewBuilder> {
  PageController? _pc;
  ScrollController? _lc;
  double _itemExtent = 0;
  String? _sig;

  OverlayEntry? _overlay;
  final GlobalKey<NavRailBarState> _navKey = GlobalKey<NavRailBarState>();

  @override
  void dispose() {
    _pc?.removeListener(_syncPage);
    _pc?.dispose();
    _lc?.removeListener(_syncList);
    _lc?.dispose();
    super.dispose();
  }

  // ── Source of truth sync ────────────────────────────────────────────────────
  void _syncPage() {
    final pc = _pc;
    if (pc == null || !pc.hasClients) return;
    final raw = pc.page?.round() ?? 0;
    final dual = ref.read(mushafControllerRegistryProvider).isDualPage;
    ref.read(currentMushafPageProvider.notifier).setPage(dual ? raw * 2 : raw);
  }

  void _syncList() {
    final lc = _lc;
    if (lc == null || !lc.hasClients || _itemExtent <= 0) return;
    final page = (lc.offset / _itemExtent).round().clamp(0, _kTotalPages - 1);
    ref.read(currentMushafPageProvider.notifier).setPage(page);
  }

  // ── Controller (re)creation keyed on layout signature ───────────────────────
  void _ensureControllers(
    _Layout layout,
    bool isDual,
    Axis axis,
    double itemExtent,
  ) {
    final sig = '$layout|$isDual|$axis';
    final reg = ref.read(mushafControllerRegistryProvider);
    final useList = layout == _Layout.list;
    _itemExtent = itemExtent;

    if (sig == _sig) {
      reg
        ..pageController = _pc
        ..listController = _lc
        ..isDualPage = isDual
        ..useList = useList
        ..itemExtent = itemExtent;
      return;
    }

    final page = ref.read(currentMushafPageProvider); // absolute, current
    _pc?.removeListener(_syncPage);
    _lc?.removeListener(_syncList);
    final oldPc = _pc, oldLc = _lc;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      oldPc?.dispose();
      oldLc?.dispose();
    });
    _pc = null;
    _lc = null;

    if (useList) {
      _lc = ScrollController(
        initialScrollOffset: (page * itemExtent).clamp(0.0, double.maxFinite),
      )..addListener(_syncList);
    } else {
      _pc = PageController(initialPage: isDual ? page ~/ 2 : page)
        ..addListener(_syncPage);
    }

    reg
      ..pageController = _pc
      ..listController = _lc
      ..isDualPage = isDual
      ..useList = useList
      ..itemExtent = itemExtent;
    _sig = sig;
  }

  // ── Animated overlay ────────────────────────────────────────────────────────
  void _toggleOverlay() {
    if (_overlay != null) {
      _dismissOverlay();
      return;
    }
    _overlay = context.insertOverlay(
      onTapOutside: _dismissOverlay,
      children: [NavRailBar(key: _navKey, removeOverlay: _dismissOverlay)],
    );
  }

  void _dismissOverlay() {
    final entry = _overlay;
    if (entry == null) return;
    void hardRemove() {
      context.removeOverlayEntry(entry);
      if (identical(_overlay, entry)) _overlay = null;
    }

    final st = _navKey.currentState;
    st != null ? st.animateOut(hardRemove) : hardRemove();
  }

  // ── Edge-nav (swipe) page stepping ──────────────────────────────────────────
  void _animTo(int delta) {
    final pc = _pc;
    if (pc == null || !pc.hasClients) return;
    delta < 0
        ? pc.previousPage(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
          )
        : pc.nextPage(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
          );
  }

  void _prev() => _step(-1);
  void _next() => _step(1);
  void _step(int delta) {
    final pc = _pc;
    if (pc != null && pc.hasClients) {
      _animTo(delta);
    } else {
      final cur = ref.read(currentMushafPageProvider);
      ref
          .read(mushafControllerRegistryProvider)
          .jumpToPage((cur + delta).clamp(0, _kTotalPages - 1));
    }
  }

  // ── Build ───────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final s = ref.watch(mushafViewSettingsProvider);
    final isZoom = ref.watch(isZoomedInProvider);
    final dim = ref.watch(screenDimProvider);
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;
    final isDual = s.isDualPageEnabled;
    final axis = s.scrollDirection;
    final scrollMode = s.isScrollMode;

    final landscapeVert = isLandscape && axis == Axis.vertical && !isDual;
    final _Layout layout = landscapeVert
        ? (scrollMode ? _Layout.list : _Layout.edge)
        : _Layout.page;

    final itemExtent = layout == _Layout.list
        ? (size.width * 0.90 * _kAspect + kMushafHeaderHeight)
        : 0.0;

    _ensureControllers(layout, isDual, axis, itemExtent);

    final landscapeHorizZoom =
        isLandscape && !isDual && axis == Axis.horizontal;
    final totalItems = isDual ? (_kTotalPages / 2).ceil() : _kTotalPages;

    Widget view;
    switch (layout) {
      case _Layout.list:
        view = ListView.builder(
          controller: _lc,
          itemExtent: itemExtent,
          itemCount: totalItems,
          physics: isZoom
              ? const NeverScrollableScrollPhysics()
              : const ClampingScrollPhysics(),
          itemBuilder: (ctx, vi) => GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _toggleOverlay,
            child: MushafPage(index: vi, ninetyPercentWidth: true),
          ),
        );
        break;

      case _Layout.edge:
        view = PageView.builder(
          controller: _pc,
          scrollDirection: Axis.vertical,
          physics:
              const NeverScrollableScrollPhysics(), // inner scroll drives nav
          itemCount: totalItems,
          itemBuilder: (ctx, vi) => GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _toggleOverlay,
            child: LandscapeVerticalPage(
              index: vi,
              onPrevPage: () => _animTo(-1),
              onNextPage: () => _animTo(1),
            ),
          ),
        );
        break;

      case _Layout.page:
        view = PageView.builder(
          controller: _pc,
          scrollDirection: axis,
          pageSnapping: !scrollMode || isZoom,
          physics: isZoom
              ? const NeverScrollableScrollPhysics()
              : (scrollMode
                    ? const ClampingScrollPhysics()
                    : const PageScrollPhysics()),
          itemCount: totalItems,
          itemBuilder: (ctx, vi) => GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _toggleOverlay,
            child: isDual
                ? _Spread(vi)
                : MushafPage(index: vi, landscapeZoom: landscapeHorizZoom),
          ),
        );
        if (axis == Axis.horizontal) {
          view = Directionality(textDirection: TextDirection.rtl, child: view);
        }
        break;
    }

    return Stack(
      children: [
        view,
        // In-app night-reading dim: a black overlay over the page only.
        // Placed above the page but below the zoom controls; IgnorePointer
        // lets taps reach the page (toggle nav rail).
        if (dim > 0.01)
          Positioned.fill(
            child: IgnorePointer(
              child: ColoredBox(
                color: Colors.black.withAlpha((dim * 255).round()),
              ),
            ),
          ),
        if (isZoom)
          if (axis == Axis.vertical)
            Positioned(
              right: 16,
              bottom: 40,
              child: _ZoomNav(
                axis: Axis.vertical,
                onPrev: _prev,
                onNext: _next,
                onExit: () =>
                    ref.read(isZoomedInProvider.notifier).setZoomed(false),
              ),
            )
          else
            Positioned(
              left: 0,
              right: 0,
              bottom: 24,
              child: Center(
                child: _ZoomNav(
                  axis: Axis.horizontal,
                  onPrev: _prev,
                  onNext: _next,
                  onExit: () =>
                      ref.read(isZoomedInProvider.notifier).setZoomed(false),
                ),
              ),
            ),
      ],
    );
  }
}

// ── Dual-page spread ──────────────────────────────────────────────────────────
class _Spread extends StatelessWidget {
  const _Spread(this.si);
  final int si;
  @override
  Widget build(BuildContext context) {
    final r = si * 2, l = si * 2 + 1;
    return Row(
      textDirection: TextDirection.ltr,
      children: [
        Expanded(
          child: l < _kTotalPages
              ? MushafPage(index: l)
              : const SizedBox.shrink(),
        ),
        Expanded(child: MushafPage(index: r)),
      ],
    );
  }
}

// ── Zoom floating nav ─────────────────────────────────────────────────────────
class _ZoomNav extends StatelessWidget {
  const _ZoomNav({
    required this.axis,
    required this.onPrev,
    required this.onNext,
    required this.onExit,
  });
  final Axis axis;
  final VoidCallback onPrev, onNext, onExit;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isV = axis == Axis.vertical;
    final prevIcon = isV
        ? Icons.arrow_upward_rounded
        : Icons.arrow_forward_rounded;
    final nextIcon = isV
        ? Icons.arrow_downward_rounded
        : Icons.arrow_back_rounded;

    Widget div() => isV
        ? Divider(height: 1, color: cs.outlineVariant)
        : VerticalDivider(width: 1, color: cs.outlineVariant);

    final children = <Widget>[
      IconButton(icon: Icon(nextIcon), onPressed: onNext),
      div(),
      IconButton(icon: const Icon(Icons.zoom_out_rounded), onPressed: onExit),
      div(),
      IconButton(icon: Icon(prevIcon), onPressed: onPrev),
    ];

    return Container(
      decoration: BoxDecoration(
        color: cs.surface.withAlpha(230),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(color: Colors.black.withAlpha(60), blurRadius: 8),
        ],
      ),
      child: isV
          ? IntrinsicWidth(
              child: Column(mainAxisSize: MainAxisSize.min, children: children),
            )
          : IntrinsicHeight(
              child: Row(mainAxisSize: MainAxisSize.min, children: children),
            ),
    );
  }
}
