import 'package:flutter/material.dart';

class FilterDropdown extends StatelessWidget {
  final String label;
  final List<Map<String, String>> options;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  const FilterDropdown({
    required this.label,
    required this.options,
    required this.onChanged,
    super.key,
    this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        constraints: const BoxConstraints(minWidth: 100),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF023859),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFA7EBF2), width: 1.2),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            dropdownColor: const Color(0xFF011C40),
            value: selectedValue,
            isExpanded: true,
            isDense: true,
            style: const TextStyle(
              color: Color(0xFFA7EBF2),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            hint: Text(
              label,
              style: const TextStyle(
                color: Color(0xFFA7EBF2),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            items: options.map((option) {
              return DropdownMenuItem<String>(
                value: option['value'],
                child: Text(
                  option['label']!,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Color(0xFFA7EBF2)),
                ),
              );
            }).toList(),
            onChanged: onChanged,
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 18,
              color: Color(0xFFA7EBF2),
            ),
          ),
        ),
      ),
    );
  }
}
