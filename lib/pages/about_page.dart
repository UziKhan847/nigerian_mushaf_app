import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('About'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: cs.surface,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isLandscape = constraints.maxWidth > constraints.maxHeight;
          return isLandscape
              ? _LandscapeLayout(cs: cs)
              : _PortraitLayout(cs: cs);
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Portrait layout: scrollable single column
// ─────────────────────────────────────────────────────────────────────────────

class _PortraitLayout extends StatelessWidget {
  const _PortraitLayout({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _HeroCard(cs: cs),
          const SizedBox(height: 20),
          _DescriptionCard(cs: cs),
          const SizedBox(height: 16),
          _FeaturesCard(cs: cs),
          const SizedBox(height: 16),
          _TechCard(cs: cs),
          const SizedBox(height: 16),
          _CreditsCard(cs: cs),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Landscape layout: hero on left, scrollable content on right
// ─────────────────────────────────────────────────────────────────────────────

class _LandscapeLayout extends StatelessWidget {
  const _LandscapeLayout({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Fixed left panel: hero + credits
        SizedBox(
          width: 280,
          child: Column(
            children: [
              Expanded(child: _HeroCard(cs: cs, compact: false)),
              _CreditsCard(cs: cs, compact: true),
            ],
          ),
        ),
        const VerticalDivider(width: 1),
        // Scrollable right panel
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _DescriptionCard(cs: cs),
                const SizedBox(height: 16),
                _FeaturesCard(cs: cs),
                const SizedBox(height: 16),
                _TechCard(cs: cs),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Cards
// ─────────────────────────────────────────────────────────────────────────────

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.cs, this.compact = true});
  final ColorScheme cs;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cs.primaryContainer,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: compact
            ? const EdgeInsets.symmetric(vertical: 28, horizontal: 24)
            : const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.menu_book_rounded, size: compact ? 56 : 72,
                color: cs.onPrimaryContainer),
            const SizedBox(height: 16),
            Text(
              'المصحف النيجيري',
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Nigerian',
                fontSize: compact ? 22 : 28,
                color: cs.onPrimaryContainer,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Nigerian Mushaf',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: compact ? 18 : 22,
                fontWeight: FontWeight.bold,
                color: cs.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: cs.onPrimaryContainer.withAlpha(30),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'by Quran Quorum',
                style: TextStyle(
                  fontSize: 13,
                  color: cs.onPrimaryContainer.withAlpha(200),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DescriptionCard extends StatelessWidget {
  const _DescriptionCard({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      cs: cs,
      title: 'About',
      icon: Icons.info_outline,
      child: const Text(
        'The Nigerian Mushaf App presents the Nigerian Mushaf as scalable, '
        'selectable text rendered in a custom Nigerian Maghribi font — not '
        'scanned PDFs. It faithfully preserves the original colouring, '
        'rubrication, all diacritic marks, and the distinctive Maghribi '
        'spelling and orthography of the Nigerian tradition.\n\n'
        'The Nigerian Mushaf is one of the most widely used Quran manuscripts '
        'in West Africa. Its unique Maghribi script, distinct from the Uthmāni '
        'rasm used elsewhere, reflects centuries of West African Quranic '
        'scholarship and transmission. This app brings that tradition to '
        'digital devices without compromising its visual integrity.',
        style: TextStyle(fontSize: 15, height: 1.7),
      ),
    );
  }
}

class _FeaturesCard extends StatelessWidget {
  const _FeaturesCard({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    const features = [
      (Icons.font_download_outlined,  'Custom Nigerian Maghribi font that matches the printed letterforms exactly'),
      (Icons.zoom_in,                 'Vector text for crisp zoom and clear readability on any screen size'),
      (Icons.palette_outlined,        'All original markings, colours, and diacritics faithfully retained'),
      (Icons.search,                  'Full-text search in Qiyāsī, Uthmānī, and root-based modes'),
      (Icons.auto_stories_outlined,   'Dual-page spread view for an authentic open-book experience'),
      (Icons.dark_mode_outlined,      'Multiple themes including Light, Dark, Monochrome, OLED Black and Custom'),
      (Icons.swap_vert,               'Vertical and horizontal scroll directions with swipe or slide modes'),
      (Icons.list_alt_outlined,       'Sūrah, page, and verse index for quick navigation'),
    ];

    return _SectionCard(
      cs: cs,
      title: 'Features',
      icon: Icons.star_outline,
      child: Column(
        children: features.map((f) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  margin: const EdgeInsets.only(right: 14, top: 2),
                  decoration: BoxDecoration(
                    color: cs.primary.withAlpha(20),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(f.$1, size: 18, color: cs.primary),
                ),
                Expanded(
                  child: Text(
                    f.$2,
                    style: const TextStyle(fontSize: 14, height: 1.5),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _TechCard extends StatelessWidget {
  const _TechCard({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    const items = [
      ('Framework',  'Flutter (Dart)'),
      ('State',      'Riverpod'),
      ('Font',       'Nigerian Maghribi (custom TTF)'),
      ('Script',     'Qiyāsī (primary) · Uthmānī (search)'),
      ('Images',     'High-res PNG scans (1930 × 2480 px)'),
      ('Pages',      '604 total'),
    ];

    return _SectionCard(
      cs: cs,
      title: 'Technical',
      icon: Icons.code,
      child: Column(
        children: items.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                SizedBox(
                  width: 90,
                  child: Text(
                    item.$1,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: cs.onSurface.withAlpha(180),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    item.$2,
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _CreditsCard extends StatelessWidget {
  const _CreditsCard({required this.cs, this.compact = false});
  final ColorScheme cs;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      cs: cs,
      title: 'Credits',
      icon: Icons.favorite_outline,
      child: compact
          ? Text(
              '© Quran Quorum\nAll rights reserved.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: cs.onSurface.withAlpha(180),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Developed by Quran Quorum',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: cs.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'The Nigerian Mushaf is a sacred manuscript with deep roots '
                  'in the West African Quranic tradition. We have strived to '
                  'represent it digitally with the utmost care and fidelity.\n\n'
                  'All rights to the Nigerian Mushaf script belong to their '
                  'respective custodians and scholarship communities.',
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.6,
                    color: cs.onSurface.withAlpha(200),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '© Quran Quorum. All rights reserved.',
                  style: TextStyle(
                    fontSize: 12,
                    color: cs.onSurface.withAlpha(140),
                  ),
                ),
              ],
            ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared section card wrapper
// ─────────────────────────────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.cs,
    required this.title,
    required this.icon,
    required this.child,
  });

  final ColorScheme cs;
  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cs.surfaceContainerLow,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: cs.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: cs.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            child,
          ],
        ),
      ),
    );
  }
}
