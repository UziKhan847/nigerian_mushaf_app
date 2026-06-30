import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/my_themes.dart';
import 'package:nigerian_mushaf_app/pages/about_page.dart';
import 'package:nigerian_mushaf_app/pages/index_pages/page_index_page.dart';
import 'package:nigerian_mushaf_app/pages/index_pages/surah_index_page.dart';
import 'package:nigerian_mushaf_app/pages/index_pages/verse_index_page.dart';
import 'package:nigerian_mushaf_app/pages/index_pages/juz_index_page.dart';
import 'package:nigerian_mushaf_app/loading_page.dart';
import 'package:nigerian_mushaf_app/providers/shared_prefs_provider.dart';
import 'package:nigerian_mushaf_app/providers/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:nigerian_mushaf_app/l10n/app_localizations.dart';
import 'package:nigerian_mushaf_app/providers/locale_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Immersive full-screen reading: hide the status and navigation bars
  // (a swipe from the edge reveals them briefly, then they auto-hide).
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  final prefs = await SharedPreferencesWithCache.create(
    cacheOptions: SharedPreferencesWithCacheOptions(
      allowList: sharedPrefsAllowList,
    ),
  );

  runApp(
    ProviderScope(
      overrides: [sharedPrefsProv.overrideWithValue(prefs)],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final locale     = ref.watch(localeProvider);
    final pageBg = MyThemes.pageBackgroundColor(
      themeState.appTheme, themeState.pageColor,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nigerian Mushaf',
      theme: MyThemes.themeFor(themeState.appTheme),

      // Localizations — uncomment the AppLocalizations delegate once you run
      // `flutter gen-l10n` (or `flutter pub run build_runner build`).
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
        Locale('ha'), // Hausa
        Locale('yo'), // Yoruba
        Locale('ig'), // Igbo
        Locale('fr'), // French (widely used in West Africa)
      ],

      home: Scaffold(
        backgroundColor: pageBg,
        body: const LoadingPage(),
      ),
      routes: {
        '/surah_index_page': (_) => const SurahIndexPage(),
        '/page_index_page':  (_) => const PageIndexPage(),
        '/verse_index_page': (_) => const VerseIndexPage(),
        '/about_page':       (_) => const AboutPage(),
        '/juz_index_page':   (_) => const JuzIndexPage(),
      },
      navigatorObservers: [ImmersiveObserver()],
    );
  }
}

/// Keeps the reader (home route) in immersive full-screen, but restores the
/// system bars on pushed pages (index / about). Modal sheets and dialogs have
/// no route name, so they're treated as part of the reader and stay immersive.
class ImmersiveObserver extends NavigatorObserver {
  void _apply(Route<dynamic>? route) {
    final name = route?.settings.name;
    final readerActive = name == null || name == '/';
    SystemChrome.setEnabledSystemUIMode(
      readerActive ? SystemUiMode.immersiveSticky : SystemUiMode.manual,
      overlays: readerActive ? const [] : SystemUiOverlay.values,
    );
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) => _apply(route);
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) => _apply(previousRoute);
  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) => _apply(newRoute);
  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) => _apply(previousRoute);
}
