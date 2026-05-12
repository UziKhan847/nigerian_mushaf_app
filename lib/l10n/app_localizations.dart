import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

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
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

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

  /// Nav rail label shown when page mode is slide (smooth scroll).
  ///
  /// In en, this message translates to:
  /// **'Slide\nMode'**
  String get navSlideMode;

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

  /// Label for the Monochrome theme option.
  ///
  /// In en, this message translates to:
  /// **'Monochrome'**
  String get themeMonochrome;

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
  /// **'The Nigerian Mushaf App presents the Nigerian Mushaf as scalable, selectable text rendered in a custom Nigerian Maghribi font — not scanned PDFs. It faithfully preserves the original colouring, rubrication, all diacritic marks, and the distinctive Maghribi spelling and orthography of the Nigerian tradition.\n\nThe Nigerian Mushaf is one of the most widely used Quran manuscripts in West Africa. Its unique Maghribi script reflects centuries of West African Quranic scholarship and transmission.'**
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
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
