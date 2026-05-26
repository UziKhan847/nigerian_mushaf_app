import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/providers/shared_prefs_provider.dart';

/// Sorted list of bookmarked absolute page indices (0-based), persisted.
class BookmarksNotifier extends Notifier<List<int>> {
  static const _key = 'bookmarks';

  @override
  List<int> build() {
    final raw = ref.read(sharedPrefsProv).getStringList(_key) ?? const [];
    final list = raw.map(int.tryParse).whereType<int>().toList()..sort();
    return list;
  }

  bool isBookmarked(int page) => state.contains(page);

  void toggle(int page) {
    final set = {...state};
    set.contains(page) ? set.remove(page) : set.add(page);
    _save(set.toList()..sort());
  }

  void remove(int page) => _save([...state]..remove(page));

  void _save(List<int> list) {
    state = list;
    ref.read(sharedPrefsProv)
        .setStringList(_key, list.map((e) => e.toString()).toList());
  }
}

final bookmarksProvider =
    NotifierProvider<BookmarksNotifier, List<int>>(BookmarksNotifier.new);
