import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';

enum ButtonVariant { primary, secondary, outline }

class BaseButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? icon;
  final String label;
  final ButtonVariant variant;
  final bool isLoading;
  final double? width;
  final double height;

  const BaseButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
    this.variant = ButtonVariant.primary,
    this.isLoading = false,
    this.width,
    this.height = 48,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Widget childContent = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading)
          const SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          )
        else ...[
          if (icon != null) ...[
            icon!,
            const SizedBox(width: 8),
          ],
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ],
    );

    if (variant == ButtonVariant.outline) {
      return SizedBox(
        width: width,
        height: height,
        child: OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.accentAmber,
            side: const BorderSide(color: AppColors.accentAmber, width: 1.2),
            shape: const RoundedRectangleBorder(
              borderRadius: AppRadius.subtleBorder,
            ),
          ),
          child: childContent,
        ),
      );
    }

    final bg = variant == ButtonVariant.primary
        ? AppColors.primaryGreen
        : (isDark ? const Color(0xFF334155) : const Color(0xFF0F172A));

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadius.subtleBorder,
          ),
        ),
        child: childContent,
      ),
    );
  }
}
