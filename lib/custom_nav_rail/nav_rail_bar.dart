import 'package:flutter/material.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_items/about_item.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_items/page_index_item.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_items/search_item.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_items/surah_index_item.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_items/verse_index_item.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_items/theme_item.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_items/scroll_direction_item.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_items/page_mode_item.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_items/bg_color_item.dart';

class NavRailBar extends StatelessWidget {
  const NavRailBar({super.key, required this.removeOverlay});

  final VoidCallback removeOverlay;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final railBg = isDark
        ? colorScheme.surfaceContainerHigh
        : colorScheme.surfaceContainerLowest;

    return Align(
      alignment: Alignment.centerRight,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: railBg,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(50),
              blurRadius: 12,
              offset: const Offset(-2, 0),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
        child: IntrinsicWidth(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SearchItem(removeOverlay: removeOverlay),
                _divider(),
                PageIndexItem(removeOverlay: removeOverlay),
                SurahIndexItem(removeOverlay: removeOverlay),
                VerseIndexItem(removeOverlay: removeOverlay),
                _divider(),
                ThemeItem(removeOverlay: removeOverlay),
                BgColorItem(removeOverlay: removeOverlay),
                _divider(),
                ScrollDirectionItem(),
                PageModeItem(),
                _divider(),
                AboutItem(removeOverlay: removeOverlay),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _divider() => const Padding(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    child: Divider(height: 1, thickness: 0.5),
  );
}
