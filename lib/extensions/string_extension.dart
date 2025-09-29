extension StringExtension on String {
  static final diacritics = RegExp(
    r'[\u0610-\u061A\u064B-\u065F\u0670\u06D6-\u06ED\u06E9-\u06EF\u06FF]',
  );
    static final diacriticsWithoutSmallMaddLetters = RegExp(
    r'[\u0610-\u061A\u064B-\u065F\u06D6-\u06E4\u06E7-\u06ED\u06E9-\u06EF\u06FF]',
  );
  static final tatweel = RegExp(r'\u0640'); // ـ
  static final punctuation = RegExp(
    r'''[۞،\u060C\u061F\.,;:\-\(\)\[\]\{\}"“”\'«»—–…!?؛:]''',
  );

  String get removeTahskil {
    var s = this;
    s = s.replaceAll(diacritics, '');
    s = s.replaceAll(tatweel, '');
    s = s.replaceAll(punctuation, ' ');

    s = s.replaceAll(RegExp(r'[أإآ]'), 'ا');
    s = s.replaceAll('ى', 'ي');
    s = s.replaceAll('ؤ', 'و');
    s = s.replaceAll('ئ', 'ي');

    s = s.replaceAll(RegExp(r'\s+'), ' ').trim();
    return s;
  }

    String get removeTahskilExceptSmallMaddLetters {
    var s = this;

    s = s.replaceAll(diacriticsWithoutSmallMaddLetters, '');
    s = s.replaceAll(tatweel, '');
    s = s.replaceAll(punctuation, ' ');

    final List<int> out = [];

    for (final r in s.runes) {
      if (r == 0x06E5) {
        out.add(0x0648);
      } else if (r == 0x06E6) {
        out.add(0x064A);
      } else if (r == 0x0670) {
        if (out.isNotEmpty && out.last == 0x0648) {
          out.removeLast();
          out.add(0x0627);
        } else {
          out.add(0x0627);
        }
      } else {
        out.add(r);
      }
    }

    s = String.fromCharCodes(out);

    s = s.replaceAll(RegExp(r'[أإآ]'), 'ا');
    s = s.replaceAll('ى', 'ي');
    s = s.replaceAll('ؤ', 'و');
    s = s.replaceAll('ئ', 'ي');

    s = s.replaceAll(RegExp(r'\s+'), ' ').trim();
    return s;
  }
}
