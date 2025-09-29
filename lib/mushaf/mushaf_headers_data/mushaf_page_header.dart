import 'package:json_annotation/json_annotation.dart';

part 'mushaf_page_header.g.dart';

@JsonSerializable()
class MushafPageHeader {
  MushafPageHeader({
    required this.surahName,
    required this.hizbInfo,
    required this.numOfWaqf,
  });

  final String surahName;
  final String hizbInfo;
  final String numOfWaqf;

  factory MushafPageHeader.fromJson(Map<String, dynamic> json) =>
      _$MushafPageHeaderFromJson(json);

  Map<String, dynamic> toJson() => _$MushafPageHeaderToJson(this);
}
