import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/extensions/num_extension.dart';
import 'package:nigerian_mushaf_app/mushaf/mushaf_verses_data_models/mushaf_verse.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_scroll_ctrl_provider.dart';

class VerseResultTile extends ConsumerWidget {
  const VerseResultTile({
    super.key,
    required this.close,
    required this.verse,
  });

  final void Function(BuildContext, dynamic) close;
  final MushafVerse verse;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final pageCtrlNotifier = ref.read(mushafScrollCtrlProvider.notifier);

    final isHeader = verse.verseNum == 0;
    final locationText = isHeader
        ? 'Sūrah header · ${verse.surahNum.surahNumToEngName()}'
        : 'Sūrah ${verse.surahNum.surahNumToEngName()}  ·  '
            'verse ${verse.verseNum}  ·  page ${verse.page}';

    return InkWell(
      onTap: () {
        close(context, null);
        pageCtrlNotifier.jumpToPage(verse.page - 1);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Arabic text
            Text(
              verse.text,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 18,
                height: 2.0,
                fontFamily: 'Nigerian',
                color: cs.onSurface,
              ),
            ),
            const SizedBox(height: 6),
            // Location chip
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: cs.primaryContainer.withAlpha(120),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  locationText,
                  style: TextStyle(
                    fontSize: 12,
                    color: cs.onPrimaryContainer,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
