import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_rail_button.dart';
import 'package:nigerian_mushaf_app/l10n/app_localizations.dart';
import 'package:nigerian_mushaf_app/providers/locale_provider.dart';

class LanguageItem extends ConsumerWidget {
  const LanguageItem({super.key, required this.removeOverlay});
  final VoidCallback removeOverlay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavRailButton(
      icon: Icons.translate,
      label: AppLocalizations.of(context).navLanguage,
      onPressed: () {
        final ctx = context;
        removeOverlay();
        showModalBottomSheet(
          context: ctx,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          builder: (_) => const _LanguageSheet(),
        );
      },
    );
  }
}

class _LanguageSheet extends ConsumerWidget {
  const _LanguageSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final current = ref.watch(localeProvider)?.languageCode;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: cs.onSurfaceVariant.withAlpha(80),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context).languagePickerTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Flexible(
              child: RadioGroup<String?>(
                groupValue: current,
                onChanged: (code) {
                  ref
                      .read(localeProvider.notifier)
                      .setLocale(code == null ? null : Locale(code));
                  Navigator.pop(context);
                },
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    for (final (code, name) in appLanguages)
                      RadioListTile<String?>(value: code, title: Text(name)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
