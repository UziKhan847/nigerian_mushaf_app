// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mushaf_headers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MushafHeaders _$MushafHeadersFromJson(Map<String, dynamic> json) =>
    MushafHeaders(
      mushafPagesHeader: (json['mushaf_pages_header'] as List<dynamic>)
          .map((e) => MushafPageHeader.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MushafHeadersToJson(MushafHeaders instance) =>
    <String, dynamic>{
      'mushaf_pages_header': instance.mushafPagesHeader
          .map((e) => e.toJson())
          .toList(),
    };
