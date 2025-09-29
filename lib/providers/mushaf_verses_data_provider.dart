// mushaf_page_data_provider.dart
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/mushaf/mushaf_verses_data_models/mushaf_verses_data.dart';

final mushafVersesDataProvider =
    AsyncNotifierProvider<MushafVersesDataNotifier, MushafVersesData?>(
      MushafVersesDataNotifier.new,
    );

class MushafVersesDataNotifier extends AsyncNotifier<MushafVersesData?> {
  @override
  Future<MushafVersesData?> build() async {
    try {
      final file = await rootBundle.loadString('assets/mushaf_verses_data.json');
      final Map<String, dynamic> decoded = jsonDecode(file);
      final res = MushafVersesData.fromJson(decoded);
      return res;
    } catch (e, st) {
      throw Exception('Failed to load verses: $e\n$st');
    }
  }
}
