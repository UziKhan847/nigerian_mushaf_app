import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/pages/index_pages/index_tiles/page_index_tile.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_page_index_provider.dart';

class PageIndexPage extends ConsumerWidget {
  const PageIndexPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pagesIndex = ref.read(mushafPageIndexProvider).value!;

    return Scaffold(
      appBar: AppBar(
        title: Text("Pages' Index"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        itemCount: pagesIndex.length,
        itemBuilder: (context, index) {
          final page = pagesIndex[index];

          return PageIndexTile(page: page);
        },
      ),
    );
  }
}
