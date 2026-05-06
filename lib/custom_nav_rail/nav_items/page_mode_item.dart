import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_rail_button.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_view_settings_provider.dart';

class PageModeItem extends ConsumerWidget {
  const PageModeItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(mushafViewSettingsProvider);
    final isSlide = settings.isSlideMode;

    return NavRailButton(
      icon: isSlide ? Icons.touch_app_outlined : Icons.swipe_outlined,
      label: isSlide ? 'Slide\nMode' : 'Swipe\nMode',
      isActive: true,
      onPressed: () {
        ref.read(mushafViewSettingsProvider.notifier).togglePageMode();
      },
    );
  }
}
