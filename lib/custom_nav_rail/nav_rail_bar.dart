import 'package:flutter/material.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_items/about_item.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_items/page_index_item.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_items/search_item.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_items/surah_index_item.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_items/verse_index_item.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_items/theme_item.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_items/scroll_direction_item.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_items/page_mode_item.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_items/bg_color_item.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_items/dual_page_item.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_items/zoom_page_item.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_items/bookmarks_item.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_items/brightness_item.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_items/language_item.dart';

/// Slides in from the right on insert and slides back out on dismiss.
///
/// The host holds a [GlobalKey]<[NavRailBarState]> and calls [animateOut]
/// (passing the real OverlayEntry removal) so the exit animation completes
/// before the entry is removed.
class NavRailBar extends StatefulWidget {
  const NavRailBar({super.key, required this.removeOverlay});

  /// Triggers an animated dismiss (see host wiring).
  final VoidCallback removeOverlay;

  @override
  State<NavRailBar> createState() => NavRailBarState();
}

class NavRailBarState extends State<NavRailBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<Offset> _slide;
  late final Animation<double> _fade;
  bool _out = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 240),
    );
    _slide = Tween(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _ctrl.forward();
  }

  /// Reverse the entry animation, then run [onDone] (the real removal).
  void animateOut(VoidCallback onDone) {
    if (_out) return;
    _out = true;
    _ctrl.reverse().whenComplete(onDone);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final railBg = isDark ? cs.surfaceContainerHigh : cs.surfaceContainerLowest;
    final close = widget.removeOverlay;

    return Align(
      alignment: Alignment.centerRight,
      child: SlideTransition(
        position: _slide,
        child: FadeTransition(
          opacity: _fade,
          child: IntrinsicWidth(
            child: Container(
              decoration: BoxDecoration(
                color: railBg,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(50),
                    blurRadius: 12,
                    offset: const Offset(-2, 0),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SearchItem(removeOverlay: close),
                    _divider(),
                    PageIndexItem(removeOverlay: close),
                    SurahIndexItem(removeOverlay: close),
                    VerseIndexItem(removeOverlay: close),
                    BookmarksItem(removeOverlay: close),
                    _divider(),
                    ThemeItem(removeOverlay: close),
                    BgColorItem(removeOverlay: close),
                    BrightnessItem(removeOverlay: close),
                    LanguageItem(removeOverlay: close),
                    _divider(),
                    ScrollDirectionItem(),
                    PageModeItem(),
                    DualPageItem(),
                    ZoomPageItem(removeOverlay: close),
                    _divider(),
                    AboutItem(removeOverlay: close),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _divider() => const Padding(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    child: Divider(height: 1, thickness: 0.5),
  );
}
