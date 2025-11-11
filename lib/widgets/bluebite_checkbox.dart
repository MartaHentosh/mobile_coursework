import 'package:cours_work/core/app_colors.dart';
import 'package:flutter/material.dart';

class BlueBiteCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const BlueBiteCheckbox({
    required this.value, required this.onChanged, super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.only(left: 14),
        height: 22,
        width: 22,
        decoration: BoxDecoration(
          color: const Color(0xFF011C40),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: value
                ? AppColors.glow
                : Colors.white.withValues(alpha: 0.6),
            width: 1.5,
          ),
          boxShadow: value
              ? [
                  BoxShadow(
                    color: AppColors.glow.withValues(alpha: 0.6),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: value
            ? const Icon(Icons.check, color: AppColors.glow, size: 16)
            : null,
      ),
    );
  }
}
