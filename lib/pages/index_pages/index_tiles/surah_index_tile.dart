import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/extensions/num_extension.dart';
import 'package:nigerian_mushaf_app/pages/index_pages/index_models/surah_info.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_scroll_ctrl_provider.dart';

class SurahIndexTile extends ConsumerWidget {
  const SurahIndexTile({super.key, required this.surah});

  final SurahInfo surah;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ctrl = ref.read(mushafScrollCtrlProvider.notifier);
    final cs = Theme.of(context).colorScheme;

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
            ctrl.jumpToPage(surah.firstPageNum - 1);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                // Surah number badge
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: cs.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${surah.surahNum}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: cs.onPrimaryContainer,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        surah.surahName,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Pages ${surah.firstPageNum}–${surah.lastPageNum}  ·  ${surah.lastVerseNum} verses',
                        style: TextStyle(
                          fontSize: 12,
                          color: cs.onSurface.withAlpha(150),
                        ),
                      ),
                    ],
                  ),
                ),
                // Arabic name
                Text(
                  'سورة ${surah.surahNum.surahNumToArabicName()}',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontFamily: 'Nigerian', fontSize: 17),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
