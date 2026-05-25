import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/providers/shared_prefs_provider.dart';

/// App UI language. `null` = follow the device locale. Persisted.
class LocaleNotifier extends Notifier<Locale?> {
  static const _key = 'locale';

  @override
  Locale? build() {
    final code = ref.read(sharedPrefsProv).getString(_key);
    return (code == null || code.isEmpty) ? null : Locale(code);
  }

  void setLocale(Locale? locale) {
    state = locale;
    final prefs = ref.read(sharedPrefsProv);
    if (locale == null) {
      prefs.remove(_key);
    } else {
      prefs.setString(_key, locale.languageCode);
    }
  }
}

final localeProvider = NotifierProvider<LocaleNotifier, Locale?>(
  LocaleNotifier.new,
);

/// Languages offered in the picker (code → endonym).
const appLanguages = <(String?, String)>[
  (null, 'System default'),
  ('en', 'English'),
  ('ar', 'العربية'),
  ('ha', 'Hausa'),
  ('yo', 'Yorùbá'),
  ('ig', 'Igbo'),
  ('fr', 'Français'),
];
