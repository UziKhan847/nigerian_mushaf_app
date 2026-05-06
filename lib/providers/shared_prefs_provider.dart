import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefsProv = Provider<SharedPreferencesWithCache>(
  (ref) => throw UnimplementedError(),
);

/// Keys stored in [SharedPreferencesWithCache].
/// Extend this set whenever new persistent settings are added.
const sharedPrefsAllowList = <String>{
  'isDarkMode',     // legacy – kept for migration
  'appTheme',
  'customBgColor',
  'scrollDirection',
  'isSlideMode',
};
