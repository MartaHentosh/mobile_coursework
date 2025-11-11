import 'package:flutter/material.dart';

class GlowInput extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscureText;
  final IconData? icon;
  final VoidCallback? onIconTap;

  const GlowInput({
    required this.controller,
    required this.hint,
    this.obscureText = false,
    this.icon,
    super.key,
    this.onIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0xFF011C40),
          borderRadius: BorderRadius.circular(18),
        ),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF011C40),
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.white.withValues(alpha: 0.45),
              fontSize: 16,
            ),
            suffixIcon: icon != null
                ? GestureDetector(
                    onTap: onIconTap,
                    child: Icon(icon, color: const Color(0xFFA7EBF2)),
                  )
                : null,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 16,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
