import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/providers/shared_prefs_provider.dart';

// ─────────────────────────────────────────────────────────────────────────────
// State
// ─────────────────────────────────────────────────────────────────────────────

class MushafViewSettings {
  const MushafViewSettings({
    required this.scrollDirection,
    required this.isSlideMode,
  });

  /// [Axis.vertical] = scroll up/down; [Axis.horizontal] = swipe left/right.
  final Axis scrollDirection;

  /// true  = tap left/right half of page to navigate (slide mode)
  /// false = drag/swipe gesture (swipe mode)
  final bool isSlideMode;

  MushafViewSettings copyWith({Axis? scrollDirection, bool? isSlideMode}) =>
      MushafViewSettings(
        scrollDirection: scrollDirection ?? this.scrollDirection,
        isSlideMode: isSlideMode ?? this.isSlideMode,
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// Provider
// ─────────────────────────────────────────────────────────────────────────────

final mushafViewSettingsProvider =
    NotifierProvider<MushafViewSettingsNotifier, MushafViewSettings>(
      MushafViewSettingsNotifier.new,
    );

class MushafViewSettingsNotifier extends Notifier<MushafViewSettings> {
  static const _dirKey = 'scrollDirection';
  static const _modeKey = 'isSlideMode';

  @override
  MushafViewSettings build() {
    final prefs = ref.read(sharedPrefsProv);
    final dirStr = prefs.getString(_dirKey) ?? 'vertical';
    final slideMode = prefs.getBool(_modeKey) ?? false;

    return MushafViewSettings(
      scrollDirection:
          dirStr == 'horizontal' ? Axis.horizontal : Axis.vertical,
      isSlideMode: slideMode,
    );
  }

  void toggleScrollDirection() {
    final prefs = ref.read(sharedPrefsProv);
    final newDir = state.scrollDirection == Axis.vertical
        ? Axis.horizontal
        : Axis.vertical;
    state = state.copyWith(scrollDirection: newDir);
    prefs.setString(
      _dirKey,
      newDir == Axis.horizontal ? 'horizontal' : 'vertical',
    );
  }

  void togglePageMode() {
    final prefs = ref.read(sharedPrefsProv);
    state = state.copyWith(isSlideMode: !state.isSlideMode);
    prefs.setBool(_modeKey, state.isSlideMode);
  }
}
