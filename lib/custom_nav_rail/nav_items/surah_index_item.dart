import 'package:flutter/material.dart';
import 'package:nigerian_mushaf_app/l10n/app_localizations.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_rail_button.dart';

class SurahIndexItem extends StatelessWidget {
  const SurahIndexItem({super.key, required this.removeOverlay});

  final void Function() removeOverlay;

  @override
  Widget build(BuildContext context) {
    return NavRailButton(
      icon: Icons.menu_book,
      label: AppLocalizations.of(context).navSurahIndex,
      onPressed: () {
        removeOverlay();
        Navigator.pushNamed(context, '/surah_index_page');
      },
    );
  }
}
