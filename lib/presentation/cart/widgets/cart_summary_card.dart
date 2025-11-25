import 'package:flutter/material.dart';

class CartSummaryCard extends StatelessWidget {
  final double totalSum;
  final double bonus;
  final VoidCallback onCheckout;

  const CartSummaryCard({
    required this.totalSum,
    required this.bonus,
    required this.onCheckout,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF023859),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          _buildRow('Сума', '${totalSum.toStringAsFixed(0)}₴', Colors.white),
          const SizedBox(height: 6),
          _buildRow(
            'Бонуси',
            '+${bonus.toStringAsFixed(0)}₴',
            Colors.greenAccent,
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: onCheckout,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFA7EBF2),
              foregroundColor: Colors.black,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Оплатити'),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value, Color valueColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 16),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
