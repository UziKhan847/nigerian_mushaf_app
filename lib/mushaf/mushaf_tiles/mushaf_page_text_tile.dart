import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_pages_text_provider.dart';

class MushafPageTextTile extends ConsumerWidget {
  const MushafPageTextTile({
    super.key,
    required this.maxWidth,
    required this.index,
  });

  final double maxWidth;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mushafPageText = ref.read(mushafPgsTextProvider).value![index];

    return SizedBox(
      width: maxWidth * 0.85,
      child: Text(
        mushafPageText,
        style: TextStyle(
          fontFamily: 'Nigerian',
          fontSize: maxWidth * 0.04,
          height: 1.6,
        ),
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.justify,
      ),
    );
  }
}
