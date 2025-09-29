import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/extensions/num_extension.dart';
import 'package:nigerian_mushaf_app/mushaf/mushaf_verses_data_models/mushaf_verse.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_scroll_ctrl_provider.dart';

class VerseIndexTile extends ConsumerWidget {
  const VerseIndexTile({super.key, required this.verse});

  final MushafVerse verse;

  Text footerText(String text) => Text(text, style: TextStyle(fontSize: 10));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mushafScrollCtrlProv = ref.read(mushafScrollCtrlProvider.notifier);

    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final screenSize = MediaQuery.of(context).size;
    final itemExtent = isPortrait ? screenSize.height : screenSize.width * 2;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
          mushafScrollCtrlProv.jumpToPage(verse.page - 1, itemExtent);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : Color(0xffe4d2b7),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              spacing: 4,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Text(
                          verse.text,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontFamily: 'Nigerian',
                            fontSize: 10,
                          ),
                          softWrap: true,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: const Color.fromARGB(255, 155, 155, 155),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      footerText('Verse: ${verse.verseNum}'),
                      footerText('Page: ${verse.page}'),
                      footerText(
                        'Surah: ${verse.surahNum.surahNumToEngName()} (${verse.surahNum})',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
