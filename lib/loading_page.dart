import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/mushaf/mushaf_list_view_builder.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_page_index_provider.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_surah_index_provider.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_verses_data_provider.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_pages_header_provider.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_pages_text_provider.dart';

class LoadingPage extends ConsumerStatefulWidget {
  const LoadingPage({super.key});

  @override
  ConsumerState<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends ConsumerState<LoadingPage> {
  late Future<void> data;

  @override
  void initState() {
    super.initState();
    data = getData();
  }

  Future<void> getData() async {
    await ref.read(mushafVersesDataProvider.future);
    await ref.read(mushafPgsTextProvider.future);
    await ref.read(mushafPgHeaderProvider.future);
    await ref.read(mushafSurahIndexProvider.future);
    await ref.read(mushafPageIndexProvider.future);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: data,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MushafListViewBuilder();
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
