import 'package:cours_work/data/services/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CartService {
  final Dio _dio = ApiClient.dio;

  Future<bool> addToCart({
    required int userId,
    required int dishId,
    int quantity = 1,
  }) async {
    try {
      final res = await _dio.post<dynamic>(
        '/home/cart/add',
        data: {'user_id': userId, 'dish_id': dishId, 'quantity': quantity},
      );

      return res.statusCode == 201;
    } catch (e) {
      debugPrint('❌ addToCart error: $e');
      return false;
    }
  }
}
