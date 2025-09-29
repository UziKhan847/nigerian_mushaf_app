import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/pages/index_pages/index_models/page_info.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_scroll_ctrl_provider.dart';

class PageIndexTile extends ConsumerWidget {
  const PageIndexTile({super.key, required this.page});

  final PageInfo page;

  Text footerText(String text) => Text(text, style: TextStyle(fontSize: 10));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mushafScrollCtrlProv = ref.read(mushafScrollCtrlProvider.notifier);

    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final screenSize = MediaQuery.of(context).size;
    final itemExtent = isPortrait ? screenSize.height : screenSize.width * 2;

    final namesBuffer = StringBuffer();

    for (final name in page.surahNames) {
      if (page.surahNames.length > 3) {
        namesBuffer.write(
          '\n- $name${name == page.surahNames.last ? '' : ', '}',
        );
        continue;
      }
      namesBuffer.write('$name${name == page.surahNames.last ? '' : ', '}');
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
          mushafScrollCtrlProv.jumpToPage(page.pageNum - 1, itemExtent);
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '   Page ${page.pageNum}',
                      style: TextStyle(fontSize: 14),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 9),
                      child: Text(
                        '      الصفحة    ${page.pageNum}',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(fontFamily: 'Nigerian', fontSize: 18),
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
                      footerText('Surah(s): ${namesBuffer.toString()}'),
                      // footerText(
                      //   'Verses: ${page.firstVerse}-${page.lastVerse}',
                      // ),
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
