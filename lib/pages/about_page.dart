import 'package:flutter/material.dart';
import 'package:nigerian_mushaf_app/l10n/app_localizations.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context).aboutTitle),
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

class _LandscapeLayout extends StatelessWidget {
  const _LandscapeLayout({required this.cs});
  final ColorScheme cs;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.cs, this.compact = true});
  final ColorScheme cs;
  final bool compact;
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
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
            Icon(
              Icons.menu_book_rounded,
              size: compact ? 56 : 72,
              color: cs.onPrimaryContainer,
            ),
            const SizedBox(height: 16),
            // Always-Arabic title line.
            Text(
              'المصحف النيجيري',
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Ruwudu',
                fontSize: compact ? 24 : 30,
                fontWeight: FontWeight.w700,
                color: cs.onPrimaryContainer,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l.appTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: compact ? 18 : 22,
                fontWeight: FontWeight.bold,
                color: cs.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: cs.onPrimaryContainer.withAlpha(30),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                l.appBy,
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
    final l = AppLocalizations.of(context);
    return _SectionCard(
      cs: cs,
      title: l.aboutSectionAbout,
      icon: Icons.info_outline,
      child: Text(
        l.aboutDescription,
        style: const TextStyle(fontSize: 15, height: 1.7),
      ),
    );
  }
}

class _FeaturesCard extends StatelessWidget {
  const _FeaturesCard({required this.cs});
  final ColorScheme cs;
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final features = <(IconData, String)>[
      (Icons.image_outlined, l.featImages),
      (Icons.dark_mode_outlined, l.featThemes),
      (Icons.swap_vert, l.featModes),
      (Icons.auto_stories_outlined, l.featDualZoom),
      (Icons.search, l.featSearch),
      (Icons.list_alt_outlined, l.featIndexes),
      (Icons.bookmark_border, l.featBookmarks),
      (Icons.brightness_3, l.featBrightness),
    ];
    return _SectionCard(
      cs: cs,
      title: l.aboutSectionFeatures,
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
    final l = AppLocalizations.of(context);
    // Labels localised; values are proper nouns / numbers (kept as-is).
    final items = <(String, String)>[
      (l.techFramework, 'Flutter (Dart)'),
      (l.techState, 'Riverpod'),
      (l.techRendering, 'Two-layer PNG (ink + borders)'),
      (l.techImagesLabel, '1930 × 2480 px'),
      (l.techPagesLabel, '604'),
    ];
    return _SectionCard(
      cs: cs,
      title: l.aboutSectionTechnical,
      icon: Icons.code,
      child: Column(
        children: items.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                SizedBox(
                  width: 110,
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
                  child: Text(item.$2, style: const TextStyle(fontSize: 13)),
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
    final l = AppLocalizations.of(context);
    return _SectionCard(
      cs: cs,
      title: l.aboutSectionCredits,
      icon: Icons.favorite_outline,
      child: compact
          ? Text(
              l.aboutCreditsShort,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: cs.onSurface.withAlpha(180),
              ),
            )
          : Text(
              l.aboutCreditsBody,
              style: TextStyle(
                fontSize: 13,
                height: 1.6,
                color: cs.onSurface.withAlpha(200),
              ),
            ),
    );
  }
}

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
