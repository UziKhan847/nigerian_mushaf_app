import 'package:flutter/material.dart';
import 'package:nigerian_mushaf_app/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_rail_button.dart';
import 'package:nigerian_mushaf_app/providers/bookmarks_provider.dart';
import 'package:nigerian_mushaf_app/providers/current_page_provider.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_navigate_provider.dart';
import 'package:nigerian_mushaf_app/data/mushaf_index_data.dart';

class BookmarksItem extends ConsumerWidget {
  const BookmarksItem({super.key, required this.removeOverlay});
  final VoidCallback removeOverlay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cur    = ref.watch(currentMushafPageProvider);
    final marked = ref.watch(bookmarksProvider).contains(cur);
    return NavRailButton(
      icon:  marked ? Icons.bookmark : Icons.bookmark_border,
      label: AppLocalizations.of(context).navBookmarks,
      isActive: marked,
      onPressed: () {
        final ctx = context;
        removeOverlay();
        showModalBottomSheet(
          context: ctx,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          builder: (_) => const _BookmarksSheet(),
        );
      },
    );
  }
}

class _BookmarksSheet extends ConsumerWidget {
  const _BookmarksSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs     = Theme.of(context).colorScheme;
    final cur    = ref.watch(currentMushafPageProvider);
    final marks  = ref.watch(bookmarksProvider);
    final marked = marks.contains(cur);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40, height: 4,
                decoration: BoxDecoration(
                  color: cs.onSurfaceVariant.withAlpha(80),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(AppLocalizations.of(context).bookmarksTitle, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),

            // Add / remove the current page.
            FilledButton.tonalIcon(
              onPressed: () =>
                  ref.read(bookmarksProvider.notifier).toggle(cur),
              icon: Icon(marked ? Icons.bookmark_remove : Icons.bookmark_add),
              label: Text(marked
                  ? AppLocalizations.of(context).bookmarkRemove(cur + 1)
                  : AppLocalizations.of(context).bookmarkAdd(cur + 1)),
            ),
            const SizedBox(height: 12),

            if (marks.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Center(
                  child: Text(AppLocalizations.of(context).bookmarksEmpty,
                      style: TextStyle(color: cs.onSurfaceVariant)),
                ),
              )
            else
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.45),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: marks.length,
                  itemBuilder: (_, i) {
                    final page = marks[i];
                    return ListTile(
                      leading: const Icon(Icons.bookmark),
                      title: Text(AppLocalizations.of(context).bookmarkPage(page + 1)),
                      subtitle: Text(surahNameForPage(page + 1)),
                      trailing: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () =>
                            ref.read(bookmarksProvider.notifier).remove(page),
                      ),
                      onTap: () {
                        ref.read(mushafNavigateProvider)(context, page);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
