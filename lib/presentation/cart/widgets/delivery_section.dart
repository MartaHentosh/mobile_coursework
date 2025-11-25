import 'package:flutter/material.dart';

enum DeliveryType { courier, pickup }

class DeliverySection extends StatelessWidget {
  final DeliveryType selectedType;
  final double deliveryFee;
  final ValueChanged<DeliveryType> onTypeChanged;

  const DeliverySection({
    required this.selectedType,
    required this.deliveryFee,
    required this.onTypeChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Спосіб отримання',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _DeliveryCard(
                type: DeliveryType.courier,
                title: 'Кур\'єр',
                price: '${deliveryFee.toStringAsFixed(0)}₴',
                isSelected: selectedType == DeliveryType.courier,
                onTap: () => onTypeChanged(DeliveryType.courier),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _DeliveryCard(
                type: DeliveryType.pickup,
                title: 'Самовивіз',
                price: '0₴',
                isSelected: selectedType == DeliveryType.pickup,
                onTap: () => onTypeChanged(DeliveryType.pickup),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DeliveryCard extends StatelessWidget {
  final DeliveryType type;
  final String title;
  final String price;
  final bool isSelected;
  final VoidCallback onTap;

  const _DeliveryCard({
    required this.type,
    required this.title,
    required this.price,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFA7EBF2) : const Color(0xFF023859),
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: const Color(0xFFA7EBF2), width: 2)
              : Border.all(color: Colors.transparent, width: 2),
        ),
        child: Column(
          children: [
            Icon(
              type == DeliveryType.courier
                  ? Icons.delivery_dining
                  : Icons.storefront,
              color: isSelected ? Colors.black : Colors.white70,
              size: 28,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              price,
              style: TextStyle(
                color: isSelected ? Colors.black87 : Colors.white54,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
