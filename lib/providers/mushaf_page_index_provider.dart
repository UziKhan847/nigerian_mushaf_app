import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/extensions/num_extension.dart';
import 'package:nigerian_mushaf_app/pages/index_pages/index_models/page_info.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_verses_data_provider.dart';

final mushafPageIndexProvider =
    AsyncNotifierProvider<MushafPageIndexProvider, List<PageInfo>>(
      MushafPageIndexProvider.new,
    );

class MushafPageIndexProvider extends AsyncNotifier<List<PageInfo>> {
  @override
  Future<List<PageInfo>> build() async {
    final mushafVerses = ref
        .read(mushafVersesDataProvider)
        .value!
        .mushafVersesData;

    final pagesIndex = <PageInfo>[];

    for (int i = 0; i < 480; i++) {
      final pageNum = i + 1;

      // final firstVerseIndex = mushafVerses.indexWhere(
      //   (verse) => verse.page == pageNum,
      // );
      // final lastVerseIndex = mushafVerses.lastIndexWhere(
      //   (verse) => verse.page == pageNum,
      // );

      // final firstVerse = mushafVerses[firstVerseIndex].verseNum;
      // final lastVerse = mushafVerses[lastVerseIndex].verseNum;

      final surahNums = mushafVerses
          .where((verse) => verse.page == pageNum)
          .map((verse) => verse.surahNum)
          .toSet()
          .toList();

      final surahNames = surahNums
          .map((num) => num.surahNumToEngName()!)
          .toList();

      pagesIndex.add(
        PageInfo(
          // firstVerse: firstVerse == 0 ? 1 : firstVerse,
          // lastVerse: lastVerse,
          pageNum: pageNum,
          surahNames: surahNames,
          surahNums: surahNums,
        ),
      );
    }

    return pagesIndex;
  }
}
