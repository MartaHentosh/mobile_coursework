import 'package:cours_work/presentation/cart/widgets/payment_option_tile.dart';
import 'package:flutter/material.dart';

class PaymentSection extends StatelessWidget {
  final String selectedMethod;
  final ValueChanged<String?> onChanged;

  const PaymentSection({
    required this.selectedMethod,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Спосіб оплати',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        PaymentOptionTile(
          value: 'card',
          title: 'Карта',
          icon: Icons.credit_card,
          groupValue: selectedMethod,
          onChanged: onChanged,
        ),
        PaymentOptionTile(
          value: 'cash',
          title: 'Готівка',
          icon: Icons.payments,
          groupValue: selectedMethod,
          onChanged: onChanged,
        ),
      ],
    );
  }
}