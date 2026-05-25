import 'package:flutter/material.dart';
import 'package:nigerian_mushaf_app/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_rail_button.dart';
import 'package:nigerian_mushaf_app/my_themes.dart';
import 'package:nigerian_mushaf_app/providers/theme_provider.dart';

class ThemeItem extends ConsumerWidget {
  const ThemeItem({super.key, required this.removeOverlay});
  final VoidCallback removeOverlay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(themeProvider).appTheme;
    return NavRailButton(
      icon: current.icon,
      label: AppLocalizations.of(context).navTheme,
      onPressed: () {
        final ctx = context;
        removeOverlay();
        _show(ctx, current);
      },
    );
  }

  void _show(BuildContext context, AppTheme current) {
    showModalBottomSheet(
      context: context,
      // isScrollControlled lets the sheet grow as tall as it needs and gives
      // us control over the padding so nothing is clipped by the nav bar.
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Consumer(
        builder: (ctx, ref, _) {
          final selected = ref.watch(themeProvider).appTheme;
          return _ThemeSheet(
            current: selected,
            onSelect: (t) {
              ref.read(themeProvider.notifier).setTheme(t);
              Navigator.pop(ctx);
            },
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _ThemeSheet extends StatelessWidget {
  const _ThemeSheet({required this.current, required this.onSelect});
  final AppTheme current;
  final ValueChanged<AppTheme> onSelect;

  String _themeName(BuildContext context, AppTheme t) {
    final l = AppLocalizations.of(context);
    switch (t) {
      case AppTheme.light:
        return l.themeLight;
      case AppTheme.white:
        return l.themeWhite;
      case AppTheme.yellowCream:
        return l.themeYellowCream;
      case AppTheme.dark:
        return l.themeDark;
      case AppTheme.oledBlack:
        return l.themeOled;
      case AppTheme.custom:
        return l.themeCustom;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SafeArea(
      // SafeArea handles the bottom system bar (nav bar on Android).
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
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
            const SizedBox(height: 18),
            Text(
              AppLocalizations.of(context).themePickerTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),

            // Scrollable list so it never overflows on small / landscape screens.
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.55,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: AppTheme.values.map((t) {
                    final isSelected = t == current;
                    return ListTile(
                      leading: Icon(
                        t.icon,
                        color: isSelected ? cs.primary : cs.onSurfaceVariant,
                      ),
                      title: Text(_themeName(context, t)),
                      trailing: isSelected
                          ? Icon(Icons.check_circle, color: cs.primary)
                          : null,
                      selected: isSelected,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      onTap: () => onSelect(t),
                    );
                  }).toList(),
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
