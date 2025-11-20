import 'package:flutter/material.dart';

class FilterToggle extends StatelessWidget {
  final String text;
  final bool active;
  final VoidCallback onTap;

  const FilterToggle({
    required this.text, required this.active, required this.onTap, super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: active
              ? const Color(0xFFA7EBF2).withValues(alpha: 0.25)
              : const Color(0xFF023859),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFA7EBF2), width: 1.2),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Color(0xFFA7EBF2),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
