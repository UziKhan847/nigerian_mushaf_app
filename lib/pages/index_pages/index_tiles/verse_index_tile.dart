import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/extensions/num_extension.dart';
import 'package:nigerian_mushaf_app/mushaf/mushaf_verses_data_models/mushaf_verse.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_scroll_ctrl_provider.dart';

class VerseIndexTile extends ConsumerWidget {
  const VerseIndexTile({super.key, required this.verse});

  final MushafVerse verse;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ctrl = ref.read(mushafScrollCtrlProvider.notifier);
    final cs = Theme.of(context).colorScheme;
    final isHeader = verse.verseNum == 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Card(
        elevation: 0,
        color: cs.surfaceContainerLow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pop(context);
            ctrl.jumpToPage(verse.page - 1);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Arabic verse text
                Text(
                  verse.text,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontFamily: 'Nigerian',
                    fontSize: 15,
                    height: 1.8,
                    color: cs.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    // Location chip
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: cs.primaryContainer.withAlpha(120),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        isHeader
                            ? 'Header · ${verse.surahNum.surahNumToEngName()}'
                            : 'Verse ${verse.verseNum}  ·  Sūrah ${verse.surahNum}  ·  p.${verse.page}',
                        style: TextStyle(
                          fontSize: 11,
                          color: cs.onPrimaryContainer,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
