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
  late int visibleCount;
  late final scrollController = ScrollController();
  final int numOfEntries = 30;

  @override
  void initState() {
    super.initState();
    visibleCount = math.min(numOfEntries, widget.suggestions.length);

    scrollController.addListener(() {
      final maxScrollExtent = scrollController.position.maxScrollExtent;

      final scrollPos = scrollController.position.pixels;

      if (scrollPos >= maxScrollExtent - 200) {
        loadMore();
      }
    });
  }

  @override
  void didUpdateWidget(covariant PaginatedSuggestions oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.suggestions != widget.suggestions) {
      visibleCount = math.min(numOfEntries, widget.suggestions.length);
    } else {
      if (visibleCount > widget.suggestions.length) {
        visibleCount = widget.suggestions.length;
      }
    }
    setState(() {});
  }

  void loadMore() {
    if (!mounted) {
      return;
    }

    visibleCount = math.min(
      widget.suggestions.length,
      visibleCount + numOfEntries,
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.suggestions.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('No matches found', style: TextStyle(fontSize: 16)),
        ),
      );
    }

    return ListView.separated(
      controller: scrollController,
      itemCount: visibleCount,
      separatorBuilder: (_, _) => const Divider(height: 1, thickness: 1),
      itemBuilder: (_, index) {
        return VerseResultTile(
          close: widget.close,
          verse: widget.suggestions[index],
        );
      },
    );
  }
}

// class PaginatedSuggestions extends StatefulWidget {
//   const PaginatedSuggestions({
//     super.key,
//     required this.suggestions,
//     this.pageSize = 30,
//     this.initialLoadDelay = const Duration(milliseconds: 150),
//     required this.close,
//   });

//   final List<MushafVerse> suggestions;
//   final int pageSize;
//   final Duration initialLoadDelay;
//   final void Function(BuildContext, dynamic) close;

//   @override
//   State<PaginatedSuggestions> createState() => _PaginatedSuggestionsState();
// }

// class _PaginatedSuggestionsState extends State<PaginatedSuggestions> {
//   late int _visibleCount;
//   bool _isLoadingInitial = true;
//   bool _isLoadingMore = false;

//   @override
//   void initState() {
//     super.initState();
//     _visibleCount = math.min(widget.pageSize, widget.suggestions.length);
//     Future.delayed(widget.initialLoadDelay, () {
//       if (mounted) setState(() => _isLoadingInitial = false);
//     });
//   }

//   @override
//   void didUpdateWidget(covariant PaginatedSuggestions oldWidget) {
//     super.didUpdateWidget(oldWidget);

//     if (oldWidget.suggestions != widget.suggestions) {
//       setState(() {
//         _visibleCount = math.min(widget.pageSize, widget.suggestions.length);
//         _isLoadingMore = false;
//       });
//     } else if (_visibleCount > widget.suggestions.length) {
//       setState(() {
//         _visibleCount = widget.suggestions.length;
//       });
//     }
//   }

//   // bool get _hasMore =>
//   //     math.min(_visibleCount, widget.suggestions.length) <
//   //     widget.suggestions.length;

//   Future<void> _loadMore() async {
//     if (_isLoadingMore) return;
//     setState(() => _isLoadingMore = true);
//     await Future.delayed(const Duration(milliseconds: 180));
//     if (!mounted) return;
//     setState(() {
//       _visibleCount = math.min(
//         widget.suggestions.length,
//         _visibleCount + widget.pageSize,
//       );
//       _isLoadingMore = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoadingInitial) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     if (widget.suggestions.isEmpty) {
//       return const Center(
//         child: Padding(
//           padding: EdgeInsets.all(16),
//           child: Text('No matches found', style: TextStyle(fontSize: 16)),
//         ),
//       );
//     }

//     final currentVisible = math.min(_visibleCount, widget.suggestions.length);
//     final hasMore = currentVisible < widget.suggestions.length;
//     final totalTiles = currentVisible + (hasMore ? 1 : 0);

//     return ListView.separated(
//       itemCount: totalTiles,
//       separatorBuilder: (_, __) => const Divider(height: 1, thickness: 1),
//       itemBuilder: (context, index) {
//         if (index < currentVisible) {
//           final verse = widget.suggestions[index];

//           return VerseResultTile(close: widget.close, verse: verse);
//         } else {
//           // "Load more" tile
//           if (_isLoadingMore) {
//             return const Padding(
//               padding: EdgeInsets.symmetric(vertical: 16.0),
//               child: Center(child: CircularProgressIndicator()),
//             );
//           }

//           final remaining = widget.suggestions.length - currentVisible;
//           final label = remaining > widget.pageSize
//               ? 'Load ${widget.pageSize} more results'
//               : 'Load $remaining more result${remaining == 1 ? '' : 's'}';

//           return ListTile(
//             title: Center(
//               child: Text(label, style: const TextStyle(fontSize: 16)),
//             ),
//             onTap: _loadMore,
//           );
//         }
//       },
//     );
//   }
// }
