import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/providers/shared_prefs_provider.dart';

/// Absolute 0-based mushaf page (0–603), persisted so the app reopens on the
/// last-read page.
class CurrentPageNotifier extends Notifier<int> {
  static const _key = 'lastPage';

  @override
  int build() =>
      (ref.read(sharedPrefsProv).getInt(_key) ?? 0).clamp(0, 603);

  void setPage(int page) {
    final p = page.clamp(0, 603);
    if (state == p) return;
    state = p;
    ref.read(sharedPrefsProv).setInt(_key, p);
  }
}

final currentMushafPageProvider =
    NotifierProvider<CurrentPageNotifier, int>(CurrentPageNotifier.new);
