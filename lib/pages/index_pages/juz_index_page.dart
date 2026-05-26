import 'package:flutter/material.dart';
import 'package:nigerian_mushaf_app/data/mushaf_index_data.dart';
import 'package:nigerian_mushaf_app/l10n/app_localizations.dart';
import 'package:nigerian_mushaf_app/pages/index_pages/index_tiles/juz_index_tile.dart';

class JuzIndexPage extends StatelessWidget {
  const JuzIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: cs.surface,
        elevation: 0,
        title: Text(AppLocalizations.of(context).juzIndexTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: juzList.length,
        itemBuilder: (_, i) => JuzIndexTile(juz: juzList[i]),
      ),
    );
  }
}
