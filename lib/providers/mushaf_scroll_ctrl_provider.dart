import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ── Swipe mode: PageController ────────────────────────────────────────────────
//
// The PageView in MushafListViewBuilder watches this provider directly, so that
// navigation tiles (which call mushafScrollCtrlProvider.notifier.jumpToPage)
// and the visible PageView share the *same* controller instance.
//
// Previously, the view builder created a local _pageCtrl that was detached from
// the provider — calling jumpToPage on the provider did nothing visible.

final mushafPageCtrlProvider =
    NotifierProvider<MushafPageCtrlNotifier, PageController>(
  MushafPageCtrlNotifier.new,
);

class MushafPageCtrlNotifier extends Notifier<PageController> {
  @override
  PageController build() => PageController();

  /// Jump instantly to [pageIndex] (0-based).
  void jumpToPage(int pageIndex, [double ignored = 0]) {
    if (state.hasClients) state.jumpToPage(pageIndex);
  }

  /// Recreate the controller with [initialPage] so the first rendered frame
  /// of a rebuilt PageView already shows the right page — no flash to page 0.
  void reset(int initialPage) {
    final old = state;
    state = PageController(initialPage: initialPage.clamp(0, 603));
    // Dispose on the next microtask so the widget tree detaches first.
    Future.microtask(old.dispose);
  }

  int get currentPage =>
      (state.hasClients && state.page != null) ? state.page!.round() : 0;
}

// Legacy alias — original tiles call mushafScrollCtrlProvider.notifier.jumpToPage.
final mushafScrollCtrlProvider = mushafPageCtrlProvider;

// ── Slide mode: ScrollController ─────────────────────────────────────────────
//
// Kept in a separate provider so mushafNavigateProvider can reach it.

final mushafListScrollCtrlProvider =
    NotifierProvider<MushafListScrollCtrlNotifier, ScrollController>(
  MushafListScrollCtrlNotifier.new,
);

class MushafListScrollCtrlNotifier extends Notifier<ScrollController> {
  @override
  ScrollController build() => ScrollController();

  void jumpToPage(int pageIndex, double extent) {
    if (!state.hasClients) return;
    state.jumpTo(
      (pageIndex * extent).clamp(0.0, state.position.maxScrollExtent),
    );
  }
}
