import 'package:flutter/material.dart';
import 'package:nigerian_mushaf_app/extensions/num_extension.dart';
import 'package:nigerian_mushaf_app/mushaf/mushaf_tiles/mushaf_header_tile.dart';
import 'package:nigerian_mushaf_app/mushaf/mushaf_tiles/mushaf_page_text_tile.dart';

class MushafPage extends StatelessWidget {
  const MushafPage({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenH = screenSize.height;
    final screenW = screenSize.width;

    return Container(
      decoration: BoxDecoration(
        border: BoxBorder.fromLTRB(bottom: BorderSide(color: Colors.black)),
      ),
      width: screenW,
      height: screenH,
      child: Column(
        spacing: screenH * 0.015,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MushafHeaderTile(maxWidth: screenW, index: index),
          MushafPageTextTile(maxWidth: screenW, index: index),
          Text(
            (index + 1).toArabic,
            style: TextStyle(fontSize: screenW * 0.035),
          ),
        ],
      ),
    );
  }
}
