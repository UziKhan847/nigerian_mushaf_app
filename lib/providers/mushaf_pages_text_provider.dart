// mushaf_pages_text_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/extensions/num_extension.dart';
import 'package:nigerian_mushaf_app/mushaf/mushaf_verses_data_models/mushaf_verse.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_verses_data_provider.dart';

final mushafPgsTextProvider =
    AsyncNotifierProvider<MushafPgsTextNotifier, List<String>>(
      MushafPgsTextNotifier.new,
    );

class MushafPgsTextNotifier extends AsyncNotifier<List<String>> {
  @override
  Future<List<String>> build() async {
    final mushafData = ref.read(mushafVersesDataProvider).value;

    if (mushafData == null) {
      throw Exception('Mushaf Page Data did not load.');
    }
    return buildPagesText(mushafData.mushafVersesData);
  }

  List<String> buildPagesText(
    List<MushafVerse> mushafVerses, {
    int totalPages = 480,
  }) {
    final Map<int, List<MushafVerse>> pagesMap = {};
    for (final verse in mushafVerses) {
      pagesMap.putIfAbsent(verse.page, () => []).add(verse);
    }

    final List<String> pages = List<String>.generate(totalPages, (index) {
      final int pageNumber = index + 1;
      final List<MushafVerse> pageVerses = pagesMap[pageNumber] ?? [];

      final String pageText = pageVerses
          .map(
            (verse) => '${verse.text} ${verse.verseNum == 0 ? '' : verse.verseNum.toArabic} ',
          )
          .join();

      return pageText.trim();
    });

    return pages;
  }
}
