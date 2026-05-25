import 'package:flutter/material.dart';
import 'package:nigerian_mushaf_app/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_rail_button.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_view_settings_provider.dart';

class ScrollDirectionItem extends ConsumerWidget {
  const ScrollDirectionItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(mushafViewSettingsProvider);
    final isVertical = settings.scrollDirection == Axis.vertical;

    return NavRailButton(
      icon: isVertical ? Icons.swap_vert : Icons.swap_horiz,
      label: isVertical
          ? AppLocalizations.of(context).navVertical
          : AppLocalizations.of(context).navHorizontal,
      isActive: true,
      onPressed: () {
        ref.read(mushafViewSettingsProvider.notifier).toggleScrollDirection();
      },
    );
  }
}
