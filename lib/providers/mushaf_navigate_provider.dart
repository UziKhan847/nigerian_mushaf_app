import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nigerian_mushaf_app/providers/mushaf_controller_registry.dart';

final mushafNavigateProvider = Provider<void Function(BuildContext, int)>(
  (ref) => (BuildContext context, int pageIndex) {
    ref.read(mushafControllerRegistryProvider).jumpToPage(pageIndex);
  },
);
