import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_pages_header_provider.dart';

class MushafHeaderTile extends ConsumerWidget {
  const MushafHeaderTile({
    super.key,
    required this.maxWidth,
    required this.index,
  });

  final double maxWidth;
  final int index;

  TextStyle get headerTextStyle =>
      TextStyle(fontFamily: 'Nigerian', fontSize: maxWidth * 0.025);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mushafPageHeader = ref
        .read(mushafPgHeaderProvider)
        .value!
        .mushafPagesHeader[index];

    return SizedBox(
      width: maxWidth * 0.85,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(mushafPageHeader.numOfWaqf, style: headerTextStyle),
              Text(mushafPageHeader.surahName, style: headerTextStyle),
            ],
          ),
          Center(
            child: Text(mushafPageHeader.hizbInfo, style: headerTextStyle),
          ),
        ],
      ),
    );
  }
}
