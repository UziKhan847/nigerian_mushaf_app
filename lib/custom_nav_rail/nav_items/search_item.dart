import 'package:flutter/material.dart';
import 'package:nigerian_mushaf_app/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_rail_button.dart';
import 'package:nigerian_mushaf_app/search_by_word/my_search_delegate.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_verses_data_provider.dart';

class SearchItem extends ConsumerWidget {
  const SearchItem({super.key, required this.removeOverlay});

  final void Function() removeOverlay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final verses = ref.read(mushafVersesDataProvider).value!.mushafVersesData;

    return NavRailButton(
      icon: Icons.search,
      label: AppLocalizations.of(context).navSearch,
      onPressed: () {
        removeOverlay();
        showSearch(
          context: context,
          delegate: MySearchDelegate(
            verses: verses,
            searchHint: AppLocalizations.of(context).searchHint,
          ),
        );
      },
    );
  }
}
