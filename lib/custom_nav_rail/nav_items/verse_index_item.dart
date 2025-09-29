import 'package:flutter/material.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_rail_button.dart';

class VerseIndexItem extends StatelessWidget {
  const VerseIndexItem({super.key, required this.removeOverlay});

  final void Function() removeOverlay;

  @override
  Widget build(BuildContext context) {
    return NavRailButton(
      icon: Icons.format_quote,
      label: 'Verse Index',
      onPressed: () {
        removeOverlay();
        Navigator.pushNamed(context, '/verse_index_page');
      },
    );
  }
}
