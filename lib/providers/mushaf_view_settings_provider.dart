import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/providers/shared_prefs_provider.dart';

class MushafViewSettings {
  const MushafViewSettings({
    required this.scrollDirection,
    required this.isScrollMode,
    required this.isDualPageEnabled,
  });

  /// [Axis.vertical] = up/down; [Axis.horizontal] = left/right.
  final Axis scrollDirection;

  /// true  = Scroll mode: PageView with pageSnapping off → smooth continuous
  ///         scrolling that can stop between pages.
  /// false = Swipe mode: PageView that snaps to a full page on release.
  final bool isScrollMode;

  /// User-enabled dual-page (also auto-enabled in landscape by the view).
  final bool isDualPageEnabled;

  MushafViewSettings copyWith({
    Axis? scrollDirection,
    bool? isScrollMode,
    bool? isDualPageEnabled,
  }) => MushafViewSettings(
    scrollDirection:   scrollDirection   ?? this.scrollDirection,
    isScrollMode:      isScrollMode      ?? this.isScrollMode,
    isDualPageEnabled: isDualPageEnabled ?? this.isDualPageEnabled,
  );
}

final mushafViewSettingsProvider =
    NotifierProvider<MushafViewSettingsNotifier, MushafViewSettings>(
      MushafViewSettingsNotifier.new,
    );

class MushafViewSettingsNotifier extends Notifier<MushafViewSettings> {
  static const _dirKey      = 'scrollDirection';
  static const _modeKey     = 'isScrollMode';
  static const _dualPageKey = 'isDualPageEnabled';

  @override
  MushafViewSettings build() {
    final prefs = ref.read(sharedPrefsProv);
    return MushafViewSettings(
      scrollDirection: prefs.getString(_dirKey) == 'horizontal'
          ? Axis.horizontal : Axis.vertical,
      isScrollMode:      prefs.getBool(_modeKey)     ?? false,
      isDualPageEnabled: prefs.getBool(_dualPageKey) ?? false,
    );
  }

  void toggleScrollDirection() {
    final dir = state.scrollDirection == Axis.vertical
        ? Axis.horizontal : Axis.vertical;
    state = state.copyWith(scrollDirection: dir);
    ref.read(sharedPrefsProv)
        .setString(_dirKey, dir == Axis.horizontal ? 'horizontal' : 'vertical');
  }

  void togglePageMode() {
    state = state.copyWith(isScrollMode: !state.isScrollMode);
    ref.read(sharedPrefsProv).setBool(_modeKey, state.isScrollMode);
  }

  void toggleDualPage() {
    state = state.copyWith(isDualPageEnabled: !state.isDualPageEnabled);
    ref.read(sharedPrefsProv).setBool(_dualPageKey, state.isDualPageEnabled);
  }
}
