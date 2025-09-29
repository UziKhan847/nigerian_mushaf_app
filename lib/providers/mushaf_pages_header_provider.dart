// mushaf_page_data_provider.dart
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/mushaf/mushaf_headers_data/mushaf_headers.dart';

final mushafPgHeaderProvider =
    AsyncNotifierProvider<MushafPgHeaderNotifier, MushafHeaders?>(
      MushafPgHeaderNotifier.new,
    );

class MushafPgHeaderNotifier extends AsyncNotifier<MushafHeaders?> {
  @override
  Future<MushafHeaders?> build() async {
    try {
      final file = await rootBundle.loadString('assets/mushaf_pages_header.json');
      final Map<String, dynamic> decoded = jsonDecode(file);
      final res = MushafHeaders.fromJson(decoded);
      return res;
    } catch (e, st) {
      throw Exception('Failed to load mushaf headers: $e\n$st');
    }
  }
}
