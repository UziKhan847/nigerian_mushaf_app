import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ── Shader cache ──────────────────────────────────────────────────────────────
// Load the FragmentProgram once for the whole app session.

Future<ui.FragmentProgram?>? _programFuture;

Future<ui.FragmentProgram?> _getProgram() {
  _programFuture ??= _loadProgram();
  return _programFuture!;
}

Future<ui.FragmentProgram?> _loadProgram() async {
  try {
    return await ui.FragmentProgram.fromAsset(
        'assets/shaders/mushaf_dark.frag');
  } catch (e) {
    debugPrint('[MushafDarkImage] shader load failed: $e');
    return null;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// MushafDarkImage
// ─────────────────────────────────────────────────────────────────────────────

/// Renders a mushaf page PNG using a GLSL fragment shader that converts
/// near-black pixels to warm white while keeping every other colour exactly
/// as it appears in the original scan.
///
/// Falls back to a plain [Image.asset] if the shader cannot be loaded
/// (e.g. on a platform that does not support custom fragment shaders).
class MushafDarkImage extends StatefulWidget {
  const MushafDarkImage({
    super.key,
    required this.assetPath,
    required this.fit,
  });

  final String assetPath;
  final BoxFit fit;

  @override
  State<MushafDarkImage> createState() => _MushafDarkImageState();
}

class _MushafDarkImageState extends State<MushafDarkImage> {
  ui.Image? _image;
  ui.FragmentProgram? _program;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load(widget.assetPath);
  }

  @override
  void didUpdateWidget(covariant MushafDarkImage old) {
    super.didUpdateWidget(old);
    if (old.assetPath != widget.assetPath) {
      _image?.dispose();
      _image   = null;
      _loading = true;
      _load(widget.assetPath);
    }
  }

  Future<void> _load(String path) async {
    try {
      final results = await Future.wait<dynamic>([
        _getProgram(),
        _decodeAsset(path),
      ]);
      if (!mounted) {
        (results[1] as ui.Image?)?.dispose();
        return;
      }
      setState(() {
        _program = results[0] as ui.FragmentProgram?;
        _image   = results[1] as ui.Image?;
        _loading = false;
      });
    } catch (e) {
      if (mounted) setState(() => _loading = false);
    }
  }

  static Future<ui.Image?> _decodeAsset(String path) async {
    final data  = await rootBundle.load(path);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  @override
  void dispose() {
    _image?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 1.5));
    }
    // Fall back to a plain image if shader or decode failed.
    if (_image == null || _program == null) {
      return Image.asset(widget.assetPath, fit: widget.fit,
          filterQuality: FilterQuality.medium);
    }
    return LayoutBuilder(
      builder: (_, constraints) => CustomPaint(
        size: Size(constraints.maxWidth, constraints.maxHeight),
        painter: _DarkMushafPainter(
          image:   _image!,
          program: _program!,
          fit:     widget.fit,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Painter
// ─────────────────────────────────────────────────────────────────────────────

class _DarkMushafPainter extends CustomPainter {
  const _DarkMushafPainter({
    required this.image,
    required this.program,
    required this.fit,
  });

  final ui.Image          image;
  final ui.FragmentProgram program;
  final BoxFit            fit;

  @override
  void paint(Canvas canvas, Size size) {
    final imgW = image.width.toDouble();
    final imgH = image.height.toDouble();
    final rect = _fitRect(imgW, imgH, size);

    // Each call to fragmentShader() creates a fresh shader instance.
    final shader = program.fragmentShader()
      ..setFloat(0, rect.width)   // uSize.x
      ..setFloat(1, rect.height)  // uSize.y
      ..setImageSampler(0, image); // uImage

    canvas.save();
    canvas.translate(rect.left, rect.top);
    canvas.drawRect(Offset.zero & rect.size, Paint()..shader = shader);
    canvas.restore();
  }

  /// Maps [imgW]×[imgH] into [canvas] according to [fit], identical to how
  /// [Image] widget computes its painted area.
  Rect _fitRect(double imgW, double imgH, Size canvas) {
    final ia = imgW / imgH;
    final ca = canvas.width / canvas.height;
    switch (fit) {
      case BoxFit.fitWidth:
        final h = canvas.width / ia;
        return Rect.fromLTWH(0, 0, canvas.width, h);
      case BoxFit.fitHeight:
        final w = canvas.height * ia;
        return Rect.fromLTWH(0, 0, w, canvas.height);
      case BoxFit.fill:
        return Offset.zero & canvas;
      case BoxFit.contain:
      default:
        if (ca > ia) {
          final w = canvas.height * ia;
          return Rect.fromLTWH((canvas.width - w) / 2, 0, w, canvas.height);
        } else {
          final h = canvas.width / ia;
          return Rect.fromLTWH(0, (canvas.height - h) / 2, canvas.width, h);
        }
    }
  }

  @override
  bool shouldRepaint(_DarkMushafPainter old) =>
      old.image != image || old.program != program || old.fit != fit;
}
