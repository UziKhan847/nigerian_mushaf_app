import 'package:flutter/material.dart';
import 'package:nigerian_mushaf_app/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/extensions/num_extension.dart';
import 'package:nigerian_mushaf_app/pages/index_pages/index_models/surah_info.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_navigate_provider.dart';

class SurahIndexTile extends ConsumerWidget {
  const SurahIndexTile({super.key, required this.surah});

  final SurahInfo surah;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigate = ref.read(mushafNavigateProvider);
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
            navigate(context, surah.firstPageNum - 1);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
              children: [
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
                        AppLocalizations.of(context).surahPageRange(
                          surah.firstPageNum, surah.lastPageNum, surah.lastVerseNum),
                        style: TextStyle(
                          fontSize: 12,
                          color: cs.onSurface.withAlpha(150),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'سورة ${surah.surahNum.surahNumToArabicName()}',
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(fontFamily: 'Ruwudu', fontSize: 17, fontWeight: FontWeight.w700),
                ),
              ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
