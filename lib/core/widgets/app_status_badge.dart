import 'package:flutter/material.dart';
import '../theme/app_radius.dart';

class AppStatusBadge extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final Color? backgroundColor;

  const AppStatusBadge({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = backgroundColor ??
        (isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0));

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: AppRadius.sharpBorder,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: color),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
