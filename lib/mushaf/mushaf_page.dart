import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/my_themes.dart';
import 'package:nigerian_mushaf_app/providers/theme_provider.dart';

class MushafPage extends ConsumerWidget {
  const MushafPage({super.key, required this.index});

  final int index; // 0-based

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final colorFilter = MyThemes.pageColorFilter(
      themeState.appTheme,
      themeState.customBgColor,
    );
    final bgColor = MyThemes.pageBackgroundColor(
      themeState.appTheme,
      themeState.customBgColor,
    );

    Widget image = Image.asset(
      'assets/pngs/${index + 1}.png',
      fit: BoxFit.contain,
      // Render at native resolution for sharpness; Flutter will downscale.
      filterQuality: FilterQuality.medium,
      // Provides a placeholder until the image is decoded.
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded || frame != null) return child;
        return const Center(child: CircularProgressIndicator(strokeWidth: 1.5));
      },
    );

    if (colorFilter != null) {
      image = ColorFiltered(colorFilter: colorFilter, child: image);
    }

    return Container(
      color: bgColor,
      alignment: Alignment.center,
      child: image,
    );
  }
}
