import 'package:flutter/material.dart';
import 'package:nigerian_mushaf_app/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/extensions/num_extension.dart';
import 'package:nigerian_mushaf_app/mushaf/mushaf_verses_data_models/mushaf_verse.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_navigate_provider.dart';

class VerseIndexTile extends ConsumerWidget {
  const VerseIndexTile({super.key, required this.verse});

  final MushafVerse verse;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigate = ref.read(mushafNavigateProvider);
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
            navigate(context, verse.page - 1);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: cs.primaryContainer.withAlpha(120),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      isHeader
                          ? AppLocalizations.of(context).verseHeaderLocation(
                              verse.surahNum.surahNumToEngName()!,
                            )
                          : AppLocalizations.of(context).verseLocation(
                              verse.surahNum.surahNumToEngName()!,
                              verse.verseNum,
                              verse.page,
                            ),
                      style: TextStyle(
                        fontSize: 11,
                        color: cs.onPrimaryContainer,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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
