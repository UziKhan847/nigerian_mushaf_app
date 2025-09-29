import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/extensions/num_extension.dart';
import 'package:nigerian_mushaf_app/mushaf/mushaf_verses_data_models/mushaf_verse.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_scroll_ctrl_provider.dart';

class VerseResultTile extends ConsumerWidget {
  const VerseResultTile({super.key, required this.close, required this.verse});

  final void Function(BuildContext, dynamic) close;
  final MushafVerse verse;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mushafScrollCtrlProv = ref.read(mushafScrollCtrlProvider.notifier);

    final verseInfoText = verse.verseNum == 0
        ? 'Found in the Header of Surah ${verse.surahNum.surahNumToEngName()}'
        : 'Found in Surah ${verse.surahNum.surahNumToEngName()}: ${verse.verseNum} (page ${verse.page})';

    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final screenSize = MediaQuery.of(context).size;
    final itemExtent = isPortrait ? screenSize.height : screenSize.width * 2;

    return GestureDetector(
      onTap: () {
        close(context, null);
        mushafScrollCtrlProv.jumpToPage(verse.page - 1, itemExtent);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              verse.text,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 18, height: 2, fontFamily: 'Nigerian'),
            ),
            const SizedBox(height: 8),
            Text(verseInfoText, style: TextStyle(fontSize: 18, height: 1.2)),
          ],
        ),
      ),
    );
  }
}
