import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/providers/shared_prefs_provider.dart';

class MushafViewSettings {
  const MushafViewSettings({
    required this.scrollDirection,
    required this.isSlideMode,
    required this.isDualPageEnabled,
  });

  /// [Axis.vertical] = scroll up/down; [Axis.horizontal] = swipe left/right.
  final Axis scrollDirection;

  /// true  = ListView smooth continuous scroll (can stop mid-page).
  /// false = PageView that snaps to a full page on release.
  final bool isSlideMode;

  /// When true the user has manually enabled dual-page regardless of orientation.
  /// The view builder also auto-enables dual-page in landscape.
  final bool isDualPageEnabled;

  MushafViewSettings copyWith({
    Axis? scrollDirection,
    bool? isSlideMode,
    bool? isDualPageEnabled,
  }) => MushafViewSettings(
    scrollDirection: scrollDirection ?? this.scrollDirection,
    isSlideMode: isSlideMode ?? this.isSlideMode,
    isDualPageEnabled: isDualPageEnabled ?? this.isDualPageEnabled,
  );
}

final mushafViewSettingsProvider =
    NotifierProvider<MushafViewSettingsNotifier, MushafViewSettings>(
      MushafViewSettingsNotifier.new,
    );

class MushafViewSettingsNotifier extends Notifier<MushafViewSettings> {
  static const _dirKey      = 'scrollDirection';
  static const _modeKey     = 'isSlideMode';
  static const _dualPageKey = 'isDualPageEnabled';

  @override
  MushafViewSettings build() {
    final prefs = ref.read(sharedPrefsProv);
    return MushafViewSettings(
      scrollDirection: prefs.getString(_dirKey) == 'horizontal'
          ? Axis.horizontal
          : Axis.vertical,
      isSlideMode:       prefs.getBool(_modeKey)     ?? false,
      isDualPageEnabled: prefs.getBool(_dualPageKey) ?? false,
    );
  }

  void toggleScrollDirection() {
    final newDir = state.scrollDirection == Axis.vertical
        ? Axis.horizontal
        : Axis.vertical;
    state = state.copyWith(scrollDirection: newDir);
    ref.read(sharedPrefsProv).setString(
      _dirKey,
      newDir == Axis.horizontal ? 'horizontal' : 'vertical',
    );
  }

  void togglePageMode() {
    state = state.copyWith(isSlideMode: !state.isSlideMode);
    ref.read(sharedPrefsProv).setBool(_modeKey, state.isSlideMode);
  }

  void toggleDualPage() {
    state = state.copyWith(isDualPageEnabled: !state.isDualPageEnabled);
    ref.read(sharedPrefsProv).setBool(_dualPageKey, state.isDualPageEnabled);
  }
}
