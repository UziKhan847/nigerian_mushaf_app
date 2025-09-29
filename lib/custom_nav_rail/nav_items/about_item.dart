import 'package:flutter/material.dart';
import 'package:nigerian_mushaf_app/custom_nav_rail/nav_rail_button.dart';

class AboutItem extends StatelessWidget {
  const AboutItem({super.key, required this.removeOverlay});

  final void Function() removeOverlay;

  @override
  Widget build(BuildContext context) {
    return NavRailButton(
      icon: Icons.info,
      label: 'About',
      onPressed: () {
        removeOverlay();
        Navigator.pushNamed(context, '/about_page');
      },
    );
  }
}
