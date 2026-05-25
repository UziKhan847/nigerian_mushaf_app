// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Mushaf Nigérian';

  @override
  String get appSubtitle => 'المصحف النيجيري';

  @override
  String get appBy => 'par Quran Quorum';

  @override
  String get navSearch => 'Recher\ncher';

  @override
  String get navPageIndex => 'Pages';

  @override
  String get navSurahIndex => 'Sourates';

  @override
  String get navVerseIndex => 'Versets';

  @override
  String get navTheme => 'Thème';

  @override
  String get navPageColour => 'Couleur\nde page';

  @override
  String get navVertical => 'Vertical';

  @override
  String get navHorizontal => 'Horizontal';

  @override
  String get navScrollMode => 'Mode\ndéfilement';

  @override
  String get navSwipeMode => 'Mode\nbalayage';

  @override
  String get navDualPage => 'Double\npage';

  @override
  String get navAbout => 'À propos';

  @override
  String get navZoomPage => 'Zoom';

  @override
  String get navExitZoom => 'Quitter\nzoom';

  @override
  String get navBookmarks => 'Signets';

  @override
  String get navBrightness => 'Lumino\nsité';

  @override
  String get navJuzIndex => 'Juz';

  @override
  String get navLanguage => 'Langue';

  @override
  String get languagePickerTitle => 'Langue';

  @override
  String get surahIndexTitle => 'Index des sourates';

  @override
  String get pageIndexTitle => 'Index des pages';

  @override
  String get verseIndexTitle => 'Index des versets';

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
    return 'Commence à $location';
  }

  @override
  String get bookmarksTitle => 'Signets';

  @override
  String bookmarkAdd(int page) {
    return 'Ajouter cette page ($page)';
  }

  @override
  String bookmarkRemove(int page) {
    return 'Retirer cette page ($page)';
  }

  @override
  String get bookmarksEmpty => 'Aucun signet';

  @override
  String bookmarkPage(int page) {
    return 'Page $page';
  }

  @override
  String get brightnessTitle => 'Luminosité';

  @override
  String get brightnessHint =>
      'Assombrit la page pour une lecture nocturne confortable.';

  @override
  String get themePickerTitle => 'Choisir le thème';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get themeWhite => 'Blanc';

  @override
  String get themeYellowCream => 'Crème';

  @override
  String get themeOled => 'Noir OLED';

  @override
  String get themeCustom => 'Personnalisé';

  @override
  String get colourPickerTitle => 'Couleur de fond de page';

  @override
  String get colourPickerHue => 'Teinte';

  @override
  String get colourPickerSaturation => 'Saturation';

  @override
  String get colourPickerLightness => 'Luminosité';

  @override
  String get colourPickerPresets => 'Préréglages';

  @override
  String get searchHint => 'Rechercher dans le Mushaf…';

  @override
  String get searchModeQiyas => 'Qiyāsī';

  @override
  String get searchModeUthmani => 'Uthmānī';

  @override
  String get searchModeRoot => 'Racine';

  @override
  String searchResultCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count résultats',
      one: '1 résultat',
      zero: 'Aucun résultat',
    );
    return '$_temp0';
  }

  @override
  String get searchNoResults => 'Aucune correspondance';

  @override
  String searchLoadMore(int remaining) {
    return 'Charger plus  ($remaining restants)';
  }

  @override
  String get searchHintQiyas =>
      'Saisissez du texte arabe pour rechercher selon l’orthographe standard.\n\nLe tashkīl (diacritiques) est ignoré, sauf les petites lettres de madd.';

  @override
  String get searchHintUthmani =>
      'Saisissez du texte arabe pour rechercher selon l’écriture Uthmānī.\n\nTous les diacritiques sont retirés avant la recherche.';

  @override
  String get searchHintRoot =>
      'Saisissez une racine ou un radical pour trouver toutes les formes apparentées.\n\nLes préfixes et suffixes courants sont retirés automatiquement.';

  @override
  String verseLocation(String surah, int verse, int page) {
    return 'Sourate $surah  ·  verset $verse  ·  page $page';
  }

  @override
  String verseHeaderLocation(String surah) {
    return 'En-tête de sourate · $surah';
  }

  @override
  String surahPageRange(int first, int last, int verses) {
    return 'Pages $first–$last  ·  $verses versets';
  }

  @override
  String get aboutTitle => 'À propos';

  @override
  String get aboutSectionAbout => 'À propos';

  @override
  String get aboutSectionFeatures => 'Fonctionnalités';

  @override
  String get aboutSectionTechnical => 'Technique';

  @override
  String get aboutSectionCredits => 'Crédits';

  @override
  String get aboutDescription =>
      'L’application Mushaf Nigérian présente les 604 pages du Mushaf nigérian sous forme d’images haute résolution, préservant fidèlement les couleurs d’origine, la rubrication, les diacritiques et l’orthographe maghrébine distinctive de la tradition nigériane. Chaque page est rendue en deux couches — l’encre et la décoration colorée — afin que les thèmes comme Sombre et OLED puissent recolorer le texte sans toucher aux bordures décoratives.\n\nLe Mushaf nigérian est l’un des manuscrits coraniques les plus utilisés en Afrique de l’Ouest. Son écriture maghrébine unique reflète des siècles d’érudition coranique ouest-africaine.';

  @override
  String get aboutCreditsBody =>
      'Développé par Quran Quorum\n\nLe Mushaf nigérian est un manuscrit sacré profondément enraciné dans la tradition coranique ouest-africaine. Nous nous sommes efforcés de le représenter numériquement avec le plus grand soin et fidélité.\n\nTous les droits sur l’écriture du Mushaf nigérian appartiennent à leurs gardiens et communautés savantes respectifs.\n\n© Quran Quorum. Tous droits réservés.';

  @override
  String get loadingFailed => 'Échec du chargement des données du Mushaf';

  @override
  String get featImages =>
      'Chaque page affichée en image haute résolution avec des couches d’encre et de décoration distinctes';

  @override
  String get featThemes =>
      'Thèmes : Clair, Blanc, Crème, Sombre, Noir OLED et Personnalisé';

  @override
  String get featModes =>
      'Lecture verticale ou horizontale, défilement fluide ou balayage page par page';

  @override
  String get featDualZoom =>
      'Affichage en double page et mode de lecture avec zoom';

  @override
  String get featSearch =>
      'Recherche plein texte en modes Qiyāsī, Uthmānī et racine';

  @override
  String get featIndexes =>
      'Index des sourates, des pages et des versets pour une navigation rapide';

  @override
  String get featBookmarks =>
      'Signets et reprise automatique à la dernière page lue';

  @override
  String get featBrightness =>
      'Atténuation de la luminosité intégrée pour la lecture nocturne';

  @override
  String get techFramework => 'Cadriciel';

  @override
  String get techState => 'État';

  @override
  String get techRendering => 'Rendu';

  @override
  String get techImagesLabel => 'Images';

  @override
  String get techPagesLabel => 'Pages';

  @override
  String get aboutCreditsShort => '© Quran Quorum\nTous droits réservés.';
}
