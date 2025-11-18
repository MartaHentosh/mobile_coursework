import 'package:cours_work/presentation/home/cubit/restaurants_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeFilters extends StatefulWidget {
  const HomeFilters({super.key});

  @override
  State<HomeFilters> createState() => _HomeFiltersState();
}

class _HomeFiltersState extends State<HomeFilters> {
  bool promoActive = false;
  bool takeawayActive = false;
  bool popularActive = false;

  String? selectedSort;
  String? selectedDeliveryType;

  final List<Map<String, String>> sortOptions = [
    {'label': 'Рейтинг', 'value': 'rating_desc'},
    {'label': 'Ціна доставки ↑', 'value': 'delivery_fee_asc'},
    {'label': 'Ціна доставки ↓', 'value': 'delivery_fee_desc'},
  ];

  final List<Map<String, String>> deliveryOptions = [
    {'label': 'Усі типи', 'value': 'all'},
    {'label': 'Доставка', 'value': 'delivery'},
    {'label': 'Самовивіз', 'value': 'pickup'},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const SizedBox(width: 4),

          _buildToggle('Промоакції', promoActive, () {
            setState(() => promoActive = !promoActive);
          }),

          const SizedBox(width: 8),

          _buildToggle('На виніс', takeawayActive, () {
            setState(() => takeawayActive = !takeawayActive);
          }),

          const SizedBox(width: 8),

          _buildDropdown(
            label: 'Сортувати за',
            selectedValue: selectedSort,
            options: sortOptions,
            onChanged: (value) {
              setState(() => selectedSort = value);
              if (value != null) {
                context.read<RestaurantsCubit>().sortRestaurants(value);
              }
            },
          ),
          const SizedBox(width: 8),

          _buildDropdown(
            label: 'Тип доставки',
            selectedValue: selectedDeliveryType,
            options: deliveryOptions,
            onChanged: (value) {
              setState(() => selectedDeliveryType = value);
              debugPrint('Тип доставки: $value');
            },
          ),

          const SizedBox(width: 8),

          _buildToggle('Найпопулярніше', popularActive, () {
            setState(() => popularActive = !popularActive);
          }),

          const SizedBox(width: 4),
        ],
      ),
    );
  }

  Widget _buildToggle(String text, bool active, VoidCallback onTap) {
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

  Widget _buildDropdown({
    required String label,
    required List<Map<String, String>> options,
    required ValueChanged<String?> onChanged,
    String? selectedValue,
  }) {
    return IntrinsicWidth(
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 100,
        ),
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
                  style: const TextStyle(
                    color: Color(0xFFA7EBF2),
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
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
