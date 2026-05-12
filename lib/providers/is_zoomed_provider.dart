import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Notifier that tracks whether the user has pinch-zoomed into the current page.
/// Updated by [MushafPage] via its [TransformationController] listener.
/// Read by [MushafListViewBuilder] to disable outer scroll physics and show
/// floating prev/next navigation buttons.
class ZoomNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void setZoomed(bool value) {
    if (state != value) state = value;
  }
}

final isZoomedInProvider = NotifierProvider<ZoomNotifier, bool>(ZoomNotifier.new);
