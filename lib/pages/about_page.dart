import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Color(0xffe4d2b7),
      appBar: AppBar(
        centerTitle: true,
        title: Text('About Page'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(30),
          padding: EdgeInsets.all(60),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? const Color.fromARGB(255, 31, 15, 15)
                : Color.fromARGB(255, 226, 200, 162),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nigerian Mushaf App',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 25),
              Text('''
                Nigerian Mushaf App presents the Nigerian Mushaf as scalable, selectable text in a custom Nigerian Maghribi font, not scanned PDFs. It preserves the original colouring, rubrication, all diacritic marks, and Maghribi spelling and orthography. Made by Quran Quorum.
                ''', style: TextStyle(fontSize: 25)),

              Text(
                'Features',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Text(
                '     - Custom Nigerian Maghribi font that matches the printed letterforms',
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(height: 8),
              Text(
                '     - Vector text for crisp zoom and clear readability on any device',
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(height: 8),
              Text(
                '     - All original markings, colours, and diacritics retained',
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(height: 25),
              Text(
                'Custom Nigerian Maghribi font that matches the printed letterforms',
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
