import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mushafScrollCtrlProvider =
    NotifierProvider<MushafScrollCtrlProvider, PageController>(
      MushafScrollCtrlProvider.new,
    );

class MushafScrollCtrlProvider extends Notifier<PageController> {
  @override
  PageController build() => PageController();

  /// Instantly jump to [pageIndex] (0-based) with no animation.
  void jumpToPage(int pageIndex, [double ignored = 0]) {
    if (state.hasClients) {
      state.jumpToPage(pageIndex);
    }
  }

  /// Navigate to [pageIndex] with a smooth animation.
  Future<void> animateToPage(int pageIndex) async {
    if (state.hasClients) {
      await state.animateToPage(
        pageIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Returns the current page index (0-based), or 0 if not attached.
  int get currentPage {
    if (state.hasClients && state.page != null) {
      return state.page!.round();
    }
    return 0;
  }
}
