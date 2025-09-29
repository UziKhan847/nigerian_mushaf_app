import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/pages/about_page.dart';
import 'package:nigerian_mushaf_app/pages/index_pages/page_index_page.dart';
import 'package:nigerian_mushaf_app/pages/index_pages/surah_index_page.dart';
import 'package:nigerian_mushaf_app/pages/index_pages/verse_index_page.dart';
import 'package:nigerian_mushaf_app/loading_page.dart';
import 'package:nigerian_mushaf_app/my_themes.dart';
import 'package:nigerian_mushaf_app/providers/shared_prefs_provider.dart';
import 'package:nigerian_mushaf_app/providers/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferencesWithCache.create(
    cacheOptions: SharedPreferencesWithCacheOptions(allowList: {'isDarkMode'}),
  );

  runApp(
    ProviderScope(
      overrides: [sharedPrefsProv.overrideWithValue(prefs)],
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nigerian Mushaf App',
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      home: Scaffold(
        backgroundColor: isDarkMode ? Colors.black : Color(0xffe4d2b7),
        body: LoadingPage(),
      ),
      routes: {
        '/surah_index_page': (context) => const SurahIndexPage(),
        '/page_index_page': (context) => const PageIndexPage(),
        '/verse_index_page': (context) => const VerseIndexPage(),
        '/about_page': (context) => const AboutPage(),
      },
    );
  }
}
