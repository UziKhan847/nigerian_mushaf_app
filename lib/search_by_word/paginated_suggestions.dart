import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:nigerian_mushaf_app/search_by_word/verse_result_tile.dart';
import 'package:nigerian_mushaf_app/mushaf/mushaf_verses_data_models/mushaf_verse.dart';

class PaginatedSuggestions extends StatefulWidget {
  const PaginatedSuggestions({
    super.key,
    required this.suggestions,
    required this.close,
  });

  final List<MushafVerse> suggestions;
  final void Function(BuildContext, dynamic) close;

  @override
  State<PaginatedSuggestions> createState() => _PaginatedSuggestionsState();
}

class _PaginatedSuggestionsState extends State<PaginatedSuggestions> {
  late int _visibleCount;
  final _scrollCtrl = ScrollController();
  static const _pageSize = 30;

  @override
  void initState() {
    super.initState();
    _visibleCount = math.min(_pageSize, widget.suggestions.length);
    _scrollCtrl.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(covariant PaginatedSuggestions oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.suggestions != widget.suggestions) {
      setState(() {
        _visibleCount = math.min(_pageSize, widget.suggestions.length);
      });
    }
  }

  void _onScroll() {
    final pos = _scrollCtrl.position;
    if (pos.pixels >= pos.maxScrollExtent - 300) {
      _loadMore();
    }
  }

  void _loadMore() {
    final next = math.min(widget.suggestions.length, _visibleCount + _pageSize);
    if (next != _visibleCount) setState(() => _visibleCount = next);
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.suggestions.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off,
              size: 56,
              color: Theme.of(context).colorScheme.onSurface.withAlpha(60),
            ),
            const SizedBox(height: 12),
            Text(
              'No matches found',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurface.withAlpha(140),
              ),
            ),
          ],
        ),
      );
    }

    final count = widget.suggestions.length;
    final visible = math.min(_visibleCount, count);

    return CustomScrollView(
      controller: _scrollCtrl,
      slivers: [
        // Result count header
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              '$count result${count == 1 ? '' : 's'}',
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(context).colorScheme.onSurface.withAlpha(160),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (index.isOdd) {
                return Divider(
                  height: 1,
                  thickness: 0.5,
                  indent: 20,
                  endIndent: 20,
                  color: Theme.of(
                    context,
                  ).colorScheme.outlineVariant.withAlpha(120),
                );
              }
              final verseIndex = index ~/ 2;
              return VerseResultTile(
                close: widget.close,
                verse: widget.suggestions[verseIndex],
              );
            },
            childCount: visible * 2 - 1,
          ),
        ),

        // Load-more footer
        if (visible < count)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: TextButton.icon(
                  onPressed: _loadMore,
                  icon: const Icon(Icons.expand_more),
                  label: Text(
                    'Load more  (${count - visible} remaining)',
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
