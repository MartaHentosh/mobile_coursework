import 'package:flutter/material.dart';

class PaymentOptionTile extends StatelessWidget {
  final String value;
  final String title;
  final IconData icon;
  final String groupValue;
  final ValueChanged<String?> onChanged;

  const PaymentOptionTile({
    required this.value,
    required this.title,
    required this.icon,
    required this.groupValue,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(value),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Radio<String>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
            fillColor: WidgetStateProperty.all(Colors.white),
          ),
        ],
      ),
    );
  }
}
