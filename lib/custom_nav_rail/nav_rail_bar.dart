import 'package:flutter/material.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_items/about_item.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_items/dark_mode_item.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_items/page_index_item.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_items/search_item.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_items/surah_index_item.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_items/verse_index_item.dart';

class NavRailBar extends StatelessWidget {
  const NavRailBar({super.key, required this.removeOverlay});

  final void Function() removeOverlay;

  @override
  Widget build(BuildContext context) {
    //final screenW = MediaQuery.of(context).size.width;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            bottomLeft: Radius.circular(16),
          ),
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color.fromARGB(255, 37, 0, 0)
              : const Color.fromARGB(255, 255, 222, 222),
        ),
        //width: screenW * 0.2,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            spacing: 50,
            mainAxisSize: isPortrait ? MainAxisSize.min : MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SearchItem(removeOverlay: removeOverlay),

              PageIndexItem(removeOverlay: removeOverlay),

              SurahIndexItem(removeOverlay: removeOverlay),

              VerseIndexItem(removeOverlay: removeOverlay),

              DarkModeItem(),

              AboutItem(removeOverlay: removeOverlay),
            ],
          ),
        ),
      ),
    );
  }
}
