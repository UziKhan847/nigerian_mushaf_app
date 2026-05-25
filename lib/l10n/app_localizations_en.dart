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
  String get navScrollMode => 'Scroll\nMode';

  @override
  String get navSwipeMode => 'Swipe\nMode';

  @override
  String get navDualPage => 'Dual\nPage';

  @override
  String get navAbout => 'About';

  @override
  String get navZoomPage => 'Zoom\nPage';

  @override
  String get navExitZoom => 'Exit\nZoom';

  @override
  String get navBookmarks => 'Book\nmarks';

  @override
  String get navBrightness => 'Bright\nness';

  @override
  String get navJuzIndex => 'Juz';

  @override
  String get navLanguage => 'Lang\nuage';

  @override
  String get languagePickerTitle => 'Language';

  @override
  String get surahIndexTitle => 'Surahs\' Index';

  @override
  String get pageIndexTitle => 'Pages\' Index';

  @override
  String get verseIndexTitle => 'Verses\' Index';

  @override
  String headerSurah(String name) {
    return 'سُورَة $name';
  }

  @override
  String headerJuz(String num) {
    return 'جُزْء $num';
  }

  @override
  String juzListTitle(int num) {
    return 'Juzʾ $num';
  }

  @override
  String juzStartsAt(String location) {
    return 'Starts at $location';
  }

  @override
  String get bookmarksTitle => 'Bookmarks';

  @override
  String bookmarkAdd(int page) {
    return 'Bookmark this page ($page)';
  }

  @override
  String bookmarkRemove(int page) {
    return 'Remove this page ($page)';
  }

  @override
  String get bookmarksEmpty => 'No bookmarks yet';

  @override
  String bookmarkPage(int page) {
    return 'Page $page';
  }

  @override
  String get brightnessTitle => 'Brightness';

  @override
  String get brightnessHint => 'Dims the page for comfortable night reading.';

  @override
  String get themePickerTitle => 'Choose Theme';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeWhite => 'White';

  @override
  String get themeYellowCream => 'Yellow Cream';

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
      'The Nigerian Mushaf App presents all 604 pages of the Nigerian Mushaf as high-resolution page images, faithfully preserving the original colouring, rubrication, diacritics, and the distinctive Maghribi spelling and orthography of the Nigerian tradition. Each page is rendered as two layers — ink and coloured decoration — so themes such as Dark and OLED can recolour the text while leaving the decorative borders untouched.\n\nThe Nigerian Mushaf is one of the most widely used Quran manuscripts in West Africa. Its unique Maghribi script reflects centuries of West African Quranic scholarship and transmission.';

  @override
  String get aboutCreditsBody =>
      'Developed by Quran Quorum\n\nThe Nigerian Mushaf is a sacred manuscript with deep roots in the West African Quranic tradition. We have strived to represent it digitally with the utmost care and fidelity.\n\nAll rights to the Nigerian Mushaf script belong to their respective custodians and scholarship communities.\n\n© Quran Quorum. All rights reserved.';

  @override
  String get loadingFailed => 'Failed to load Mushaf data';

  @override
  String get featImages =>
      'Every page shown as a high-resolution image with separate ink and decoration layers';

  @override
  String get featThemes =>
      'Themes: Light, White, Yellow Cream, Dark, OLED Black and Custom';

  @override
  String get featModes =>
      'Vertical or horizontal reading with smooth scroll or page-snap swipe';

  @override
  String get featDualZoom =>
      'Dual-page spread and a pinch-to-zoom reading mode';

  @override
  String get featSearch => 'Full-text search in Qiyāsī, Uthmānī and root modes';

  @override
  String get featIndexes =>
      'Sūrah, page and verse indexes for quick navigation';

  @override
  String get featBookmarks =>
      'Bookmarks and automatic resume on your last-read page';

  @override
  String get featBrightness => 'In-app brightness dimming for night reading';

  @override
  String get techFramework => 'Framework';

  @override
  String get techState => 'State';

  @override
  String get techRendering => 'Rendering';

  @override
  String get techImagesLabel => 'Images';

  @override
  String get techPagesLabel => 'Pages';

  @override
  String get aboutCreditsShort => '© Quran Quorum\nAll rights reserved.';
}
