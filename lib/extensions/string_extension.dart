extension StringExtension on String {
  static final _diacritics = RegExp(
    r'[\u0610-\u061A\u064B-\u065F\u0670\u06D6-\u06ED\u06E9-\u06EF]',
  );

  static final _diacriticsWithoutSmallMaddLetters = RegExp(
    r'[\u0610-\u061A\u064B-\u065F\u06D6-\u06E4\u06E7-\u06ED\u06E9-\u06EF]',
  );

  static final _tatweel = RegExp(r'\u0640');

  static final _punctuation = RegExp(
    r'''[۞،\u061F\.,;:\-\(\)\[\]\{\}"""\'«»—–…!?؛:]''',
  );

  String get removeTashkil {
    var s = this;
    s = s.replaceAll(_diacritics, '');
    s = s.replaceAll(_tatweel, '');
    s = s.replaceAll(_punctuation, ' ');
    s = s.replaceAll(RegExp(r'[أإآٱ]'), 'ا'); // added alef wasla \u0671
    s = s.replaceAll('ة', 'ه'); // ta marbuta → ha
    s = s.replaceAll('ى', 'ي');
    s = s.replaceAll('ؤ', 'و');
    s = s.replaceAll('ئ', 'ي');
    s = s.replaceAll(RegExp(r'\s+'), ' ').trim();
    return s;
  }

  /// Like [removeTaskhil] but preserves small medd letters (ۥ ۦ ٰ) so that
  /// Quranic superscript alef, small waw, and small ya are converted to their
  /// full-letter equivalents instead of being stripped entirely.
  String get removeTashkilExceptSmallMaddLetters {
    var s = this;
    s = s.replaceAll(_diacriticsWithoutSmallMaddLetters, '');
    s = s.replaceAll(_tatweel, '');
    s = s.replaceAll(_punctuation, ' ');

    // Convert Quranic small letters to their full equivalents:
    //   \u06E5 (small waw ۥ)          → waw  (و)
    //   \u06E6 (small ya  ۦ)          → ya   (ي)
    //   \u0670 (superscript alef  ٰ)  → alef (ا)
    //   Special case: waw + superscript alef → alef (e.g. الصَّلَوٰة → الصلاة)
    final List<int> out = [];
    for (final r in s.runes) {
      switch (r) {
        case 0x06E5: // small waw
          out.add(0x0648);
        case 0x06E6: // small ya
          out.add(0x064A);
        case 0x0670: // superscript alef
          if (out.isNotEmpty && out.last == 0x0648) {
            // waw + superscript alef → alef (Quranic spelling convention)
            out.removeLast();
          }
          out.add(0x0627);
        default:
          out.add(r);
      }
    }
    s = String.fromCharCodes(out);

    s = s.replaceAll(RegExp(r'[أإآٱ]'), 'ا'); // added alef wasla \u0671
    s = s.replaceAll('ة', 'ه'); // ta marbuta → ha
    s = s.replaceAll('ى', 'ي');
    s = s.replaceAll('ؤ', 'و');
    s = s.replaceAll('ئ', 'ي');
    s = s.replaceAll(RegExp(r'\s+'), ' ').trim();
    return s;
  }
}
