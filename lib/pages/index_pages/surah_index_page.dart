import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/pages/index_pages/index_tiles/surah_index_tile.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_surah_index_provider.dart';

class SurahIndexPage extends ConsumerWidget {
  const SurahIndexPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final surahsIndex = ref.read(mushafSurahIndexProvider).value!;

    return Scaffold(
      appBar: AppBar(
        title: Text("Surahs' Index"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        itemCount: surahsIndex.length,
        itemBuilder: (context, index) {
          final surah = surahsIndex[index];

          return SurahIndexTile(surah: surah);
        },
      ),
    );
  }
}
