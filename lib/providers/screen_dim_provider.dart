import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/providers/shared_prefs_provider.dart';

/// In-app dim overlay opacity (0.0 = full brightness … 0.8 = very dim).
/// A black overlay is painted over the reading area, so this works without any
/// OS-brightness permission or plugin. Persisted across launches.
class ScreenDimNotifier extends Notifier<double> {
  static const _key = 'screenDim';
  static const maxDim = 0.8;

  @override
  double build() =>
      (ref.read(sharedPrefsProv).getDouble(_key) ?? 0.0).clamp(0.0, maxDim);

  void set(double dim) {
    final d = dim.clamp(0.0, maxDim);
    state = d;
    ref.read(sharedPrefsProv).setDouble(_key, d);
  }
}

final screenDimProvider =
    NotifierProvider<ScreenDimNotifier, double>(ScreenDimNotifier.new);
