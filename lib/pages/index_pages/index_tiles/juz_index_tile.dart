import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/data/mushaf_index_data.dart';
import 'package:nigerian_mushaf_app/l10n/app_localizations.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_navigate_provider.dart';

class JuzIndexTile extends ConsumerWidget {
  const JuzIndexTile({super.key, required this.juz});

  final JuzInfo juz;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigate = ref.read(mushafNavigateProvider);
    final cs = Theme.of(context).colorScheme;
    final l = AppLocalizations.of(context);

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
            navigate(context, juz.page - 1);
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
                        '${juz.number}',
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
                          l.juzListTitle(juz.number),
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          l.juzStartsAt(juz.startsAt),
                          style: TextStyle(
                              fontSize: 12, color: cs.onSurface.withAlpha(150)),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'جزء ${toArabicDigits(juz.number)}',
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                        fontFamily: 'Ruwudu', fontSize: 17, fontWeight: FontWeight.w700),
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
