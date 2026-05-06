import 'package:flutter/material.dart';
import 'package:nigerian_mushaf_app/extensions/string_extension.dart';
import 'package:nigerian_mushaf_app/search_by_word/paginated_suggestions.dart';
import 'package:nigerian_mushaf_app/mushaf/mushaf_verses_data_models/mushaf_verse.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Search mode
// ─────────────────────────────────────────────────────────────────────────────

enum SearchMode { qiyas, uthmani, root }

extension SearchModeLabel on SearchMode {
  String get label {
    switch (this) {
      case SearchMode.qiyas:
        return 'Qiyāsī';
      case SearchMode.uthmani:
        return 'Uthmānī';
      case SearchMode.root:
        return 'Root';
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Delegate
// ─────────────────────────────────────────────────────────────────────────────

class MySearchDelegate extends SearchDelegate {
  MySearchDelegate({required this.verses});

  final List<MushafVerse> verses;

  final _modeNotifier = ValueNotifier<SearchMode>(SearchMode.qiyas);

  // ── Text normalisation ────────────────────────────────────────────────────

  String _normalise(String text, SearchMode mode) {
    switch (mode) {
      case SearchMode.qiyas:
        return text.removeTashkilExceptSmallMaddLetters;
      case SearchMode.uthmani:
        return text.removeTashkil;
      case SearchMode.root:
        return _rootNormalise(text);
    }
  }

  /// Strips common Arabic prefixes and suffixes so that a search for e.g.
  /// "كتب" will also match "وكتبنا", "كتبوا", etc.
  ///
  /// This is an approximation; proper root extraction requires a full
  /// morphological analyser.  We apply a rule-based heuristic that covers
  /// the most frequent Quranic patterns.
  String _rootNormalise(String text) {
    var s = text.removeTashkilExceptSmallMaddLetters;

    // Strip common proclitic prefixes: و ف ب ل ك ال
    s = s.replaceAll(RegExp(r'^(وال|فال|بال|كال|لل|وَ|فَ|بِ|لِ|كَ|و|ف|ب|ل|ك|ال)'), '');

    // Strip common enclitic suffixes: ون ين ات ة ها هم هن كم وا ني تم ا ي ه
    s = s.replaceAll(
      RegExp(r'(ونَ|ينَ|ونَ|ونْ|ينْ|تان|ين|ون|ات|ة|ها|هم|هن|كم|وا|ني|تم|نا)$'),
      '',
    );

    return s.trim();
  }

  // ── Filter logic ──────────────────────────────────────────────────────────

  List<MushafVerse> _filter(String q, SearchMode mode) {
    if (q.trim().isEmpty) return const [];
    final normQuery = _normalise(q.trim(), mode);
    if (normQuery.isEmpty) return const [];
    return verses.where((v) {
      return _normalise(v.text, mode).contains(normQuery);
    }).toList();
  }

  // ── SearchDelegate overrides ──────────────────────────────────────────────

  @override
  String get searchFieldLabel => 'Search Mushaf…';

  @override
  ThemeData appBarTheme(BuildContext context) {
    final base = Theme.of(context);
    return base.copyWith(
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: TextStyle(color: base.colorScheme.onSurface.withAlpha(120)),
      ),
      textTheme: base.textTheme.copyWith(
        titleLarge: base.textTheme.titleLarge?.copyWith(
          fontFamily: 'Nigerian',
          fontSize: 20,
        ),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          tooltip: 'Clear',
          onPressed: () => query = '',
          icon: const Icon(Icons.clear),
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) => buildSuggestions(context);

  @override
  Widget buildSuggestions(BuildContext context) {
    return ValueListenableBuilder<SearchMode>(
      valueListenable: _modeNotifier,
      builder: (context, mode, _) {
        return Column(
          children: [
            // ── Mode selector ───────────────────────────────────────────────
            _ModeBar(
              current: mode,
              onChanged: (m) {
                _modeNotifier.value = m;
                // Force rebuild of suggestions with new mode.
                final old = query;
                query = '';
                query = old;
              },
            ),

            // ── Results ─────────────────────────────────────────────────────
            Expanded(
              child: query.trim().isEmpty
                  ? _EmptyState(mode: mode)
                  : PaginatedSuggestions(
                      suggestions: _filter(query, mode),
                      close: close,
                    ),
            ),
          ],
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Mode selector bar
// ─────────────────────────────────────────────────────────────────────────────

class _ModeBar extends StatelessWidget {
  const _ModeBar({required this.current, required this.onChanged});

  final SearchMode current;
  final ValueChanged<SearchMode> onChanged;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        border: Border(bottom: BorderSide(color: cs.outlineVariant, width: 0.5)),
      ),
      child: SegmentedButton<SearchMode>(
        segments: SearchMode.values.map((m) {
          return ButtonSegment<SearchMode>(
            value: m,
            label: Text(m.label),
            icon: Icon(_iconFor(m), size: 16),
          );
        }).toList(),
        selected: {current},
        onSelectionChanged: (s) => onChanged(s.first),
        style: SegmentedButton.styleFrom(
          selectedBackgroundColor: cs.primaryContainer,
          selectedForegroundColor: cs.onPrimaryContainer,
        ),
      ),
    );
  }

  IconData _iconFor(SearchMode m) {
    switch (m) {
      case SearchMode.qiyas:
        return Icons.spellcheck;
      case SearchMode.uthmani:
        return Icons.text_fields;
      case SearchMode.root:
        return Icons.account_tree_outlined;
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Empty state
// ─────────────────────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.mode});
  final SearchMode mode;

  String get _hint {
    switch (mode) {
      case SearchMode.qiyas:
        return 'Type Arabic text to search by standard spelling.\n\nTashkīl (diacritics) is ignored except for small madd letters.';
      case SearchMode.uthmani:
        return 'Type Arabic text to search by Uthmānī script.\n\nAll diacritics are stripped before matching.';
      case SearchMode.root:
        return 'Type a root or stem word to find all related forms.\n\nCommon prefixes and suffixes are stripped automatically.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search,
              size: 64,
              color: Theme.of(context).colorScheme.primary.withAlpha(80),
            ),
            const SizedBox(height: 16),
            Text(
              _hint,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurface.withAlpha(160),
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
