import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Routes navigation to whichever scroll widget is active.
///
/// Two layouts exist:
///   • PageView  — every mode except landscape-vertical-single. Items are
///     viewport-sized; jumpToPage uses a page index (spread index when dual).
///   • ListView  — landscape-vertical-single only. Items are TALL (90 % width,
///     ~screen-height × image-aspect), so the page is zoomed in and the list
///     scrolls continuously through pages. Navigation uses a pixel offset
///     (mushafPageIndex × itemExtent).
class MushafControllerRegistry {
  PageController?   pageController;
  ScrollController? listController;

  bool   isDualPage = false;
  bool   useList    = false; // true → landscape-vertical-single (ListView)
  double itemExtent = 0;     // tall item height, used for ListView math

  void jumpToPage(int mushafPageIndex) {
    final i = mushafPageIndex.clamp(0, 603);
    if (useList) {
      final lc = listController;
      if (lc != null && lc.hasClients && itemExtent > 0) {
        final target = (i * itemExtent)
            .clamp(0.0, lc.position.maxScrollExtent);
        lc.jumpTo(target);
      }
    } else {
      final pc = pageController;
      if (pc != null && pc.hasClients) {
        pc.jumpToPage(isDualPage ? i ~/ 2 : i);
      }
    }
  }

  int get currentPage {
    if (useList) {
      final lc = listController;
      if (lc != null && lc.hasClients && itemExtent > 0) {
        return (lc.offset / itemExtent).round().clamp(0, 603);
      }
    } else {
      final pc = pageController;
      if (pc != null && pc.hasClients) {
        final vi = pc.page?.round() ?? 0;
        return isDualPage ? vi * 2 : vi;
      }
    }
    return 0;
  }
}

final mushafControllerRegistryProvider =
    Provider<MushafControllerRegistry>((_) => MushafControllerRegistry());
