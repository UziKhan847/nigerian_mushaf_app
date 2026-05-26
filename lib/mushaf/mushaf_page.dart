import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/my_themes.dart';
import 'package:nigerian_mushaf_app/providers/is_zoomed_provider.dart';
import 'package:nigerian_mushaf_app/data/mushaf_index_data.dart';
import 'package:nigerian_mushaf_app/providers/theme_provider.dart';

const double _kImageW      = 1930;
const double _kImageH      = 2480;
const double _kImageAspect = _kImageW / _kImageH;

/// Shared mushaf page-header height, used by the page layout and the
/// landscape-vertical ListView itemExtent so they stay in sync.
const double kMushafHeaderHeight = 32.0;

class MushafPage extends ConsumerStatefulWidget {
  const MushafPage({
    super.key,
    required this.index,
    this.landscapeZoom      = false,
    this.ninetyPercentWidth = false,
  });
  final int index;
  final bool landscapeZoom;
  final bool ninetyPercentWidth;

  @override
  ConsumerState<MushafPage> createState() => _MushafPageState();
}

class _MushafPageState extends ConsumerState<MushafPage> {
  final _transformCtrl = TransformationController();

  @override
  void dispose() {
    _transformCtrl.dispose();
    super.dispose();
  }

  void _resetZoom() => _transformCtrl.value = Matrix4.identity();

  /// Target decode width in physical pixels. The source PNGs are 1930 px wide
  /// but render into roughly the screen width, so decoding at screen-width ×
  /// devicePixelRatio (capped at the source width) cuts memory dramatically on
  /// phones without any visible quality loss. Computed from MediaQuery so the
  /// display and precache cache keys match (precache stays effective).
  int _decodeWidth(BuildContext context) {
    final mq = MediaQuery.of(context);
    final px = (mq.size.width * mq.devicePixelRatio).round();
    return px.clamp(1, _kImageW.toInt());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Precache adjacent pages so a swipe doesn't flash the loading spinner.
    _precache(widget.index - 1);
    _precache(widget.index + 1);
  }

  void _precache(int i) {
    if (i < 0 || i >= 604) return;
    final n = i + 1;
    final w = _decodeWidth(context);
    // ResizeImage with the same width as the displayed Image.asset(cacheWidth:)
    // so both share one cache entry.
    precacheImage(
        ResizeImage(AssetImage('assets/pages/content/$n.png'), width: w), context);
    precacheImage(
        ResizeImage(AssetImage('assets/pages/borders/$n.png'), width: w), context);
  }

  // ── Two-layer image ────────────────────────────────────────────────────────
  Widget _layeredImage(ThemeState ts, double w, double h) {
    final n       = widget.index + 1;
    final filter  = MyThemes.pageColorFilter(ts.appTheme, ts.customBgColor);
    final decodeW = _decodeWidth(context);

    Widget content = Image.asset('assets/pages/content/$n.png',
        fit: BoxFit.fill, filterQuality: FilterQuality.medium,
        cacheWidth: decodeW, frameBuilder: _frameBuilder);
    if (filter != null) content = ColorFiltered(colorFilter: filter, child: content);

    final border = Image.asset('assets/pages/borders/$n.png',
        fit: BoxFit.fill, filterQuality: FilterQuality.medium,
        cacheWidth: decodeW);

    return SizedBox(
      width: w, height: h,
      child: Stack(fit: StackFit.expand, children: [content, border]),
    );
  }

  static Widget _frameBuilder(BuildContext c, Widget child, int? f, bool s) {
    if (s || f != null) return child;
    return const Center(child: CircularProgressIndicator(strokeWidth: 1.5));
  }

  @override
  Widget build(BuildContext context) {
    final ts       = ref.watch(themeProvider);
    final zoomMode = ref.watch(isZoomedInProvider);
    final bgColor  = MyThemes.pageBackgroundColor(ts.appTheme, ts.customBgColor);

    // When zoom mode is deactivated externally (button / double-tap on another
    // page), reset this page's transform back to identity.
    ref.listen(isZoomedInProvider, (_, active) {
      if (!active) _resetZoom();
    });

    return Container(
      color: bgColor,
      child: LayoutBuilder(
        builder: (_, c) {
          final W = c.maxWidth, H = c.maxHeight;
          const hH = kMushafHeaderHeight;

          double imgW, imgH;
          if (widget.landscapeZoom || widget.ninetyPercentWidth) {
            imgW = W * 0.90;
            imgH = imgW / _kImageAspect;
          } else {
            final availH = H - hH;
            if (availH > 0 && W > 0) {
              if (W / availH > _kImageAspect) { imgH = availH; imgW = availH * _kImageAspect; }
              else                            { imgW = W;      imgH = W / _kImageAspect; }
            } else {
              imgW = W; imgH = W / _kImageAspect;
            }
          }

          final image = _layeredImage(ts, imgW, imgH);
          final header =
              _MushafPageHeaderBar(index: widget.index, themeState: ts, imageWidth: imgW);

          // Zoom mode (activated via the Zoom nav item only): header stays
          // fixed on top, the image below is pinch/Ctrl-scroll zoomable. The
          // outer scroll is already locked by the view builder, so the
          // InteractiveViewer owns all gestures; double-tap resets + exits.
          if (zoomMode) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                header,
                Expanded(
                  child: GestureDetector(
                    onDoubleTap: () {
                      _resetZoom();
                      ref.read(isZoomedInProvider.notifier).setZoomed(false);
                    },
                    child: InteractiveViewer(
                      transformationController: _transformCtrl,
                      minScale: 1.0,
                      maxScale: 5.0,
                      panEnabled: true,
                      boundaryMargin: EdgeInsets.zero,
                      child: Center(child: image),
                    ),
                  ),
                ),
              ],
            );
          }

          // Landscape-horizontal: header fixed, tall 90 %-width image scrolls
          // vertically inside (outer PageView scrolls horizontally).
          if (widget.landscapeZoom) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                header,
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Center(child: image),
                  ),
                ),
              ],
            );
          }

          // ListView tall-item mode: header + image fill the fixed itemExtent.
          if (widget.ninetyPercentWidth) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [header, image],
            );
          }

          // Normal fit: the header sits DIRECTLY above the image and the whole
          // block is centred — so the header is never pinned to the screen top.
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [header, image],
            ),
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// LandscapeVerticalPage — landscape + vertical + SWIPE mode.
// The page is zoomed (90 % width, taller than the screen) and scrolls inside
// its own SingleChildScrollView. Overscrolling past the bottom advances to the
// next page; past the top goes to the previous page (the host animates the
// outer PageView). This is the per-page "scroll then swipe" behaviour.
// ─────────────────────────────────────────────────────────────────────────────

class LandscapeVerticalPage extends StatefulWidget {
  const LandscapeVerticalPage({
    super.key,
    required this.index,
    required this.onPrevPage,
    required this.onNextPage,
  });
  final int index;
  final VoidCallback onPrevPage, onNextPage;

  @override
  State<LandscapeVerticalPage> createState() => _LVPState();
}

class _LVPState extends State<LandscapeVerticalPage> {
  final _sc = ScrollController();
  bool _lock = false;

  @override
  void dispose() { _sc.dispose(); super.dispose(); }

  void _onUpdate(ScrollUpdateNotification n) {
    if (_lock) return;
    final px = n.metrics.pixels, max = n.metrics.maxScrollExtent;
    if (px < -55) {
      _trigger(widget.onPrevPage);
    } else if (max > 0 && px > max + 55) {
      _trigger(widget.onNextPage);
    }
  }

  void _trigger(VoidCallback nav) {
    _lock = true;
    _sc.jumpTo(_sc.position.pixels.clamp(0.0, _sc.position.maxScrollExtent));
    nav();
    Future.delayed(const Duration(milliseconds: 600),
        () { if (mounted) _lock = false; });
  }

  @override
  Widget build(BuildContext context) {
    final mq   = MediaQuery.of(context);
    final imgW = mq.size.width * 0.90;
    final imgH = imgW / _kImageAspect;
    final decodeW =
        (mq.size.width * mq.devicePixelRatio).round().clamp(1, _kImageW.toInt());

    return Consumer(builder: (_, ref, _) {
      final ts      = ref.watch(themeProvider);
      final bgColor = MyThemes.pageBackgroundColor(ts.appTheme, ts.customBgColor);
      final filter  = MyThemes.pageColorFilter(ts.appTheme, ts.customBgColor);
      final n = widget.index + 1;

      Widget content = Image.asset('assets/pages/content/$n.png',
          fit: BoxFit.fill, filterQuality: FilterQuality.medium, cacheWidth: decodeW);
      if (filter != null) content = ColorFiltered(colorFilter: filter, child: content);
      final border = Image.asset('assets/pages/borders/$n.png',
          fit: BoxFit.fill, filterQuality: FilterQuality.medium, cacheWidth: decodeW);

      final pageImage = SizedBox(
        width: imgW, height: imgH,
        child: Stack(fit: StackFit.expand, children: [content, border]),
      );

      return Container(
        color: bgColor,
        child: Column(children: [
          _MushafPageHeaderBar(index: widget.index, themeState: ts, imageWidth: imgW),
          Expanded(
            child: NotificationListener<ScrollUpdateNotification>(
              onNotification: (n) { _onUpdate(n); return false; },
              child: SingleChildScrollView(
                controller: _sc,
                physics: const BouncingScrollPhysics(),
                child: Center(child: pageImage),
              ),
            ),
          ),
        ]),
      );
    });
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Header: Surah name (left) + Juz number (right), both Arabic, Ruwudu font.
//   left  → سُورَة <arabic surah name>
//   right → جُزْء <arabic-indic juz number>
// ─────────────────────────────────────────────────────────────────────────────

class _MushafPageHeaderBar extends StatelessWidget {
  const _MushafPageHeaderBar({
    required this.index,
    required this.themeState,
    required this.imageWidth,
  });
  final int index;
  final ThemeState themeState;
  final double imageWidth;

  @override
  Widget build(BuildContext context) {
    final page  = index + 1;
    final surah = surahNameArForPage(page);
    final juz   = juzForPage(page);
    final ink   = MyThemes.pageHeaderInkColor(
        themeState.appTheme, themeState.customBgColor);

    // Scale the font with the page width so dual-page (narrow) spreads don't
    // get an oversized header relative to the small pages.
    final fontSize = (imageWidth * 0.042).clamp(10.0, 17.0);
    final style = TextStyle(
      fontFamily: 'Ruwudu',
      fontSize: fontSize,
      color: ink,
      fontWeight: FontWeight.w700,
      height: 1.0,
    );

    return SizedBox(
      height: kMushafHeaderHeight,
      child: Center(
        child: SizedBox(
          width: imageWidth * 0.92,
          child: Stack(alignment: Alignment.center, children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text('سُورَة $surah',
                  textDirection: TextDirection.rtl,
                  style: style,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text('جُزْء ${toArabicDigits(juz)}',
                  textDirection: TextDirection.rtl,
                  style: style,
                  maxLines: 1),
            ),
          ]),
        ),
      ),
    );
  }
}
