import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Shared mutable holder for whichever controllers are active.
/// Registered by [MushafListViewBuilder] on initState; read by
/// [mushafNavigateProvider] and mode-switch logic.
class MushafControllerRegistry {
  PageController?   pageController;
  ScrollController? listController;
  double itemExtent = 0;
  bool   isSlideMode     = false;
  bool   isDualPage      = false;

  // ── Navigation ────────────────────────────────────────────────────────────

  void jumpToPage(int mushafPageIndex) {
    if (isSlideMode) {
      _jumpList(mushafPageIndex);
    } else {
      _jumpPageView(mushafPageIndex);
    }
  }

  void _jumpPageView(int mushafPageIndex) {
    final ctrl = pageController;
    if (ctrl == null || !ctrl.hasClients) return;
    // In dual-page mode each PageView item is a 2-page spread.
    final viewIndex = isDualPage ? mushafPageIndex ~/ 2 : mushafPageIndex;
    ctrl.jumpToPage(viewIndex);
  }

  void _jumpList(int mushafPageIndex) {
    final ctrl = listController;
    if (ctrl == null || !ctrl.hasClients || itemExtent <= 0) return;
    // In dual-page mode each list item is also a 2-page spread.
    final itemIndex = isDualPage ? mushafPageIndex ~/ 2 : mushafPageIndex;
    ctrl.jumpTo(
      (itemIndex * itemExtent).clamp(0.0, ctrl.position.maxScrollExtent),
    );
  }

  // ── Current page (always returns a single-page mushaf index) ──────────────

  int get currentPage {
    if (isSlideMode) {
      final ctrl = listController;
      if (ctrl != null && ctrl.hasClients && itemExtent > 0) {
        final itemIndex = (ctrl.offset / itemExtent).round();
        return isDualPage ? itemIndex * 2 : itemIndex;
      }
    } else {
      final ctrl = pageController;
      if (ctrl != null && ctrl.hasClients) {
        final viewIndex = ctrl.page?.round() ?? 0;
        return isDualPage ? viewIndex * 2 : viewIndex;
      }
    }
    return 0;
  }
}

final mushafControllerRegistryProvider = Provider<MushafControllerRegistry>(
  (_) => MushafControllerRegistry(),
);
