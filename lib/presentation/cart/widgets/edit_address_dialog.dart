import 'package:flutter/material.dart';

Future<String?> showEditAddressDialog(
    BuildContext context,
    String currentAddress,
    ) {
  final controller = TextEditingController(text: currentAddress);

  return showDialog<String>(
    context: context,
    builder: (_) {
      return AlertDialog(
        backgroundColor: const Color(0xFF023859),
        title: const Text(
          'Змінити адресу',
          style: TextStyle(color: Colors.white),
        ),
        content: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Введіть адресу',
            hintStyle: TextStyle(color: Colors.white38),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Скасувати'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('Зберегти'),
          ),
        ],
      );
    },
  );
}
