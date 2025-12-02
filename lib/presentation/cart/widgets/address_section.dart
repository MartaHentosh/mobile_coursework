import 'package:flutter/material.dart';

class AddressSection extends StatelessWidget {
  final String address;
  final VoidCallback onTap;

  const AddressSection({required this.address, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Адреса доставки',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              const Icon(Icons.location_on, color: Colors.white70),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  address,
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.white),
            ],
          ),
        ),
      ],
    );
  }
}
