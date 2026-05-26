// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'المصحف النيجيري';

  @override
  String get appSubtitle => 'المصحف النيجيري';

  @override
  String get appBy => 'بواسطة Quran Quorum';

  @override
  String get navSearch => 'بحث';

  @override
  String get navPageIndex => 'الصفحات';

  @override
  String get navSurahIndex => 'السور';

  @override
  String get navVerseIndex => 'الآيات';

  @override
  String get navTheme => 'السمة';

  @override
  String get navPageColour => 'لون\nالصفحة';

  @override
  String get navVertical => 'عمودي';

  @override
  String get navHorizontal => 'أفقي';

  @override
  String get navScrollMode => 'وضع\nالتمرير';

  @override
  String get navSwipeMode => 'وضع\nالسحب';

  @override
  String get navDualPage => 'صفحتان';

  @override
  String get navAbout => 'حول';

  @override
  String get navZoomPage => 'تكبير';

  @override
  String get navExitZoom => 'إنهاء\nالتكبير';

  @override
  String get navBookmarks => 'العلامات';

  @override
  String get navBrightness => 'السطوع';

  @override
  String get navJuzIndex => 'الأجزاء';

  @override
  String get navLanguage => 'اللغة';

  @override
  String get languagePickerTitle => 'اللغة';

  @override
  String get surahIndexTitle => 'فهرس السور';

  @override
  String get pageIndexTitle => 'فهرس الصفحات';

  @override
  String get verseIndexTitle => 'فهرس الآيات';

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
    return 'الجزء $num';
  }

  @override
  String juzStartsAt(String location) {
    return 'يبدأ عند $location';
  }

  @override
  String get bookmarksTitle => 'العلامات المرجعية';

  @override
  String bookmarkAdd(int page) {
    return 'حفظ هذه الصفحة ($page)';
  }

  @override
  String bookmarkRemove(int page) {
    return 'إزالة هذه الصفحة ($page)';
  }

  @override
  String get bookmarksEmpty => 'لا توجد علامات بعد';

  @override
  String bookmarkPage(int page) {
    return 'صفحة $page';
  }

  @override
  String get brightnessTitle => 'السطوع';

  @override
  String get brightnessHint => 'يخفّت الصفحة للقراءة المريحة ليلاً.';

  @override
  String get themePickerTitle => 'اختر السمة';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeDark => 'داكن';

  @override
  String get themeWhite => 'أبيض';

  @override
  String get themeYellowCream => 'كريمي';

  @override
  String get themeOled => 'أسود OLED';

  @override
  String get themeCustom => 'مخصص';

  @override
  String get colourPickerTitle => 'لون خلفية الصفحة';

  @override
  String get colourPickerHue => 'التدرّج';

  @override
  String get colourPickerSaturation => 'التشبّع';

  @override
  String get colourPickerLightness => 'الإضاءة';

  @override
  String get colourPickerPresets => 'الإعدادات الجاهزة';

  @override
  String get searchHint => 'ابحث في المصحف…';

  @override
  String get searchModeQiyas => 'قياسي';

  @override
  String get searchModeUthmani => 'عثماني';

  @override
  String get searchModeRoot => 'الجذر';

  @override
  String searchResultCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count نتائج',
      one: 'نتيجة واحدة',
      zero: 'لا نتائج',
    );
    return '$_temp0';
  }

  @override
  String get searchNoResults => 'لا توجد نتائج مطابقة';

  @override
  String searchLoadMore(int remaining) {
    return 'تحميل المزيد  (متبقٍّ $remaining)';
  }

  @override
  String get searchHintQiyas =>
      'اكتب نصًّا عربيًّا للبحث بالإملاء القياسي.\n\nيتم تجاهل التشكيل عدا حروف المدّ الصغيرة.';

  @override
  String get searchHintUthmani =>
      'اكتب نصًّا عربيًّا للبحث بالرسم العثماني.\n\nتُزال جميع علامات التشكيل قبل المطابقة.';

  @override
  String get searchHintRoot =>
      'اكتب جذرًا أو أصلًا لإيجاد جميع الصيغ المتعلقة.\n\nتُزال السوابق واللواحق الشائعة تلقائيًّا.';

  @override
  String verseLocation(String surah, int verse, int page) {
    return 'سورة $surah  ·  آية $verse  ·  صفحة $page';
  }

  @override
  String verseHeaderLocation(String surah) {
    return 'ترويسة سورة · $surah';
  }

  @override
  String surahPageRange(int first, int last, int verses) {
    return 'صفحات $first–$last  ·  $verses آية';
  }

  @override
  String get aboutTitle => 'حول';

  @override
  String get aboutSectionAbout => 'حول';

  @override
  String get aboutSectionFeatures => 'الميزات';

  @override
  String get aboutSectionTechnical => 'تقني';

  @override
  String get aboutSectionCredits => 'شكر وتقدير';

  @override
  String get aboutDescription =>
      'يعرض تطبيق المصحف النيجيري جميع صفحات المصحف النيجيري البالغة 604 صفحة كصور عالية الدقة، محافظًا بأمانة على الألوان الأصلية والتذهيب وعلامات التشكيل والرسم المغربي المميّز للتقليد النيجيري. تُعرض كل صفحة بطبقتين — الحبر والزخرفة الملوّنة — بحيث تستطيع السمات مثل الداكن وOLED إعادة تلوين النص دون المساس بالحدود الزخرفية.\n\nالمصحف النيجيري من أكثر المخطوطات القرآنية استخدامًا في غرب إفريقيا، ويعكس خطه المغربي الفريد قرونًا من العلم القرآني في غرب إفريقيا.';

  @override
  String get aboutCreditsBody =>
      'تطوير Quran Quorum\n\nالمصحف النيجيري مخطوط مقدّس ضارب الجذور في التقليد القرآني لغرب إفريقيا. وقد حرصنا على تمثيله رقميًّا بأقصى عناية وأمانة.\n\nجميع الحقوق المتعلقة بخطّ المصحف النيجيري تعود إلى أصحابها من القائمين عليه والمجتمعات العلمية.\n\n© Quran Quorum. جميع الحقوق محفوظة.';

  @override
  String get loadingFailed => 'فشل تحميل بيانات المصحف';

  @override
  String get featImages =>
      'تُعرض كل صفحة كصورة عالية الدقة بطبقتين منفصلتين للحبر والزخرفة';

  @override
  String get featThemes => 'السمات: فاتح، أبيض، كريمي، داكن، أسود OLED، ومخصص';

  @override
  String get featModes =>
      'قراءة عمودية أو أفقية مع تمرير سلس أو سحب صفحة بصفحة';

  @override
  String get featDualZoom => 'عرض صفحتين ووضع قراءة بالتكبير';

  @override
  String get featSearch => 'بحث في النص الكامل بأنماط قياسي وعثماني والجذر';

  @override
  String get featIndexes => 'فهارس السور والصفحات والآيات للتنقل السريع';

  @override
  String get featBookmarks =>
      'علامات مرجعية واستئناف تلقائي عند آخر صفحة قُرئت';

  @override
  String get featBrightness => 'تخفيت السطوع داخل التطبيق للقراءة الليلية';

  @override
  String get techFramework => 'الإطار';

  @override
  String get techState => 'الحالة';

  @override
  String get techRendering => 'العرض';

  @override
  String get techImagesLabel => 'الصور';

  @override
  String get techPagesLabel => 'الصفحات';

  @override
  String get aboutCreditsShort => '© Quran Quorum\nجميع الحقوق محفوظة.';

  @override
  String get juzIndexTitle => 'فهرس الأجزاء';
}
