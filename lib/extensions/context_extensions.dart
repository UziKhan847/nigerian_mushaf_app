import 'dart:ui';
import 'package:flutter/material.dart';

extension ContextOverlayExtension on BuildContext {
  OverlayEntry insertOverlay({
    required VoidCallback onTapOutside,
    Color? backgroundColor,
    List<Widget> children = const [],
  }) {
    final OverlayEntry entry = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: ModalBarrier(
                  dismissible: true,
                  color: backgroundColor ?? Colors.black.withAlpha(100),
                  onDismiss: onTapOutside,
                ),
              ),

              ...children,
            ],
          ),
        );
      },
    );

    Overlay.of(this).insert(entry);
    return entry;
  }

  void removeOverlayEntry(OverlayEntry? entry) {
    if (entry != null && entry.mounted) {
      entry.remove();
      entry.dispose();
    }
  }
}
