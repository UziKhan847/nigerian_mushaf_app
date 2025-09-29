import 'package:flutter/material.dart';
import 'package:nigerian_mushaf_app/extensions/string_extension.dart';
import 'package:nigerian_mushaf_app/search_by_word/paginated_suggestions.dart';
import 'package:nigerian_mushaf_app/mushaf/mushaf_verses_data_models/mushaf_verse.dart';

class MySearchDelegate extends SearchDelegate {
  MySearchDelegate({required this.verses});

  final List<MushafVerse> verses;
  final isQiyasNotifier = ValueNotifier<bool>(true);

  String removeExtras(String text, bool isQiyas) =>
      isQiyas ? text.removeTahskilExceptSmallMaddLetters : text.removeTahskil;

  Widget getSuggestionWidget(bool isQiyas) {
    if (query.trim().isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('Type to search...', style: TextStyle(fontSize: 16)),
        ),
      );
    }

    final queryWithoutTashkil = removeExtras(query, isQiyas);

    final suggestions = verses.where((verse) {
      final verseWithoutTashkil = removeExtras(verse.text, isQiyas);

      return verseWithoutTashkil.contains(queryWithoutTashkil);
    }).toList();

    return PaginatedSuggestions(suggestions: suggestions, close: close);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color.fromARGB(255, 43, 3, 0)
              : const Color.fromARGB(255, 255, 215, 215),
          child: Align(
            alignment: Alignment.centerLeft,
            child: ValueListenableBuilder(
              valueListenable: isQiyasNotifier,
              builder: (context, isQiyas, _) {
                return Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    spacing: 10,
                    children: [
                      Switch(
                        value: isQiyas,
                        onChanged: (value) {
                          isQiyasNotifier.value = value;
                          final oldQuery = query;
                          query = '';
                          query = oldQuery;
                        },
                      ),
                      Text(
                        'Search By ${isQiyasNotifier.value ? 'Qiyas' : 'Uthmani Script'}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ConstrainedBox(
                constraints: constraints,
                child: getSuggestionWidget(isQiyasNotifier.value),
              );
            },
          ),
        ),
      ],
    );
    // if (query.trim().isEmpty) {
    //   return Center(
    //     child: Padding(
    //       padding: const EdgeInsets.all(16.0),
    //       child: Text('Type to search...', style: TextStyle(fontSize: 16)),
    //     ),
    //   );
    // }

    // //final queryWithoutTashkil = query.removeTahskil;
    // final queryWithoutTashkil = query.removeTahskilExceptSmallMaddLetters;

    // final suggestions = verses.where((verse) {
    //   //final verseWithoutTashkil = verse.text.removeTahskil;
    //   final verseWithoutTashkil =
    //       verse.text.removeTahskilExceptSmallMaddLetters;
    //   return verseWithoutTashkil.contains(queryWithoutTashkil);
    // }).toList();

    // return PaginatedSuggestions(suggestions: suggestions, close: close);
  }
}
