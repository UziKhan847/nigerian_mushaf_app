import 'package:flutter/material.dart';
import 'package:nigerian_mushaf_app/l10n/app_localizations.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_rail_button.dart';

class JuzIndexItem extends StatelessWidget {
  const JuzIndexItem({super.key, required this.removeOverlay});

  final void Function() removeOverlay;

  @override
  Widget build(BuildContext context) {
    return NavRailButton(
      icon: Icons.format_list_numbered_rtl,
      label: AppLocalizations.of(context).navJuzIndex,
      onPressed: () {
        removeOverlay();
        Navigator.pushNamed(context, '/juz_index_page');
      },
    );
  }
}
