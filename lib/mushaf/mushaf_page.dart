import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/mushaf/mushaf_dark_image.dart';
import 'package:nigerian_mushaf_app/my_themes.dart';
import 'package:nigerian_mushaf_app/providers/is_zoomed_provider.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_pages_header_provider.dart';
import 'package:nigerian_mushaf_app/providers/theme_provider.dart';

const double _kImageW = 1930;
const double _kImageH = 2480;
const double _kImageAspect = _kImageW / _kImageH; // ≈ 0.778

// ─────────────────────────────────────────────────────────────────────────────
// MushafPage
// ─────────────────────────────────────────────────────────────────────────────

class MushafPage extends ConsumerStatefulWidget {
  const MushafPage({
    super.key,
    required this.index,
    this.landscapeZoom = false,
    this.ninetyPercentWidth = false,
  });

  final int index;

  /// Horizontal landscape: 90 % width with an internal vertical
  /// [SingleChildScrollView] so the user can pan down the tall image.
  final bool landscapeZoom;

  /// Vertical slide-mode landscape: constrains width to 90 % of available
  /// space but does NOT add an inner scroll (the outer [ListView] scrolls).
  final bool ninetyPercentWidth;

  @override
  ConsumerState<MushafPage> createState() => _MushafPageState();
}

class _MushafPageState extends ConsumerState<MushafPage> {
  final _transformCtrl = TransformationController();
  bool _isZoomed = false;

  @override
  void initState() {
    super.initState();
    _transformCtrl.addListener(_onTransform);
  }

  @override
  void dispose() {
    _transformCtrl.removeListener(_onTransform);
    _transformCtrl.dispose();
    super.dispose();
  }

  void _onTransform() {
    final zoomed = _transformCtrl.value.getMaxScaleOnAxis() > 1.05;
    if (zoomed == _isZoomed) return;
    setState(() => _isZoomed = zoomed);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) ref.read(isZoomedInProvider.notifier).setZoomed(zoomed);
    });
  }

  // ── Image builder ─────────────────────────────────────────────────────────

  Widget _buildImage(ThemeState themeState, BoxFit fit) {
    final assetPath = 'assets/pngs/${widget.index + 1}.png';

    // Dark mode: use the GLSL fragment shader that converts ONLY near-black
    // pixels to warm white, leaving all other colours (red, teal, orange…)
    // completely unchanged.  This cannot be achieved with a ColorFilter matrix
    // because matrix transforms are linear and cannot threshold on luminance.
    if (themeState.appTheme == AppTheme.dark) {
      return MushafDarkImage(assetPath: assetPath, fit: fit);
    }

    // All other themes: apply the appropriate ColorFilter (or none for Light).
    final filter = MyThemes.pageColorFilter(
      themeState.appTheme,
      themeState.customBgColor,
    );

    Widget img = Image.asset(
      assetPath,
      fit: fit,
      filterQuality: FilterQuality.medium,
      frameBuilder: (ctx, child, frame, sync) {
        if (sync || frame != null) return child;
        return const Center(child: CircularProgressIndicator(strokeWidth: 1.5));
      },
    );

    if (filter != null) img = ColorFiltered(colorFilter: filter, child: img);
    return img;
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final themeState = ref.watch(themeProvider);
    final bgColor = MyThemes.pageBackgroundColor(
      themeState.appTheme,
      themeState.customBgColor,
    );

    final fit = widget.landscapeZoom ? BoxFit.fitWidth : BoxFit.contain;
    final rawImage = _buildImage(themeState, fit);

    // Wrap in InteractiveViewer for pinch-to-zoom.
    // panEnabled is false at scale=1 so single-finger swipes reach the outer
    // PageView/ListView; it activates only when the user has zoomed in.
    final zoomable = InteractiveViewer(
      transformationController: _transformCtrl,
      minScale: 1.0,
      maxScale: 5.0,
      panEnabled: _isZoomed,
      boundaryMargin: EdgeInsets.zero,
      child: rawImage,
    );

    Widget pageBody;
    if (widget.landscapeZoom) {
      // Horizontal landscape: 90 % width + internal vertical scroll.
      pageBody = LayoutBuilder(
        builder: (_, c) => SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: SizedBox(width: c.maxWidth * 0.90, child: zoomable),
          ),
        ),
      );
    } else if (widget.ninetyPercentWidth) {
      // Vertical slide landscape: 90 % width, no inner scroll.
      pageBody = Center(
        child: FractionallySizedBox(widthFactor: 0.90, child: zoomable),
      );
    } else {
      pageBody = zoomable;
    }

    return Container(
      color: bgColor,
      child: LayoutBuilder(
        builder: (_, c) {
          final W = c.maxWidth;
          final H = c.maxHeight;
          final double imgW;
          if (widget.landscapeZoom || widget.ninetyPercentWidth) {
            imgW = W * 0.90;
          } else {
            const hH = 28.0;
            final imgH = H - hH;
            imgW = (imgH > 0 && W > 0)
                ? ((W / imgH > _kImageAspect) ? imgH * _kImageAspect : W)
                : W;
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _MushafPageHeaderBar(
                index: widget.index,
                themeState: themeState,
                imageWidth: imgW,
              ),
              Expanded(child: pageBody),
            ],
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// LandscapeVerticalPage
// ─────────────────────────────────────────────────────────────────────────────

class LandscapeVerticalPage extends StatefulWidget {
  const LandscapeVerticalPage({
    super.key,
    required this.index,
    required this.onPrevPage,
    required this.onNextPage,
  });

  final int index;
  final VoidCallback onPrevPage;
  final VoidCallback onNextPage;

  @override
  State<LandscapeVerticalPage> createState() => _LandscapeVerticalPageState();
}

class _LandscapeVerticalPageState extends State<LandscapeVerticalPage> {
  final _scrollCtrl = ScrollController();
  bool _edgeLock = false;

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _onScrollUpdate(ScrollUpdateNotification n) {
    if (_edgeLock) return;
    final px = n.metrics.pixels;
    final max = n.metrics.maxScrollExtent;
    if (px < -55) {
      _trigger(widget.onPrevPage);
    } else if (max > 0 && px > max + 55) {
      _trigger(widget.onNextPage);
    }
  }

  void _trigger(VoidCallback nav) {
    _edgeLock = true;
    _scrollCtrl.jumpTo(
      _scrollCtrl.position.pixels.clamp(
        0,
        _scrollCtrl.position.maxScrollExtent,
      ),
    );
    nav();
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) _edgeLock = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final imgW = MediaQuery.of(context).size.width * 0.90;

    return Consumer(
      builder: (context, ref, _) {
        final themeState = ref.watch(themeProvider);
        final bgColor = MyThemes.pageBackgroundColor(
          themeState.appTheme,
          themeState.customBgColor,
        );

        Widget img;
        if (themeState.appTheme == AppTheme.dark) {
          img = MushafDarkImage(
            assetPath: 'assets/pngs/${widget.index + 1}.png',
            fit: BoxFit.fitWidth,
          );
        } else {
          final filter = MyThemes.pageColorFilter(
            themeState.appTheme,
            themeState.customBgColor,
          );
          img = Image.asset(
            'assets/pngs/${widget.index + 1}.png',
            fit: BoxFit.fitWidth,
            filterQuality: FilterQuality.medium,
          );
          if (filter != null) {
            img = ColorFiltered(colorFilter: filter, child: img);
          }
        }

        return Container(
          color: bgColor,
          child: Column(
            children: [
              _MushafPageHeaderBar(
                index: widget.index,
                themeState: themeState,
                imageWidth: imgW,
              ),
              Expanded(
                child: NotificationListener<ScrollUpdateNotification>(
                  onNotification: (n) {
                    _onScrollUpdate(n);
                    return false;
                  },
                  child: SingleChildScrollView(
                    controller: _scrollCtrl,
                    physics: const BouncingScrollPhysics(),
                    child: Center(
                      child: SizedBox(width: imgW, child: img),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Header bar
// ─────────────────────────────────────────────────────────────────────────────

class _MushafPageHeaderBar extends ConsumerWidget {
  const _MushafPageHeaderBar({
    required this.index,
    required this.themeState,
    required this.imageWidth,
  });

  final int index;
  final ThemeState themeState;
  final double imageWidth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(mushafPgHeaderProvider)
        .when(
          loading: () => const SizedBox(height: 28),
          error: (_, _) => const SizedBox(height: 28),
          data: (headers) {
            if (headers == null ||
                index < 0 ||
                index >= headers.mushafPagesHeader.length) {
              return const SizedBox.shrink();
            }
            final h = headers.mushafPagesHeader[index];
            final ink = MyThemes.pageHeaderInkColor(
              themeState.appTheme,
              themeState.customBgColor,
            );
            final style = TextStyle(
              fontFamily: 'Nigerian',
              fontSize: 13,
              color: ink,
              fontWeight: FontWeight.w500,
              height: 1.0,
            );
            return SizedBox(
              height: 28,
              child: Center(
                child: SizedBox(
                  width: imageWidth * 0.85,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          h.numOfWaqf,
                          style: style,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Center(
                        child: Text(
                          h.hizbInfo,
                          style: style,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          h.surahName,
                          textDirection: TextDirection.rtl,
                          style: style,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
  }
}
