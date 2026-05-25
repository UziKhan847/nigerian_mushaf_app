import 'package:flutter/material.dart';
import 'package:nigerian_mushaf_app/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/pages/index_pages/index_tiles/verse_index_tile.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_verses_data_provider.dart';

class VerseIndexPage extends ConsumerWidget {
  const VerseIndexPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mushafVerses = ref
        .read(mushafVersesDataProvider)
        .value!
        .mushafVersesData;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).verseIndexTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        itemCount: mushafVerses.length,
        itemBuilder: (context, index) {
          final verse = mushafVerses[index];

          return VerseIndexTile(verse: verse);
        },
      ),
    );
  }
}
