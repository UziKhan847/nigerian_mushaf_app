import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_rail_button.dart';
import 'package:nigerian_mushaf_app/my_themes.dart';
import 'package:nigerian_mushaf_app/providers/theme_provider.dart';

class ThemeItem extends ConsumerWidget {
  const ThemeItem({super.key, required this.removeOverlay});

  final VoidCallback removeOverlay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeProvider).appTheme;

    return NavRailButton(
      icon: currentTheme.icon,
      label: 'Theme',
      onPressed: () {
        // Capture context BEFORE removing the overlay (which unmounts this widget).
        final capturedContext = context;
        removeOverlay();
        _showThemePicker(capturedContext, currentTheme);
      },
    );
  }

  void _showThemePicker(BuildContext context, AppTheme current) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      // Consumer gives the sheet its own ref, independent of the nav rail widget.
      builder: (_) => Consumer(
        builder: (ctx, ref, _) => _ThemePickerSheet(
          current: ref.watch(themeProvider).appTheme,
          onSelect: (theme) {
            ref.read(themeProvider.notifier).setTheme(theme);
            Navigator.pop(ctx);
          },
        ),
      ),
    );
  }
}

class _ThemePickerSheet extends StatelessWidget {
  const _ThemePickerSheet({
    required this.current,
    required this.onSelect,
  });

  final AppTheme current;
  final ValueChanged<AppTheme> onSelect;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
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
          const SizedBox(height: 20),
          Text('Choose Theme', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          // Wrap in a scroll view so the list doesn't overflow on small screens.
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.60,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: AppTheme.values.map((theme) {
            final isSelected = theme == current;
            return ListTile(
              leading: Icon(
                theme.icon,
                color: isSelected ? cs.primary : cs.onSurfaceVariant,
              ),
              title: Text(theme.label),
              trailing: isSelected
                  ? Icon(Icons.check_circle, color: cs.primary)
                  : null,
              selected: isSelected,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onTap: () => onSelect(theme),
            );
          }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
