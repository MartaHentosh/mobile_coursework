import 'package:cours_work/data/models/cart.dart';
import 'package:cours_work/data/services/cart_service.dart';
import 'package:flutter/material.dart';

class CartRepository {
  final CartService _service = CartService();

  Future<Object> addDishToCart({
    required int userId,
    required int dishId,
    int quantity = 1,
  }) async {
    try {
      final result = await _service.addToCart(
        userId: userId,
        dishId: dishId,
        quantity: quantity,
      );
      return result;
    } catch (e) {
      debugPrint('❌ addDishToCart error: $e');
      return false;
    }
  }

  Future<List<CartItem>> fetchCart(int userId) async {
    try {
      return await _service.getCart(userId);
    } catch (e) {
      debugPrint('❌ fetchCart error: $e');
      return [];
    }
  }

  Future<bool> clearCart(int userId) async {
    try {
      return await _service.clearCart(userId);
    } catch (e) {
      debugPrint('❌ clearCart error: $e');
      return false;
    }
  }

  Future<bool> checkout(int userId) async {
    try {
      return await _service.checkout(userId);
    } catch (e) {
      debugPrint('❌ checkout error: $e');
      return false;
    }
  }
}
