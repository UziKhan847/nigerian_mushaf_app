import 'package:json_annotation/json_annotation.dart';
import 'package:nigerian_mushaf_app/mushaf/mushaf_verses_data_models/mushaf_verse.dart';

part 'mushaf_verses_data.g.dart';

@JsonSerializable(explicitToJson: true)
class MushafVersesData {
  MushafVersesData({required this.mushafVersesData});

  @JsonKey(name: 'mushaf_verses_data')
  final List<MushafVerse> mushafVersesData;

  factory MushafVersesData.fromJson(Map<String, dynamic> json) =>
      _$MushafVersesDataFromJson(json);
  Map<String, dynamic> toJson() => _$MushafVersesDataToJson(this);
}
