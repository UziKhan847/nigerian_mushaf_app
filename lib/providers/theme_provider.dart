import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/providers/shared_prefs_provider.dart';


final themeProvider = NotifierProvider<ThemeNotifier, bool>(ThemeNotifier.new);

class ThemeNotifier extends Notifier<bool> {
  @override
  bool build() => ref.read(sharedPrefsProv).getBool('isDarkMode') ?? false;

  void switchTheme() {
    final prefs = ref.read(sharedPrefsProv);
    state = !state;
    prefs.setBool('isDarkMode', state);
  }
}