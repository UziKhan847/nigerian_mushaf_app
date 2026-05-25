// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hausa (`ha`).
class AppLocalizationsHa extends AppLocalizations {
  AppLocalizationsHa([String locale = 'ha']) : super(locale);

  @override
  String get appTitle => 'Mushaf na Najeriya';

  @override
  String get appSubtitle => 'المصحف النيجيري';

  @override
  String get appBy => 'daga Quran Quorum';

  @override
  String get navSearch => 'Bincike';

  @override
  String get navPageIndex => 'Shafuka';

  @override
  String get navSurahIndex => 'Surori';

  @override
  String get navVerseIndex => 'Ayoyi';

  @override
  String get navTheme => 'Salo';

  @override
  String get navPageColour => 'Launin\nshafi';

  @override
  String get navVertical => 'A tsaye';

  @override
  String get navHorizontal => 'A kwance';

  @override
  String get navScrollMode => 'Yanayin\nzazzagewa';

  @override
  String get navSwipeMode => 'Yanayin\ngoge';

  @override
  String get navDualPage => 'Shafi\nbiyu';

  @override
  String get navAbout => 'Game da';

  @override
  String get navZoomPage => 'Girmama';

  @override
  String get navExitZoom => 'Fita\ngirmama';

  @override
  String get navBookmarks => 'Alamomi';

  @override
  String get navBrightness => 'Haske';

  @override
  String get navJuzIndex => 'Juzu’i';

  @override
  String get navLanguage => 'Harshe';

  @override
  String get languagePickerTitle => 'Harshe';

  @override
  String get surahIndexTitle => 'Jerin Surori';

  @override
  String get pageIndexTitle => 'Jerin Shafuka';

  @override
  String get verseIndexTitle => 'Jerin Ayoyi';

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
    return 'Juzu’i $num';
  }

  @override
  String juzStartsAt(String location) {
    return 'Yana farawa a $location';
  }

  @override
  String get bookmarksTitle => 'Alamomi';

  @override
  String bookmarkAdd(int page) {
    return 'Yi alama ga wannan shafi ($page)';
  }

  @override
  String bookmarkRemove(int page) {
    return 'Cire wannan shafi ($page)';
  }

  @override
  String get bookmarksEmpty => 'Babu alamomi tukuna';

  @override
  String bookmarkPage(int page) {
    return 'Shafi $page';
  }

  @override
  String get brightnessTitle => 'Haske';

  @override
  String get brightnessHint =>
      'Yana rage haske don karatun dare cikin kwanciyar hankali.';

  @override
  String get themePickerTitle => 'Zaɓi salo';

  @override
  String get themeLight => 'Haske';

  @override
  String get themeDark => 'Duhu';

  @override
  String get themeWhite => 'Fari';

  @override
  String get themeYellowCream => 'Rawaya mai laushi';

  @override
  String get themeOled => 'Baƙin OLED';

  @override
  String get themeCustom => 'Na kanka';

  @override
  String get colourPickerTitle => 'Launin bayan shafi';

  @override
  String get colourPickerHue => 'Inuwa';

  @override
  String get colourPickerSaturation => 'Ƙarfin launi';

  @override
  String get colourPickerLightness => 'Haske';

  @override
  String get colourPickerPresets => 'Zaɓuɓɓuka';

  @override
  String get searchHint => 'Bincika Mushaf…';

  @override
  String get searchModeQiyas => 'Qiyāsī';

  @override
  String get searchModeUthmani => 'Uthmānī';

  @override
  String get searchModeRoot => 'Saiwa';

  @override
  String searchResultCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Sakamako $count',
      one: 'Sakamako 1',
      zero: 'Babu sakamako',
    );
    return '$_temp0';
  }

  @override
  String get searchNoResults => 'Ba a sami daidaito ba';

  @override
  String searchLoadMore(int remaining) {
    return 'Ɗora ƙari  (saura $remaining)';
  }

  @override
  String get searchHintQiyas =>
      'Rubuta rubutun Larabci don bincike ta hanyar daidaitaccen rubutu.\n\nAna yin watsi da tashkīl sai ƙananan harrufan madd.';

  @override
  String get searchHintUthmani =>
      'Rubuta rubutun Larabci don bincike ta rubutun Uthmānī.\n\nAna cire dukkan alamomin tashkīl kafin daidaitawa.';

  @override
  String get searchHintRoot =>
      'Rubuta saiwa ko tushen kalma don nemo dukkan siffofi masu alaƙa.\n\nAna cire ƙa’idodin gaba da baya kai tsaye.';

  @override
  String verseLocation(String surah, int verse, int page) {
    return 'Surah $surah  ·  aya $verse  ·  shafi $page';
  }

  @override
  String verseHeaderLocation(String surah) {
    return 'Kan surah · $surah';
  }

  @override
  String surahPageRange(int first, int last, int verses) {
    return 'Shafuka $first–$last  ·  ayoyi $verses';
  }

  @override
  String get aboutTitle => 'Game da';

  @override
  String get aboutSectionAbout => 'Game da';

  @override
  String get aboutSectionFeatures => 'Fasaloli';

  @override
  String get aboutSectionTechnical => 'Fasaha';

  @override
  String get aboutSectionCredits => 'Godiya';

  @override
  String get aboutDescription =>
      'Manhajar Mushaf na Najeriya tana nuna dukkan shafuka 604 na Mushaf na Najeriya a matsayin hotuna masu inganci, tana kiyaye launukan asali, ado, alamomin tashkīl, da rubutun Maghribi na al’adar Najeriya. Ana nuna kowane shafi a yadudduka biyu — tawada da ado mai launi — domin salo kamar Duhu da OLED su sake launin rubutu ba tare da taɓa iyakokin ado ba.\n\nMushaf na Najeriya na ɗaya daga cikin rubuce-rubucen Alƙur’ani da aka fi amfani da su a Yammacin Afirka.';

  @override
  String get aboutCreditsBody =>
      'An ƙera shi daga Quran Quorum\n\nMushaf na Najeriya rubutu ne mai tsarki da ke da zurfin tushe a al’adar Alƙur’ani ta Yammacin Afirka. Mun yi ƙoƙari mu wakilta shi a dijital da matuƙar kulawa.\n\nDukkan haƙƙin rubutun Mushaf na Najeriya na masu kula da shi ne.\n\n© Quran Quorum. An kiyaye dukkan haƙƙoƙi.';

  @override
  String get loadingFailed => 'An kasa loda bayanan Mushaf';

  @override
  String get featImages =>
      'Ana nuna kowane shafi a matsayin hoto mai inganci da yadudduka daban na tawada da ado';

  @override
  String get featThemes =>
      'Salo: Haske, Fari, Rawaya mai laushi, Duhu, Baƙin OLED, da Na kanka';

  @override
  String get featModes =>
      'Karatu a tsaye ko a kwance da zazzagewa mai laushi ko gogewa shafi-shafi';

  @override
  String get featDualZoom => 'Nuni shafi biyu da yanayin karatu mai girmamawa';

  @override
  String get featSearch =>
      'Bincike cikakke a yanayin Qiyāsī, Uthmānī, da saiwa';

  @override
  String get featIndexes =>
      'Jerin surori, shafuka, da ayoyi don saurin kewayawa';

  @override
  String get featBookmarks =>
      'Alamomi da ci gaba ta atomatik a shafin ƙarshe da ka karanta';

  @override
  String get featBrightness => 'Rage haske cikin manhaja don karatun dare';

  @override
  String get techFramework => 'Tsari';

  @override
  String get techState => 'Yanayi';

  @override
  String get techRendering => 'Nunawa';

  @override
  String get techImagesLabel => 'Hotuna';

  @override
  String get techPagesLabel => 'Shafuka';

  @override
  String get aboutCreditsShort => '© Quran Quorum\nAn kiyaye dukkan haƙƙoƙi.';
}
