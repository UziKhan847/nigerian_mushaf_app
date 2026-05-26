import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefsProv = Provider<SharedPreferencesWithCache>(
  (ref) => throw UnimplementedError(),
);

/// All keys used by [SharedPreferencesWithCache].
/// Add new keys here whenever new persistent settings are introduced.
const sharedPrefsAllowList = <String>{
  'isDarkMode',        // legacy – kept for migration
  'appTheme',
  'customBgColor',
  'scrollDirection',
  'isScrollMode',
  'isDualPageEnabled',
  'lastPage',
  'bookmarks',
  'screenDim',
  'locale',
};
