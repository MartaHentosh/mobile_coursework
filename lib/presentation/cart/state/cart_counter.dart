import 'package:flutter/material.dart';

class CartCounter {
  final ValueNotifier<int> count = ValueNotifier<int>(0);

  void increment() {
    count.value++;
  }

  void reset() {
    count.value = 0;
  }
}

final cartCounter = CartCounter();
