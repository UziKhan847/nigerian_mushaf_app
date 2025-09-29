import 'package:json_annotation/json_annotation.dart';

part 'mushaf_verse.g.dart';

@JsonSerializable()
class MushafVerse {
  MushafVerse({
    required this.verseNum,
    required this.text,
    required this.page,
    required this.surahNum,
  });

  final int verseNum;
  final String text;
  final int page;
  final int surahNum;

  factory MushafVerse.fromJson(Map<String, dynamic> json) =>
      _$MushafVerseFromJson(json);
  Map<String, dynamic> toJson() => _$MushafVerseToJson(this);
}
