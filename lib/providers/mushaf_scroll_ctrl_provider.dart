import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mushafScrollCtrlProvider =
    NotifierProvider<MushafScrollCtrlProvider, ScrollController>(
      MushafScrollCtrlProvider.new,
    );

class MushafScrollCtrlProvider extends Notifier<ScrollController> {
  @override
  ScrollController build() => ScrollController();

  void jumpToPage(int index, double itemExtent) {
    final offset = index * itemExtent;
    state.jumpTo(offset);
  }
}
