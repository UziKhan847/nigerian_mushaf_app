import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/pages/index_pages/index_models/page_info.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_scroll_ctrl_provider.dart';

class PageIndexTile extends ConsumerWidget {
  const PageIndexTile({super.key, required this.page});

  final PageInfo page;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ctrl = ref.read(mushafScrollCtrlProvider.notifier);
    final cs = Theme.of(context).colorScheme;

    final namesBuffer = StringBuffer();
    for (final name in page.surahNames) {
      if (page.surahNames.length > 3) {
        namesBuffer.write('\n• $name');
        continue;
      }
      namesBuffer.write('$name${name == page.surahNames.last ? '' : ', '}');
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Card(
        elevation: 0,
        color: cs.surfaceContainerLow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pop(context);
            ctrl.jumpToPage(page.pageNum - 1);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                // Page number badge
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: cs.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      '${page.pageNum}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: cs.onPrimaryContainer,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        namesBuffer.toString(),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                // Arabic page label
                Text(
                  'الصفحة ${page.pageNum}',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontFamily: 'Nigerian', fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
