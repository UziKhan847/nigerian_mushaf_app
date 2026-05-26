// Mushaf surah & juz index data (604-page Madani layout).
// Page numbers are 1-based start pages.

class SurahInfo {
  final int number;
  final String name;   // transliterated
  final String nameAr; // Arabic with tashkīl
  final int verses;
  final int page;      // 1-based start page
  const SurahInfo(this.number, this.name, this.nameAr, this.verses, this.page);
}

class JuzInfo {
  final int number;
  final String startsAt;
  final int page;
  const JuzInfo(this.number, this.startsAt, this.page);
}

const List<SurahInfo> surahList = [
  SurahInfo(1, "Al-Fātiḥah", "الفَاتِحَة", 7, 1),
  SurahInfo(2, "Al-Baqarah", "البَقَرَة", 286, 2),
  SurahInfo(3, "Āl ʿImrān", "آل عِمْرَان", 200, 50),
  SurahInfo(4, "An-Nisāʾ", "النِّسَاء", 176, 77),
  SurahInfo(5, "Al-Māʾidah", "المَائِدَة", 120, 106),
  SurahInfo(6, "Al-Anʿām", "الأَنْعَام", 165, 128),
  SurahInfo(7, "Al-Aʿrāf", "الأَعْرَاف", 206, 151),
  SurahInfo(8, "Al-Anfāl", "الأَنْفَال", 75, 177),
  SurahInfo(9, "At-Tawbah", "التَّوْبَة", 129, 187),
  SurahInfo(10, "Yūnus", "يُونُس", 109, 208),
  SurahInfo(11, "Hūd", "هُود", 123, 221),
  SurahInfo(12, "Yūsuf", "يُوسُف", 111, 235),
  SurahInfo(13, "Ar-Raʿd", "الرَّعْد", 43, 249),
  SurahInfo(14, "Ibrāhīm", "إِبْرَاهِيم", 52, 255),
  SurahInfo(15, "Al-Ḥijr", "الحِجْر", 99, 262),
  SurahInfo(16, "An-Naḥl", "النَّحْل", 128, 267),
  SurahInfo(17, "Al-Isrāʾ", "الإِسْرَاء", 111, 282),
  SurahInfo(18, "Al-Kahf", "الكَهْف", 110, 293),
  SurahInfo(19, "Maryam", "مَرْيَم", 98, 305),
  SurahInfo(20, "Tā-Hā", "طٰه", 135, 312),
  SurahInfo(21, "Al-Anbiyāʾ", "الأَنْبِيَاء", 112, 322),
  SurahInfo(22, "Al-Ḥajj", "الحَجّ", 78, 332),
  SurahInfo(23, "Al-Muʾminūn", "المُؤْمِنُون", 118, 342),
  SurahInfo(24, "An-Nūr", "النُّور", 64, 350),
  SurahInfo(25, "Al-Furqān", "الفُرْقَان", 77, 359),
  SurahInfo(26, "Ash-Shuʿarāʾ", "الشُّعَرَاء", 227, 367),
  SurahInfo(27, "An-Naml", "النَّمْل", 93, 377),
  SurahInfo(28, "Al-Qaṣaṣ", "القَصَص", 88, 385),
  SurahInfo(29, "Al-ʿAnkabūt", "العَنْكَبُوت", 69, 396),
  SurahInfo(30, "Ar-Rūm", "الرُّوم", 60, 404),
  SurahInfo(31, "Luqmān", "لُقْمَان", 34, 411),
  SurahInfo(32, "As-Sajdah", "السَّجْدَة", 30, 415),
  SurahInfo(33, "Al-Aḥzāb", "الأَحْزَاب", 73, 418),
  SurahInfo(34, "Sabaʾ", "سَبَأ", 54, 428),
  SurahInfo(35, "Fāṭir", "فَاطِر", 45, 434),
  SurahInfo(36, "Yā-Sīn", "يٰس", 83, 440),
  SurahInfo(37, "As-Sāffāt", "الصَّافَّات", 182, 446),
  SurahInfo(38, "Ṣād", "ص", 88, 453),
  SurahInfo(39, "Az-Zumar", "الزُّمَر", 75, 458),
  SurahInfo(40, "Ghāfir", "غَافِر", 85, 467),
  SurahInfo(41, "Fuṣṣilat", "فُصِّلَت", 54, 477),
  SurahInfo(42, "Ash-Shūrā", "الشُّورَىٰ", 53, 483),
  SurahInfo(43, "Az-Zukhruf", "الزُّخْرُف", 89, 489),
  SurahInfo(44, "Ad-Dukhān", "الدُّخَان", 59, 496),
  SurahInfo(45, "Al-Jāthiyah", "الجَاثِيَة", 37, 499),
  SurahInfo(46, "Al-Aḥqāf", "الأَحْقَاف", 35, 502),
  SurahInfo(47, "Muḥammad", "مُحَمَّد", 38, 507),
  SurahInfo(48, "Al-Fatḥ", "الفَتْح", 29, 511),
  SurahInfo(49, "Al-Ḥujurāt", "الحُجُرَات", 18, 515),
  SurahInfo(50, "Qāf", "ق", 45, 518),
  SurahInfo(51, "Adh-Dhāriyāt", "الذَّارِيَات", 60, 520),
  SurahInfo(52, "At-Ṭūr", "الطُّور", 49, 523),
  SurahInfo(53, "An-Najm", "النَّجْم", 62, 526),
  SurahInfo(54, "Al-Qamar", "القَمَر", 55, 528),
  SurahInfo(55, "Ar-Raḥmān", "الرَّحْمٰن", 78, 531),
  SurahInfo(56, "Al-Wāqiʿah", "الوَاقِعَة", 96, 534),
  SurahInfo(57, "Al-Ḥadīd", "الحَدِيد", 29, 537),
  SurahInfo(58, "Al-Mujādilah", "المُجَادِلَة", 22, 542),
  SurahInfo(59, "Al-Ḥashr", "الحَشْر", 24, 545),
  SurahInfo(60, "Al-Mumtaḥanah", "المُمْتَحَنَة", 13, 549),
  SurahInfo(61, "As-Ṣaff", "الصَّفّ", 14, 551),
  SurahInfo(62, "Al-Jumuʿah", "الجُمُعَة", 11, 553),
  SurahInfo(63, "Al-Munāfiqūn", "المُنَافِقُون", 11, 554),
  SurahInfo(64, "At-Taghābun", "التَّغَابُن", 18, 556),
  SurahInfo(65, "At-Talāq", "الطَّلَاق", 12, 558),
  SurahInfo(66, "At-Taḥrīm", "التَّحْرِيم", 12, 560),
  SurahInfo(67, "Al-Mulk", "المُلْك", 30, 562),
  SurahInfo(68, "Al-Qalam", "القَلَم", 52, 564),
  SurahInfo(69, "Al-Ḥāqqah", "الحَاقَّة", 52, 566),
  SurahInfo(70, "Al-Maʿārij", "المَعَارِج", 44, 568),
  SurahInfo(71, "Nūḥ", "نُوح", 28, 570),
  SurahInfo(72, "Al-Jinn", "الجِنّ", 28, 572),
  SurahInfo(73, "Al-Muzzammil", "المُزَّمِّل", 20, 574),
  SurahInfo(74, "Al-Muddaththir", "المُدَّثِّر", 56, 575),
  SurahInfo(75, "Al-Qiyāmah", "القِيَامَة", 40, 577),
  SurahInfo(76, "Al-Insān", "الإِنْسَان", 31, 578),
  SurahInfo(77, "Al-Mursalāt", "المُرْسَلَات", 50, 580),
  SurahInfo(78, "An-Nabaʾ", "النَّبَأ", 40, 582),
  SurahInfo(79, "An-Nāziʿāt", "النَّازِعَات", 46, 583),
  SurahInfo(80, "ʿAbasa", "عَبَس", 42, 585),
  SurahInfo(81, "At-Takwīr", "التَّكْوِير", 29, 586),
  SurahInfo(82, "Al-Infiṭār", "الانْفِطَار", 19, 587),
  SurahInfo(83, "Al-Muṭaffifīn", "المُطَفِّفِين", 36, 587),
  SurahInfo(84, "Al-Inshiqāq", "الانْشِقَاق", 25, 589),
  SurahInfo(85, "Al-Burūj", "البُرُوج", 22, 590),
  SurahInfo(86, "At-Ṭāriq", "الطَّارِق", 17, 591),
  SurahInfo(87, "Al-Aʿlā", "الأَعْلَىٰ", 19, 591),
  SurahInfo(88, "Al-Ghāshiyah", "الغَاشِيَة", 26, 592),
  SurahInfo(89, "Al-Fajr", "الفَجْر", 30, 593),
  SurahInfo(90, "Al-Balad", "البَلَد", 20, 594),
  SurahInfo(91, "Ash-Shams", "الشَّمْس", 15, 595),
  SurahInfo(92, "Al-Layl", "اللَّيْل", 21, 595),
  SurahInfo(93, "Ad-Duḥā", "الضُّحَىٰ", 11, 596),
  SurahInfo(94, "Ash-Sharḥ", "الشَّرْح", 8, 596),
  SurahInfo(95, "At-Tīn", "التِّين", 8, 597),
  SurahInfo(96, "Al-ʿAlaq", "العَلَق", 19, 597),
  SurahInfo(97, "Al-Qadr", "القَدْر", 5, 598),
  SurahInfo(98, "Al-Bayyinah", "البَيِّنَة", 8, 598),
  SurahInfo(99, "Az-Zalzalah", "الزَّلْزَلَة", 8, 599),
  SurahInfo(100, "Al-ʿĀdiyāt", "العَادِيَات", 11, 599),
  SurahInfo(101, "Al-Qāriʿah", "القَارِعَة", 11, 600),
  SurahInfo(102, "At-Takāthur", "التَّكَاثُر", 8, 600),
  SurahInfo(103, "Al-ʿAṣr", "العَصْر", 3, 601),
  SurahInfo(104, "Al-Humazah", "الهُمَزَة", 9, 601),
  SurahInfo(105, "Al-Fīl", "الفِيل", 5, 601),
  SurahInfo(106, "Quraysh", "قُرَيْش", 4, 602),
  SurahInfo(107, "Al-Māʿūn", "المَاعُون", 7, 602),
  SurahInfo(108, "Al-Kawthar", "الكَوْثَر", 3, 602),
  SurahInfo(109, "Al-Kāfirūn", "الكَافِرُون", 6, 603),
  SurahInfo(110, "An-Naṣr", "النَّصْر", 3, 603),
  SurahInfo(111, "Al-Maṣad", "المَسَد", 5, 603),
  SurahInfo(112, "Al-Ikhlāṣ", "الإِخْلَاص", 4, 604),
  SurahInfo(113, "Al-Falaq", "الفَلَق", 5, 604),
  SurahInfo(114, "An-Nās", "النَّاس", 6, 604),
];

const List<JuzInfo> juzList = [
  JuzInfo(1, "Al-Fātiḥah 1:1", 1),
  JuzInfo(2, "Al-Baqarah 2:142", 22),
  JuzInfo(3, "Al-Baqarah 2:253", 42),
  JuzInfo(4, "Āl ʿImrān 3:92", 62),
  JuzInfo(5, "An-Nisāʾ 4:24", 82),
  JuzInfo(6, "An-Nisāʾ 4:148", 102),
  JuzInfo(7, "Al-Māʾidah 5:77", 121),
  JuzInfo(8, "Al-Anʿām 6:111", 142),
  JuzInfo(9, "Al-Aʿrāf 7:88", 162),
  JuzInfo(10, "Al-Anfāl 8:41", 182),
  JuzInfo(11, "At-Tawbah 9:87", 201),
  JuzInfo(12, "Hūd 11:6", 222),
  JuzInfo(13, "Yūsuf 12:53", 242),
  JuzInfo(14, "Al-Ḥijr 15:1", 262),
  JuzInfo(15, "Al-Isrāʾ 17:1", 282),
  JuzInfo(16, "Al-Kahf 18:75", 302),
  JuzInfo(17, "Al-Anbiyāʾ 21:1", 322),
  JuzInfo(18, "Al-Muʾminūn 23:1", 342),
  JuzInfo(19, "Al-Furqān 25:21", 362),
  JuzInfo(20, "An-Naml 27:56", 382),
  JuzInfo(21, "Al-ʿAnkabūt 29:46", 402),
  JuzInfo(22, "Al-Aḥzāb 33:31", 422),
  JuzInfo(23, "Yā-Sīn 36:28", 442),
  JuzInfo(24, "Az-Zumar 39:32", 462),
  JuzInfo(25, "Fuṣṣilat 41:47", 482),
  JuzInfo(26, "Al-Jāthiyah 45:33", 502),
  JuzInfo(27, "Adh-Dhāriyāt 51:31", 522),
  JuzInfo(28, "Al-Mujādilah 58:1", 542),
  JuzInfo(29, "Al-Mulk 67:1", 562),
  JuzInfo(30, "An-Nabaʾ 78:1", 582),
];

/// Arabic-Indic digits for a non-negative integer (e.g. 30 → ٣٠).
String toArabicDigits(int n) {
  const d = ['٠','١','٢','٣','٤','٥','٦','٧','٨','٩'];
  return n.toString().split('').map((c) {
    final i = int.tryParse(c);
    return i == null ? c : d[i];
  }).join();
}

/// Arabic surah name active on [page1Based] (1–604).
String surahNameArForPage(int page1Based) {
  var name = surahList.first.nameAr;
  for (final s in surahList) {
    if (s.page <= page1Based) { name = s.nameAr; } else { break; }
  }
  return name;
}

/// Juz number active on [page1Based] (1–604).
int juzForPage(int page1Based) {
  var j = 1;
  for (final z in juzList) {
    if (z.page <= page1Based) { j = z.number; } else { break; }
  }
  return j;
}

/// Transliterated surah name active on [page1Based] (1–604).
String surahNameForPage(int page1Based) {
  var name = surahList.first.name;
  for (final s in surahList) {
    if (s.page <= page1Based) { name = s.name; } else { break; }
  }
  return name;
}
