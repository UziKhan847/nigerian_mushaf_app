import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_controller_registry.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_view_settings_provider.dart';

/// A single function that jumps to [pageIndex] (0-based) regardless of
/// whether the app is in Swipe or Slide mode.
///
/// Usage:
/// ```dart
/// final navigate = ref.read(mushafNavigateProvider);
/// navigate(context, verse.page - 1);
/// ```
final mushafNavigateProvider = Provider<void Function(BuildContext, int)>(
  (ref) => (BuildContext context, int pageIndex) {
    final registry = ref.read(mushafControllerRegistryProvider);
    final settings = ref.read(mushafViewSettingsProvider);

    // Sync extent from current screen size before jumping.
    final size = MediaQuery.of(context).size;
    registry.itemExtent =
        settings.scrollDirection == Axis.vertical ? size.height : size.width;
    registry.isSlideMode = settings.isSlideMode;

    registry.jumpToPage(pageIndex);
  },
);
