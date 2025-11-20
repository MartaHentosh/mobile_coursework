import 'package:cours_work/presentation/home/cubit/restaurants_cubit.dart';
import 'package:cours_work/presentation/home/widgets/home_filters/filter_dropdown.dart';
import 'package:cours_work/presentation/home/widgets/home_filters/filter_toggle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeFiltersBar extends StatefulWidget {
  const HomeFiltersBar({super.key});

  @override
  State<HomeFiltersBar> createState() => _HomeFiltersBarState();
}

class _HomeFiltersBarState extends State<HomeFiltersBar> {
  bool promoActive = false;
  bool takeawayActive = false;
  bool popularActive = false;

  String? selectedSort;
  String? selectedDeliveryType;

  final List<Map<String, String>> sortOptions = [
    {'label': 'Рейтинг ↑', 'value': 'rating_asc'},
    {'label': 'Рейтинг ↓', 'value': 'rating_desc'},
    {'label': 'Ціна доставки ↑', 'value': 'delivery_fee_asc'},
    {'label': 'Ціна доставки ↓', 'value': 'delivery_fee_desc'},
    {'label': 'Відстань ↑', 'value': 'distance_asc'},
    {'label': 'Відстань ↓', 'value': 'distance_desc'},
  ];

  final List<Map<String, String>> deliveryOptions = [
    {'label': 'Усі типи', 'value': 'all'},
    {'label': 'Доставка', 'value': 'delivery'},
    {'label': 'Самовивіз', 'value': 'pickup'},
  ];

  void _applyTextFilters() {
    final textFilters = <int>[];
    if (promoActive) textFilters.add(1);
    if (takeawayActive) textFilters.add(3);
    if (popularActive) textFilters.add(4);

    context.read<RestaurantsCubit>().applyFilters(
      categoryIds: [],
      textFilterIds: textFilters,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const SizedBox(width: 4),

          FilterToggle(
            text: 'Промоакції',
            active: promoActive,
            onTap: () {
              setState(() => promoActive = !promoActive);
              _applyTextFilters();
            },
          ),
          const SizedBox(width: 8),

          FilterToggle(
            text: 'На виніс',
            active: takeawayActive,
            onTap: () {
              setState(() => takeawayActive = !takeawayActive);
              _applyTextFilters();
            },
          ),
          const SizedBox(width: 8),

          FilterDropdown(
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

          FilterDropdown(
            label: 'Тип доставки',
            selectedValue: selectedDeliveryType,
            options: deliveryOptions,
            onChanged: (value) {
              setState(() => selectedDeliveryType = value);
              debugPrint('Тип доставки: $value');
            },
          ),
          const SizedBox(width: 8),

          FilterToggle(
            text: 'Найпопулярніше',
            active: popularActive,
            onTap: () {
              setState(() => popularActive = !popularActive);
              _applyTextFilters();
            },
          ),

          const SizedBox(width: 4),
        ],
      ),
    );
  }
}
