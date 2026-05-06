import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;
    final cardColor = isDark
        ? const Color.fromARGB(255, 30, 20, 20)
        : const Color(0xFFF5EDE0); // soft cream, matches original paper vibe

    return Scaffold(
      backgroundColor: isDark ? Colors.black : const Color(0xffe4d2b7),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('About'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: textColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              color: cardColor,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // App title
                    Text(
                      'Nigerian Mushaf App',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Version 1.0.0',
                      style: TextStyle(
                        fontSize: 16,
                        color: textColor.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Description
                    Text(
                      'Nigerian Mushaf App presents the Nigerian Mushaf as scalable, selectable text in a custom Nigerian Maghribi font, not scanned PDFs. It preserves the original colouring, rubrication, all diacritic marks, and Maghribi spelling and orthography.',
                      style: TextStyle(
                        fontSize: 18,
                        color: textColor,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Features title
                    Text(
                      'Features',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Bullet list
                    _buildBulletPoint(
                      context,
                      'Custom Nigerian Maghribi font that matches the printed letterforms',
                    ),
                    const SizedBox(height: 10),
                    _buildBulletPoint(
                      context,
                      'Vector text for crisp zoom and clear readability on any device',
                    ),
                    const SizedBox(height: 10),
                    _buildBulletPoint(
                      context,
                      'All original markings, colours, and diacritics retained',
                    ),
                    const SizedBox(height: 10),
                    _buildBulletPoint(
                      context,
                      '480 pages exactly as the printed Mushaf',
                    ),
                    const SizedBox(height: 10),
                    _buildBulletPoint(
                      context,
                      'Search, bookmarks, and night mode',
                    ),
                    const SizedBox(height: 24),

                    // Divider
                    Divider(
                      color: textColor.withValues(alpha: 0.2),
                      thickness: 1,
                    ),
                    const SizedBox(height: 16),

                    // Footer
                    Text(
                      'Made by Quran Quorum',
                      style: TextStyle(
                        fontSize: 16,
                        color: textColor.withValues(alpha: 0.8),
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'contact@quranquorum.com',
                      style: TextStyle(
                        fontSize: 14,
                        color: textColor.withValues(alpha: 0.6),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBulletPoint(BuildContext context, String text) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '•',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textColor,
            height: 1.4,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 18, color: textColor, height: 1.4),
          ),
        ),
      ],
    );
  }
}
