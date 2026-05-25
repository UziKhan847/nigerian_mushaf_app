// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Yoruba (`yo`).
class AppLocalizationsYo extends AppLocalizations {
  AppLocalizationsYo([String locale = 'yo']) : super(locale);

  @override
  String get appTitle => 'Mushaf Naijiria';

  @override
  String get appSubtitle => 'المصحف النيجيري';

  @override
  String get appBy => 'láti ọwọ́ Quran Quorum';

  @override
  String get navSearch => 'Wá';

  @override
  String get navPageIndex => 'Àwọn ojú-ìwé';

  @override
  String get navSurahIndex => 'Àwọn Sūrah';

  @override
  String get navVerseIndex => 'Àwọn ẹsẹ';

  @override
  String get navTheme => 'Àwòrán';

  @override
  String get navPageColour => 'Àwọ̀\nojú-ìwé';

  @override
  String get navVertical => 'Ní gígùn';

  @override
  String get navHorizontal => 'Ní fífẹ̀';

  @override
  String get navScrollMode => 'Ìpòpadà\nyíyí';

  @override
  String get navSwipeMode => 'Ìpòpadà\nfífà';

  @override
  String get navDualPage => 'Ojú-ìwé\nméjì';

  @override
  String get navAbout => 'Nípa';

  @override
  String get navZoomPage => 'Fẹ̀';

  @override
  String get navExitZoom => 'Jáde\nfífẹ̀';

  @override
  String get navBookmarks => 'Àmì-ìwé';

  @override
  String get navBrightness => 'Ìmọ́lẹ̀';

  @override
  String get navJuzIndex => 'Juzʾ';

  @override
  String get navLanguage => 'Èdè';

  @override
  String get languagePickerTitle => 'Èdè';

  @override
  String get surahIndexTitle => 'Àtọ́ka Sūrah';

  @override
  String get pageIndexTitle => 'Àtọ́ka Ojú-ìwé';

  @override
  String get verseIndexTitle => 'Àtọ́ka Ẹsẹ';

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
    return 'Ó bẹ̀rẹ̀ ní $location';
  }

  @override
  String get bookmarksTitle => 'Àwọn àmì-ìwé';

  @override
  String bookmarkAdd(int page) {
    return 'Fi àmì sí ojú-ìwé yìí ($page)';
  }

  @override
  String bookmarkRemove(int page) {
    return 'Yọ ojú-ìwé yìí kúrò ($page)';
  }

  @override
  String get bookmarksEmpty => 'Kò sí àmì-ìwé síbẹ̀';

  @override
  String bookmarkPage(int page) {
    return 'Ojú-ìwé $page';
  }

  @override
  String get brightnessTitle => 'Ìmọ́lẹ̀';

  @override
  String get brightnessHint =>
      'Ó ń dín ìmọ́lẹ̀ ojú-ìwé kù fún kíkà alẹ́ tí ó rọrùn.';

  @override
  String get themePickerTitle => 'Yan àwòrán';

  @override
  String get themeLight => 'Ìmọ́lẹ̀';

  @override
  String get themeDark => 'Òkùnkùn';

  @override
  String get themeWhite => 'Funfun';

  @override
  String get themeYellowCream => 'Àwọ̀ ìpara';

  @override
  String get themeOled => 'Dúdú OLED';

  @override
  String get themeCustom => 'Tìrẹ';

  @override
  String get colourPickerTitle => 'Àwọ̀ ẹ̀yìn ojú-ìwé';

  @override
  String get colourPickerHue => 'Àwọ̀';

  @override
  String get colourPickerSaturation => 'Kíkún àwọ̀';

  @override
  String get colourPickerLightness => 'Ìmọ́lẹ̀';

  @override
  String get colourPickerPresets => 'Àwọn ìtò';

  @override
  String get searchHint => 'Wá nínú Mushaf…';

  @override
  String get searchModeQiyas => 'Qiyāsī';

  @override
  String get searchModeUthmani => 'Uthmānī';

  @override
  String get searchModeRoot => 'Gbòǹgbò';

  @override
  String searchResultCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Àbájáde $count',
      one: 'Àbájáde 1',
      zero: 'Kò sí àbájáde',
    );
    return '$_temp0';
  }

  @override
  String get searchNoResults => 'Kò sí ìbámu';

  @override
  String searchLoadMore(int remaining) {
    return 'Ká síwájú  ($remaining ṣẹ́kù)';
  }

  @override
  String get searchHintQiyas =>
      'Tẹ ọ̀rọ̀ Lárúbáwá láti wá nípa àkọtọ́ déédéé.\n\nA ó fojú fo tashkīl àyàfi àwọn lẹ́tà madd kékeré.';

  @override
  String get searchHintUthmani =>
      'Tẹ ọ̀rọ̀ Lárúbáwá láti wá nípa àkọsílẹ̀ Uthmānī.\n\nA ó yọ gbogbo àmì tashkīl kúrò kí a tó wá.';

  @override
  String get searchHintRoot =>
      'Tẹ gbòǹgbò tàbí ìpìlẹ̀ ọ̀rọ̀ láti rí gbogbo ìrísí tó bá jọ.\n\nA ó yọ àwọn ìṣáájú àti ìkẹyìn tó wọ́pọ̀ kúrò fúnra rẹ̀.';

  @override
  String verseLocation(String surah, int verse, int page) {
    return 'Sūrah $surah  ·  ẹsẹ $verse  ·  ojú-ìwé $page';
  }

  @override
  String verseHeaderLocation(String surah) {
    return 'Orí Sūrah · $surah';
  }

  @override
  String surahPageRange(int first, int last, int verses) {
    return 'Ojú-ìwé $first–$last  ·  ẹsẹ $verses';
  }

  @override
  String get aboutTitle => 'Nípa';

  @override
  String get aboutSectionAbout => 'Nípa';

  @override
  String get aboutSectionFeatures => 'Àwọn ẹ̀yà';

  @override
  String get aboutSectionTechnical => 'Ìmọ̀-ẹ̀rọ';

  @override
  String get aboutSectionCredits => 'Ọpẹ́';

  @override
  String get aboutDescription =>
      'Ohun-èlò Mushaf Naijiria ń ṣàfihàn gbogbo ojú-ìwé 604 ti Mushaf Naijiria gẹ́gẹ́ bí àwòrán onípé-gíga, ó ń pa àwọ̀ ìpilẹ̀ṣẹ̀, ìṣaralọ́ṣọ̀ọ́, àwọn àmì tashkīl, àti àkọsílẹ̀ Maghribi àrà-ọ̀tọ̀ ti àṣà Naijiria mọ́. A ń ṣàfihàn ojú-ìwé kọ̀ọ̀kan ní ìpele méjì — tàdáwà àti ìṣaralọ́ṣọ̀ọ́ aláwọ̀ — kí àwọn àwòrán bíi Òkùnkùn àti OLED lè ṣàtúnṣe àwọ̀ ọ̀rọ̀ láìfọwọ́kan àwọn ààlà ọ̀ṣọ́.\n\nMushaf Naijiria jẹ́ ọ̀kan lára àwọn ìwé Kùránì tí a ń lò jùlọ ní Ìwọ̀-Oòrùn Áfíríkà.';

  @override
  String get aboutCreditsBody =>
      'Quran Quorum ló ṣe é\n\nMushaf Naijiria jẹ́ ìwé mímọ́ tó ní gbòǹgbò jíjìn nínú àṣà Kùránì ti Ìwọ̀-Oòrùn Áfíríkà. A ti sapá láti ṣàfihàn rẹ̀ ní díjítà pẹ̀lú ìtọ́jú àti òtítọ́ gíga.\n\nGbogbo ẹ̀tọ́ sí àkọsílẹ̀ Mushaf Naijiria jẹ́ ti àwọn olùtọ́jú rẹ̀.\n\n© Quran Quorum. Gbogbo ẹ̀tọ́ ni a pamọ́.';

  @override
  String get loadingFailed => 'Kíkó dátà Mushaf kùnà';

  @override
  String get featImages =>
      'Ojú-ìwé kọ̀ọ̀kan ni a fi hàn gẹ́gẹ́ bí àwòrán onípé-gíga pẹ̀lú ìpele tàdáwà àti ọ̀ṣọ́ ọ̀tọ̀ọ̀tọ̀';

  @override
  String get featThemes =>
      'Àwòrán: Ìmọ́lẹ̀, Funfun, Àwọ̀ ìpara, Òkùnkùn, Dúdú OLED, àti Tìrẹ';

  @override
  String get featModes =>
      'Kíkà ní gígùn tàbí fífẹ̀ pẹ̀lú yíyí rírọrùn tàbí fífà ojú-ìwé';

  @override
  String get featDualZoom => 'Ìfihàn ojú-ìwé méjì àti ọ̀nà kíkà pẹ̀lú fífẹ̀';

  @override
  String get featSearch =>
      'Ìwáàrí ọ̀rọ̀ kíkún ní ọ̀nà Qiyāsī, Uthmānī, àti gbòǹgbò';

  @override
  String get featIndexes => 'Àtọ́ka Sūrah, ojú-ìwé, àti ẹsẹ fún ìrìnàjò kíákíá';

  @override
  String get featBookmarks =>
      'Àwọn àmì-ìwé àti ìbẹ̀rẹ̀-padà sí ojú-ìwé tí o kà kẹ́yìn';

  @override
  String get featBrightness => 'Dídín ìmọ́lẹ̀ kù nínú ohun-èlò fún kíkà alẹ́';

  @override
  String get techFramework => 'Ìlànà';

  @override
  String get techState => 'Ipò';

  @override
  String get techRendering => 'Ìfihàn';

  @override
  String get techImagesLabel => 'Àwòrán';

  @override
  String get techPagesLabel => 'Ojú-ìwé';

  @override
  String get aboutCreditsShort => '© Quran Quorum\nGbogbo ẹ̀tọ́ ni a pamọ́.';
}
