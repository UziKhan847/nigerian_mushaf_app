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
        removeOverlay();
        _showThemePicker(context, ref, currentTheme);
      },
    );
  }

  void _showThemePicker(
    BuildContext context,
    WidgetRef ref,
    AppTheme current,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _ThemePickerSheet(current: current, ref: ref),
    );
  }
}

class _ThemePickerSheet extends StatelessWidget {
  const _ThemePickerSheet({required this.current, required this.ref});

  final AppTheme current;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Choose Theme',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          ...AppTheme.values.map((theme) {
            final isSelected = theme == current;
            return ListTile(
              leading: Icon(
                theme.icon,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : null,
              ),
              title: Text(theme.label),
              trailing: isSelected
                  ? Icon(
                      Icons.check_circle,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : null,
              selected: isSelected,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onTap: () {
                ref.read(themeProvider.notifier).setTheme(theme);
                Navigator.pop(context);
              },
            );
          }),
        ],
      ),
    );
  }
}
