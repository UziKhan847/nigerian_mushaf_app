import 'package:flutter/material.dart';
import 'package:nigerian_mushaf_app/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_rail_button.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_view_settings_provider.dart';

class DualPageItem extends ConsumerWidget {
  const DualPageItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enabled = ref.watch(
      mushafViewSettingsProvider.select((s) => s.isDualPageEnabled),
    );
    return NavRailButton(
      icon:     Icons.auto_stories_outlined,
      label:    AppLocalizations.of(context).navDualPage,
      isActive: enabled,
      onPressed: () =>
          ref.read(mushafViewSettingsProvider.notifier).toggleDualPage(),
    );
  }
}
