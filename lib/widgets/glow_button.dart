import 'package:flutter/material.dart';

class GlowButton extends StatelessWidget {
  final String text;
  final Future<void> Function()? onPressed;
  final bool isPrimary;
  final double height;
  final double? width;

  const GlowButton({
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.height = 52,
    this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Gradient gradient = isPrimary
        ? const LinearGradient(colors: [Color(0xFF023859), Color(0xFF26658C)])
        : const LinearGradient(colors: [Color(0xFF26658C), Color(0xFF8AD1D8)]);

    return GestureDetector(
      onTap: () {
        if (onPressed != null) {
          onPressed!();
        }
      },
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFA7EBF2), width: 1.5),
          borderRadius: BorderRadius.circular(6),
          gradient: gradient,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.35),
              offset: const Offset(0, 3),
              blurRadius: 20,
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
