import 'package:json_annotation/json_annotation.dart';
import 'package:nigerian_mushaf_app/mushaf/mushaf_headers_data/mushaf_page_header.dart';

part 'mushaf_headers.g.dart';

@JsonSerializable(explicitToJson: true)
class MushafHeaders {
  MushafHeaders({required this.mushafPagesHeader});

  @JsonKey(name: 'mushaf_pages_header')
  final List<MushafPageHeader> mushafPagesHeader;

  factory MushafHeaders.fromJson(Map<String, dynamic> json) =>
      _$MushafHeadersFromJson(json);

  Map<String, dynamic> toJson() => _$MushafHeadersToJson(this);
}
