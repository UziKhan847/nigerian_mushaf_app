// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Nigerian Mushaf';

  @override
  String get appSubtitle => 'المصحف النيجيري';

  @override
  String get appBy => 'by Quran Quorum';

  @override
  String get navSearch => 'Search';

  @override
  String get navPageIndex => 'Pages';

  @override
  String get navSurahIndex => 'Sūrahs';

  @override
  String get navVerseIndex => 'Verses';

  @override
  String get navTheme => 'Theme';

  @override
  String get navPageColour => 'Page\nColour';

  @override
  String get navVertical => 'Vertical';

  @override
  String get navHorizontal => 'Horizontal';

  @override
  String get navSlideMode => 'Slide\nMode';

  @override
  String get navSwipeMode => 'Swipe\nMode';

  @override
  String get navDualPage => 'Dual\nPage';

  @override
  String get navAbout => 'About';

  @override
  String get themePickerTitle => 'Choose Theme';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeMonochrome => 'Monochrome';

  @override
  String get themeOled => 'OLED Black';

  @override
  String get themeCustom => 'Custom';

  @override
  String get colourPickerTitle => 'Page Background Colour';

  @override
  String get colourPickerHue => 'Hue';

  @override
  String get colourPickerSaturation => 'Saturation';

  @override
  String get colourPickerLightness => 'Lightness';

  @override
  String get colourPickerPresets => 'Presets';

  @override
  String get searchHint => 'Search Mushaf…';

  @override
  String get searchModeQiyas => 'Qiyāsī';

  @override
  String get searchModeUthmani => 'Uthmānī';

  @override
  String get searchModeRoot => 'Root';

  @override
  String searchResultCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count results',
      one: '1 result',
      zero: 'No results',
    );
    return '$_temp0';
  }

  @override
  String get searchNoResults => 'No matches found';

  @override
  String searchLoadMore(int remaining) {
    return 'Load more  ($remaining remaining)';
  }

  @override
  String get searchHintQiyas =>
      'Type Arabic text to search by standard spelling.\n\nTashkīl (diacritics) is ignored except for small madd letters.';

  @override
  String get searchHintUthmani =>
      'Type Arabic text to search by Uthmānī script.\n\nAll diacritics are stripped before matching.';

  @override
  String get searchHintRoot =>
      'Type a root or stem word to find all related forms.\n\nCommon prefixes and suffixes are stripped automatically.';

  @override
  String verseLocation(String surah, int verse, int page) {
    return 'Sūrah $surah  ·  verse $verse  ·  page $page';
  }

  @override
  String verseHeaderLocation(String surah) {
    return 'Sūrah header · $surah';
  }

  @override
  String surahPageRange(int first, int last, int verses) {
    return 'Pages $first–$last  ·  $verses verses';
  }

  @override
  String get aboutTitle => 'About';

  @override
  String get aboutSectionAbout => 'About';

  @override
  String get aboutSectionFeatures => 'Features';

  @override
  String get aboutSectionTechnical => 'Technical';

  @override
  String get aboutSectionCredits => 'Credits';

  @override
  String get aboutDescription =>
      'The Nigerian Mushaf App presents the Nigerian Mushaf as scalable, selectable text rendered in a custom Nigerian Maghribi font — not scanned PDFs. It faithfully preserves the original colouring, rubrication, all diacritic marks, and the distinctive Maghribi spelling and orthography of the Nigerian tradition.\n\nThe Nigerian Mushaf is one of the most widely used Quran manuscripts in West Africa. Its unique Maghribi script reflects centuries of West African Quranic scholarship and transmission.';

  @override
  String get aboutCreditsBody =>
      'Developed by Quran Quorum\n\nThe Nigerian Mushaf is a sacred manuscript with deep roots in the West African Quranic tradition. We have strived to represent it digitally with the utmost care and fidelity.\n\nAll rights to the Nigerian Mushaf script belong to their respective custodians and scholarship communities.\n\n© Quran Quorum. All rights reserved.';

  @override
  String get loadingFailed => 'Failed to load Mushaf data';
}
