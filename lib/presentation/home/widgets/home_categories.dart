import 'package:flutter/material.dart';

class HomeCategories extends StatelessWidget {
  final List<String> imageAssets;
  final void Function(int categoryId) onCategorySelected;
  final int? selectedIndex;

  const HomeCategories({
    required this.imageAssets,
    required this.onCategorySelected,
    required this.selectedIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: imageAssets.length,
        separatorBuilder: (_, __) => const SizedBox(width: 18),
        itemBuilder: (_, i) {
          final isSelected = selectedIndex == i + 1;

          return GestureDetector(
            onTap: () => onCategorySelected(i + 1),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? const Color(0xFFA7EBF2).withValues(alpha: 0.25)
                    : const Color(0xFF023859),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFFA7EBF2)
                      : const Color(0xFFA7EBF2).withValues(alpha: 0.4),
                  width: isSelected ? 2 : 1.4,
                ),
              ),
              padding: const EdgeInsets.all(14),
              child: Image.asset(
                imageAssets[i],
                fit: BoxFit.contain,
                color: isSelected ? const Color(0xFFA7EBF2) : Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
