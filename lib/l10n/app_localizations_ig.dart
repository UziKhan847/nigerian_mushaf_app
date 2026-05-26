// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Igbo (`ig`).
class AppLocalizationsIg extends AppLocalizations {
  AppLocalizationsIg([String locale = 'ig']) : super(locale);

  @override
  String get appTitle => 'Mushaf Naịjịrịa';

  @override
  String get appSubtitle => 'المصحف النيجيري';

  @override
  String get appBy => 'site na Quran Quorum';

  @override
  String get navSearch => 'Chọọ';

  @override
  String get navPageIndex => 'Ibe';

  @override
  String get navSurahIndex => 'Sūrah';

  @override
  String get navVerseIndex => 'Amaokwu';

  @override
  String get navTheme => 'Ụdị';

  @override
  String get navPageColour => 'Agba\nibe';

  @override
  String get navVertical => 'Ọtọ';

  @override
  String get navHorizontal => 'Nʼahịrị';

  @override
  String get navScrollMode => 'Ụdị\nịpịgharị';

  @override
  String get navSwipeMode => 'Ụdị\nịhapụ';

  @override
  String get navDualPage => 'Ibe\nabụọ';

  @override
  String get navAbout => 'Maka';

  @override
  String get navZoomPage => 'Mebuo';

  @override
  String get navExitZoom => 'Pụọ\nmmebu';

  @override
  String get navBookmarks => 'Akara';

  @override
  String get navBrightness => 'Ìhè';

  @override
  String get navJuzIndex => 'Juzʾ';

  @override
  String get navLanguage => 'Asụsụ';

  @override
  String get languagePickerTitle => 'Asụsụ';

  @override
  String get surahIndexTitle => 'Ndepụta Sūrah';

  @override
  String get pageIndexTitle => 'Ndepụta Ibe';

  @override
  String get verseIndexTitle => 'Ndepụta Amaokwu';

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
    return 'Ọ na-amalite na $location';
  }

  @override
  String get bookmarksTitle => 'Akara';

  @override
  String bookmarkAdd(int page) {
    return 'Tinye akara nʼibe a ($page)';
  }

  @override
  String bookmarkRemove(int page) {
    return 'Wepụ ibe a ($page)';
  }

  @override
  String get bookmarksEmpty => 'Enwebeghị akara';

  @override
  String bookmarkPage(int page) {
    return 'Ibe $page';
  }

  @override
  String get brightnessTitle => 'Ìhè';

  @override
  String get brightnessHint =>
      'Na-ebelata ìhè ibe maka ịgụ akwụkwọ nʼabalị nke ọma.';

  @override
  String get themePickerTitle => 'Họrọ ụdị';

  @override
  String get themeLight => 'Ìhè';

  @override
  String get themeDark => 'Ọchịchịrị';

  @override
  String get themeWhite => 'Ọcha';

  @override
  String get themeYellowCream => 'Odo dị nro';

  @override
  String get themeOled => 'OLED ojii';

  @override
  String get themeCustom => 'Nke gị';

  @override
  String get colourPickerTitle => 'Agba azụ ibe';

  @override
  String get colourPickerHue => 'Agba';

  @override
  String get colourPickerSaturation => 'Ịdị ọkụ agba';

  @override
  String get colourPickerLightness => 'Ìhè';

  @override
  String get colourPickerPresets => 'Nhọrọ';

  @override
  String get searchHint => 'Chọọ na Mushaf…';

  @override
  String get searchModeQiyas => 'Qiyāsī';

  @override
  String get searchModeUthmani => 'Uthmānī';

  @override
  String get searchModeRoot => 'Mgbọrọgwụ';

  @override
  String searchResultCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Nsonaazụ $count',
      one: 'Nsonaazụ 1',
      zero: 'Enweghị nsonaazụ',
    );
    return '$_temp0';
  }

  @override
  String get searchNoResults => 'Achọtaghị ihe dabara';

  @override
  String searchLoadMore(int remaining) {
    return 'Bulite ọzọ  ($remaining fọdụrụ)';
  }

  @override
  String get searchHintQiyas =>
      'Pịnye ederede Arabic iji jiri nsụpe ọkọlọtọ chọọ.\n\nA na-eleghara tashkīl anya ma e wezuga obere mkpụrụedemede madd.';

  @override
  String get searchHintUthmani =>
      'Pịnye ederede Arabic iji jiri odide Uthmānī chọọ.\n\nA na-ewepụ akara tashkīl niile tupu nhazi.';

  @override
  String get searchHintRoot =>
      'Pịnye mgbọrọgwụ maọbụ isi okwu iji chọta ụdị niile metụtara ya.\n\nA na-ewepụ mmalite na njedebe ndị a na-ahụkarị nʼonwe ha.';

  @override
  String verseLocation(String surah, int verse, int page) {
    return 'Sūrah $surah  ·  amaokwu $verse  ·  ibe $page';
  }

  @override
  String verseHeaderLocation(String surah) {
    return 'Isi Sūrah · $surah';
  }

  @override
  String surahPageRange(int first, int last, int verses) {
    return 'Ibe $first–$last  ·  amaokwu $verses';
  }

  @override
  String get aboutTitle => 'Maka';

  @override
  String get aboutSectionAbout => 'Maka';

  @override
  String get aboutSectionFeatures => 'Atụmatụ';

  @override
  String get aboutSectionTechnical => 'Nka';

  @override
  String get aboutSectionCredits => 'Ekele';

  @override
  String get aboutDescription =>
      'Ngwa Mushaf Naịjịrịa na-egosi ibe 604 niile nke Mushaf Naịjịrịa dị ka onyonyo dị elu, na-echekwa agba mbụ, ịchọ mma, akara tashkīl, na odide Maghribi pụrụ iche nke ọdịnala Naịjịrịa nke ọma. A na-egosi ibe ọ bụla nʼoyiri abụọ — inki na ịchọ mma agba — ka ụdị dị ka Ọchịchịrị na OLED nwee ike ịgbanwe agba ederede nʼemetụghị oke ịchọ mma aka.\n\nMushaf Naịjịrịa bụ otu nʼime ihe odide Quran a na-ejikarị eme ihe na West Africa.';

  @override
  String get aboutCreditsBody =>
      'Quran Quorum mepụtara ya\n\nMushaf Naịjịrịa bụ ihe odide dị nsọ nwere mgbọrọgwụ miri emi nʼọdịnala Quran nke West Africa. Anyị gbalịsiri ike igosi ya na dijitalụ jiri nlekọta na ikwesị ntụkwasị obi.\n\nIkike niile metụtara odide Mushaf Naịjịrịa bụ nke ndị na-elekọta ya.\n\n© Quran Quorum. Ikike niile echekwabara.';

  @override
  String get loadingFailed => 'Ibubata data Mushaf dara';

  @override
  String get featImages =>
      'A na-egosi ibe ọ bụla dị ka onyonyo dị elu nwere oyiri inki na ịchọ mma dị iche';

  @override
  String get featThemes =>
      'Ụdị: Ìhè, Ọcha, Odo dị nro, Ọchịchịrị, OLED ojii, na Nke gị';

  @override
  String get featModes =>
      'Ịgụ nʼọtọ maọbụ nʼahịrị site na ịpịgharị nro maọbụ ịhapụ ibe';

  @override
  String get featDualZoom => 'Ngosi ibe abụọ na ụdị ọgụgụ nwere mmebu';

  @override
  String get featSearch =>
      'Nchọ ederede zuru ezu nʼụdị Qiyāsī, Uthmānī, na mgbọrọgwụ';

  @override
  String get featIndexes =>
      'Ndepụta Sūrah, ibe, na amaokwu maka njegharị ngwa ngwa';

  @override
  String get featBookmarks =>
      'Akara na nmaliteghachi akpaaka nʼibe ikpeazụ ị gụrụ';

  @override
  String get featBrightness =>
      'Mbelata ìhè nʼime ngwa maka ịgụ akwụkwọ nʼabalị';

  @override
  String get techFramework => 'Usoro';

  @override
  String get techState => 'Ọnọdụ';

  @override
  String get techRendering => 'Ngosi';

  @override
  String get techImagesLabel => 'Onyonyo';

  @override
  String get techPagesLabel => 'Ibe';

  @override
  String get aboutCreditsShort => '© Quran Quorum\nIkike niile echekwabara.';

  @override
  String get juzIndexTitle => 'Ndepụta Juzʾ';
}
