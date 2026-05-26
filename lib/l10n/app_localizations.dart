import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ha.dart';
import 'app_localizations_ig.dart';
import 'app_localizations_yo.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr'),
    Locale('ha'),
    Locale('ig'),
    Locale('yo'),
  ];

  /// The application title shown in the OS and splash screen.
  ///
  /// In en, this message translates to:
  /// **'Nigerian Mushaf'**
  String get appTitle;

  /// Arabic subtitle shown on the splash screen.
  ///
  /// In en, this message translates to:
  /// **'المصحف النيجيري'**
  String get appSubtitle;

  /// Attribution string shown beneath the app title.
  ///
  /// In en, this message translates to:
  /// **'by Quran Quorum'**
  String get appBy;

  /// Nav rail label for the search button.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get navSearch;

  /// Nav rail label for the page index.
  ///
  /// In en, this message translates to:
  /// **'Pages'**
  String get navPageIndex;

  /// Nav rail label for the surah index.
  ///
  /// In en, this message translates to:
  /// **'Sūrahs'**
  String get navSurahIndex;

  /// Nav rail label for the verse index.
  ///
  /// In en, this message translates to:
  /// **'Verses'**
  String get navVerseIndex;

  /// Nav rail label for the theme picker.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get navTheme;

  /// Nav rail label for the custom background colour picker.
  ///
  /// In en, this message translates to:
  /// **'Page\nColour'**
  String get navPageColour;

  /// Nav rail label shown when scroll direction is vertical.
  ///
  /// In en, this message translates to:
  /// **'Vertical'**
  String get navVertical;

  /// Nav rail label shown when scroll direction is horizontal.
  ///
  /// In en, this message translates to:
  /// **'Horizontal'**
  String get navHorizontal;

  /// Nav rail label shown when page mode is continuous scroll.
  ///
  /// In en, this message translates to:
  /// **'Scroll\nMode'**
  String get navScrollMode;

  /// Nav rail label shown when page mode is swipe (snap to page).
  ///
  /// In en, this message translates to:
  /// **'Swipe\nMode'**
  String get navSwipeMode;

  /// Nav rail label for the dual-page spread toggle.
  ///
  /// In en, this message translates to:
  /// **'Dual\nPage'**
  String get navDualPage;

  /// Nav rail label for the About page.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get navAbout;

  /// Nav rail label to enter zoom mode.
  ///
  /// In en, this message translates to:
  /// **'Zoom\nPage'**
  String get navZoomPage;

  /// Nav rail label to leave zoom mode.
  ///
  /// In en, this message translates to:
  /// **'Exit\nZoom'**
  String get navExitZoom;

  /// Nav rail label for the bookmarks sheet.
  ///
  /// In en, this message translates to:
  /// **'Book\nmarks'**
  String get navBookmarks;

  /// Nav rail label for the in-app brightness/dim sheet.
  ///
  /// In en, this message translates to:
  /// **'Bright\nness'**
  String get navBrightness;

  /// Nav rail / index label for the Juz list.
  ///
  /// In en, this message translates to:
  /// **'Juz'**
  String get navJuzIndex;

  /// Nav rail label for the language picker.
  ///
  /// In en, this message translates to:
  /// **'Lang\nuage'**
  String get navLanguage;

  /// Title of the language picker sheet.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languagePickerTitle;

  /// AppBar title of the surah index page.
  ///
  /// In en, this message translates to:
  /// **'Surahs\' Index'**
  String get surahIndexTitle;

  /// AppBar title of the page index page.
  ///
  /// In en, this message translates to:
  /// **'Pages\' Index'**
  String get pageIndexTitle;

  /// AppBar title of the verse index page.
  ///
  /// In en, this message translates to:
  /// **'Verses\' Index'**
  String get verseIndexTitle;

  /// Page-header label for the current surah (Arabic).
  ///
  /// In en, this message translates to:
  /// **'سُورَة {name}'**
  String headerSurah(String name);

  /// Page-header label for the current juz (Arabic-Indic numeral expected).
  ///
  /// In en, this message translates to:
  /// **'جُزْء {num}'**
  String headerJuz(String num);

  /// Title shown in the Juz index list.
  ///
  /// In en, this message translates to:
  /// **'Juzʾ {num}'**
  String juzListTitle(int num);

  /// Subtitle in the Juz index list giving the starting ayah.
  ///
  /// In en, this message translates to:
  /// **'Starts at {location}'**
  String juzStartsAt(String location);

  /// Title of the bookmarks sheet.
  ///
  /// In en, this message translates to:
  /// **'Bookmarks'**
  String get bookmarksTitle;

  /// Button to bookmark the current page.
  ///
  /// In en, this message translates to:
  /// **'Bookmark this page ({page})'**
  String bookmarkAdd(int page);

  /// Button to remove the current page's bookmark.
  ///
  /// In en, this message translates to:
  /// **'Remove this page ({page})'**
  String bookmarkRemove(int page);

  /// Empty-state message in the bookmarks sheet.
  ///
  /// In en, this message translates to:
  /// **'No bookmarks yet'**
  String get bookmarksEmpty;

  /// List-tile label for a saved bookmark.
  ///
  /// In en, this message translates to:
  /// **'Page {page}'**
  String bookmarkPage(int page);

  /// Title of the brightness/dim sheet.
  ///
  /// In en, this message translates to:
  /// **'Brightness'**
  String get brightnessTitle;

  /// Helper text in the brightness sheet.
  ///
  /// In en, this message translates to:
  /// **'Dims the page for comfortable night reading.'**
  String get brightnessHint;

  /// Title of the theme picker bottom sheet.
  ///
  /// In en, this message translates to:
  /// **'Choose Theme'**
  String get themePickerTitle;

  /// Label for the Light theme option.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// Label for the Dark theme option.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// Label for the White theme option.
  ///
  /// In en, this message translates to:
  /// **'White'**
  String get themeWhite;

  /// Label for the Yellow Cream theme option (warm paper tone).
  ///
  /// In en, this message translates to:
  /// **'Yellow Cream'**
  String get themeYellowCream;

  /// Label for the OLED Black theme option.
  ///
  /// In en, this message translates to:
  /// **'OLED Black'**
  String get themeOled;

  /// Label for the Custom theme option (user-defined background colour).
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get themeCustom;

  /// Title of the custom page background colour picker sheet.
  ///
  /// In en, this message translates to:
  /// **'Page Background Colour'**
  String get colourPickerTitle;

  /// Label for the hue slider in the colour picker.
  ///
  /// In en, this message translates to:
  /// **'Hue'**
  String get colourPickerHue;

  /// Label for the saturation slider in the colour picker.
  ///
  /// In en, this message translates to:
  /// **'Saturation'**
  String get colourPickerSaturation;

  /// Label for the lightness slider in the colour picker.
  ///
  /// In en, this message translates to:
  /// **'Lightness'**
  String get colourPickerLightness;

  /// Section label for the preset colours row.
  ///
  /// In en, this message translates to:
  /// **'Presets'**
  String get colourPickerPresets;

  /// Placeholder text shown in the search bar.
  ///
  /// In en, this message translates to:
  /// **'Search Mushaf…'**
  String get searchHint;

  /// Label for the Qiyas (standard Arabic spelling) search mode.
  ///
  /// In en, this message translates to:
  /// **'Qiyāsī'**
  String get searchModeQiyas;

  /// Label for the Uthmani script search mode.
  ///
  /// In en, this message translates to:
  /// **'Uthmānī'**
  String get searchModeUthmani;

  /// Label for the Arabic root-based search mode.
  ///
  /// In en, this message translates to:
  /// **'Root'**
  String get searchModeRoot;

  /// Number of search results found.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No results} =1{1 result} other{{count} results}}'**
  String searchResultCount(int count);

  /// Message shown when the search returns no results.
  ///
  /// In en, this message translates to:
  /// **'No matches found'**
  String get searchNoResults;

  /// Button label to load more paginated search results.
  ///
  /// In en, this message translates to:
  /// **'Load more  ({remaining} remaining)'**
  String searchLoadMore(int remaining);

  /// Empty-state hint for Qiyas search mode.
  ///
  /// In en, this message translates to:
  /// **'Type Arabic text to search by standard spelling.\n\nTashkīl (diacritics) is ignored except for small madd letters.'**
  String get searchHintQiyas;

  /// Empty-state hint for Uthmani search mode.
  ///
  /// In en, this message translates to:
  /// **'Type Arabic text to search by Uthmānī script.\n\nAll diacritics are stripped before matching.'**
  String get searchHintUthmani;

  /// Empty-state hint for root search mode.
  ///
  /// In en, this message translates to:
  /// **'Type a root or stem word to find all related forms.\n\nCommon prefixes and suffixes are stripped automatically.'**
  String get searchHintRoot;

  /// Location label shown on each verse result tile.
  ///
  /// In en, this message translates to:
  /// **'Sūrah {surah}  ·  verse {verse}  ·  page {page}'**
  String verseLocation(String surah, int verse, int page);

  /// Location label for a surah header result tile.
  ///
  /// In en, this message translates to:
  /// **'Sūrah header · {surah}'**
  String verseHeaderLocation(String surah);

  /// Page range and verse count shown in the surah index tile.
  ///
  /// In en, this message translates to:
  /// **'Pages {first}–{last}  ·  {verses} verses'**
  String surahPageRange(int first, int last, int verses);

  /// AppBar title of the About page.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutTitle;

  /// Section heading on the About page.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutSectionAbout;

  /// Features section heading on the About page.
  ///
  /// In en, this message translates to:
  /// **'Features'**
  String get aboutSectionFeatures;

  /// Technical section heading on the About page.
  ///
  /// In en, this message translates to:
  /// **'Technical'**
  String get aboutSectionTechnical;

  /// Credits section heading on the About page.
  ///
  /// In en, this message translates to:
  /// **'Credits'**
  String get aboutSectionCredits;

  /// Main description paragraph on the About page.
  ///
  /// In en, this message translates to:
  /// **'The Nigerian Mushaf App presents all 604 pages of the Nigerian Mushaf as high-resolution page images, faithfully preserving the original colouring, rubrication, diacritics, and the distinctive Maghribi spelling and orthography of the Nigerian tradition. Each page is rendered as two layers — ink and coloured decoration — so themes such as Dark and OLED can recolour the text while leaving the decorative borders untouched.\n\nThe Nigerian Mushaf is one of the most widely used Quran manuscripts in West Africa. Its unique Maghribi script reflects centuries of West African Quranic scholarship and transmission.'**
  String get aboutDescription;

  /// Credits paragraph on the About page.
  ///
  /// In en, this message translates to:
  /// **'Developed by Quran Quorum\n\nThe Nigerian Mushaf is a sacred manuscript with deep roots in the West African Quranic tradition. We have strived to represent it digitally with the utmost care and fidelity.\n\nAll rights to the Nigerian Mushaf script belong to their respective custodians and scholarship communities.\n\n© Quran Quorum. All rights reserved.'**
  String get aboutCreditsBody;

  /// Error message shown if data loading fails.
  ///
  /// In en, this message translates to:
  /// **'Failed to load Mushaf data'**
  String get loadingFailed;

  /// About page: featImages.
  ///
  /// In en, this message translates to:
  /// **'Every page shown as a high-resolution image with separate ink and decoration layers'**
  String get featImages;

  /// About page: featThemes.
  ///
  /// In en, this message translates to:
  /// **'Themes: Light, White, Yellow Cream, Dark, OLED Black and Custom'**
  String get featThemes;

  /// About page: featModes.
  ///
  /// In en, this message translates to:
  /// **'Vertical or horizontal reading with smooth scroll or page-snap swipe'**
  String get featModes;

  /// About page: featDualZoom.
  ///
  /// In en, this message translates to:
  /// **'Dual-page spread and a pinch-to-zoom reading mode'**
  String get featDualZoom;

  /// About page: featSearch.
  ///
  /// In en, this message translates to:
  /// **'Full-text search in Qiyāsī, Uthmānī and root modes'**
  String get featSearch;

  /// About page: featIndexes.
  ///
  /// In en, this message translates to:
  /// **'Sūrah, page and verse indexes for quick navigation'**
  String get featIndexes;

  /// About page: featBookmarks.
  ///
  /// In en, this message translates to:
  /// **'Bookmarks and automatic resume on your last-read page'**
  String get featBookmarks;

  /// About page: featBrightness.
  ///
  /// In en, this message translates to:
  /// **'In-app brightness dimming for night reading'**
  String get featBrightness;

  /// About page: techFramework.
  ///
  /// In en, this message translates to:
  /// **'Framework'**
  String get techFramework;

  /// About page: techState.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get techState;

  /// About page: techRendering.
  ///
  /// In en, this message translates to:
  /// **'Rendering'**
  String get techRendering;

  /// About page: techImagesLabel.
  ///
  /// In en, this message translates to:
  /// **'Images'**
  String get techImagesLabel;

  /// About page: techPagesLabel.
  ///
  /// In en, this message translates to:
  /// **'Pages'**
  String get techPagesLabel;

  /// About page: aboutCreditsShort.
  ///
  /// In en, this message translates to:
  /// **'© Quran Quorum\nAll rights reserved.'**
  String get aboutCreditsShort;

  /// AppBar title of the Juz index page.
  ///
  /// In en, this message translates to:
  /// **'Juz\' Index'**
  String get juzIndexTitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'en',
    'fr',
    'ha',
    'ig',
    'yo',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
    case 'ha':
      return AppLocalizationsHa();
    case 'ig':
      return AppLocalizationsIg();
    case 'yo':
      return AppLocalizationsYo();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
