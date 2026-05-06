import 'package:flutter/material.dart';

class NavRailButton extends StatelessWidget {
  const NavRailButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.isActive = false,
    this.activeColor,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  /// When true the button is highlighted (e.g. a toggle that is ON).
  final bool isActive;

  /// Override the active highlight colour.
  final Color? activeColor;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final color = isActive ? (activeColor ?? cs.primary) : cs.onSurfaceVariant;
    final bg = isActive ? cs.primary.withAlpha(24) : Colors.transparent;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Material(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 24, color: color),
                const SizedBox(height: 4),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    color: color,
                    fontWeight:
                        isActive ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
