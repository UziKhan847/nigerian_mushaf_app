class PageInfo {
  PageInfo({
    // required this.firstVerse,
    // required this.lastVerse,
    required this.pageNum,
    required this.surahNames,
    required this.surahNums,
  });

  final int pageNum;
  final List<int> surahNums;
  final List<String> surahNames;
  // final int firstVerse;
  // final int lastVerse;
}
