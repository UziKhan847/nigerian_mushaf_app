import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_rail_button.dart';
import 'package:nigerian_mushaf_app/providers/theme_provider.dart';

class DarkModeItem extends ConsumerWidget {
  const DarkModeItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProv = ref.read(themeProvider.notifier);

    return NavRailButton(
      icon: Icons.dark_mode,
      label: 'Dark Mode',
      onPressed: () {
        themeProv.switchTheme();
      },
    );
  }
}
