import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/extensions/num_extension.dart';
import 'package:nigerian_mushaf_app/pages/index_pages/index_models/surah_info.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_verses_data_provider.dart';

final mushafSurahIndexProvider =
    AsyncNotifierProvider<MushafSurahIndexProvider, List<SurahInfo>>(
      MushafSurahIndexProvider.new,
    );

class MushafSurahIndexProvider extends AsyncNotifier<List<SurahInfo>> {
  @override
  Future<List<SurahInfo>> build() async {
    final mushafVerses = ref
        .read(mushafVersesDataProvider)
        .value!
        .mushafVersesData;

    final surahsIndex = <SurahInfo>[];

    for (int i = 0; i < 114; i++) {
      final surahNum = i + 1;
      final surahName = surahNum.surahNumToEngName()!;
      final firstVerseIndex = mushafVerses.indexWhere(
        (verse) => verse.surahNum == surahNum,
      );
      final lastVerseIndex = mushafVerses.lastIndexWhere(
        (verse) => verse.surahNum == surahNum,
      );
      final lastVerseNum = mushafVerses[lastVerseIndex].verseNum;
      final firstPageNum = mushafVerses[firstVerseIndex].page;
      final lastPageNum = mushafVerses[lastVerseIndex].page;

      surahsIndex.add(
        SurahInfo(
          surahNum: surahNum,
          surahName: surahName,
          lastVerseNum: lastVerseNum,
          firstPageNum: firstPageNum,
          lastPageNum: lastPageNum,
        ),
      );
    }

    return surahsIndex;
  }
}
