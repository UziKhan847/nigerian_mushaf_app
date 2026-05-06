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
  late final Future<void> _data;

  @override
  void initState() {
    super.initState();
    _data = _loadAll();
  }

  Future<void> _loadAll() async {
    await ref.read(mushafVersesDataProvider.future);
    await ref.read(mushafPgsTextProvider.future);
    await ref.read(mushafPgHeaderProvider.future);
    await ref.read(mushafSurahIndexProvider.future);
    await ref.read(mushafPageIndexProvider.future);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _data,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _ErrorView(error: snapshot.error.toString());
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return const MushafListViewBuilder();
        }
        return const _SplashView();
      },
    );
  }
}

// ── Splash ─────────────────────────────────────────────────────────────────

class _SplashView extends StatelessWidget {
  const _SplashView();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.menu_book_rounded, size: 72, color: cs.primary),
          const SizedBox(height: 24),
          Text(
            'المصحف النيجيري',
            style: TextStyle(
              fontFamily: 'Nigerian',
              fontSize: 28,
              color: cs.primary,
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 8),
          Text(
            'Nigerian Mushaf',
            style: TextStyle(fontSize: 16, color: cs.onSurface.withAlpha(160)),
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: 48,
            child: LinearProgressIndicator(
              color: cs.primary,
              backgroundColor: cs.primary.withAlpha(40),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Error ──────────────────────────────────────────────────────────────────

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.error});
  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 56, color: Colors.red),
            const SizedBox(height: 16),
            const Text(
              'Failed to load Mushaf data',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
