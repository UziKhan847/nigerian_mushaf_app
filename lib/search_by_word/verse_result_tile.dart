import 'package:flutter/material.dart';
import 'package:nigerian_mushaf_app/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/extensions/num_extension.dart';
import 'package:nigerian_mushaf_app/mushaf/mushaf_verses_data_models/mushaf_verse.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_navigate_provider.dart';

class VerseResultTile extends ConsumerWidget {
  const VerseResultTile({super.key, required this.close, required this.verse});

  final void Function(BuildContext, dynamic) close;
  final MushafVerse verse;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigate = ref.read(mushafNavigateProvider);
    final cs = Theme.of(context).colorScheme;
    final isHeader = verse.verseNum == 0;

    final locationText = isHeader
        ? AppLocalizations.of(
            context,
          ).verseHeaderLocation(verse.surahNum.surahNumToEngName()!)
        : AppLocalizations.of(context).verseLocation(
            verse.surahNum.surahNumToEngName()!,
            verse.verseNum,
            verse.page,
          );

    return InkWell(
      onTap: () {
        // Capture context before close() pops the search route.
        final ctx = context;
        close(ctx, null);
        navigate(ctx, verse.page - 1);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 3,
                ),
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
