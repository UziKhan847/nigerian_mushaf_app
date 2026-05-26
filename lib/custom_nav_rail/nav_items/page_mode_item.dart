import 'package:flutter/material.dart';
import 'package:nigerian_mushaf_app/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_rail_button.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_view_settings_provider.dart';

class PageModeItem extends ConsumerWidget {
  const PageModeItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isScroll = ref.watch(mushafViewSettingsProvider).isScrollMode;
    return NavRailButton(
      icon:  isScroll ? Icons.unfold_more : Icons.swipe_outlined,
      label: isScroll ? AppLocalizations.of(context).navScrollMode : AppLocalizations.of(context).navSwipeMode,
      isActive: true,
      onPressed: () =>
          ref.read(mushafViewSettingsProvider.notifier).togglePageMode(),
    );
  }
}
