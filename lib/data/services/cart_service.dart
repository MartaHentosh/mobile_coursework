import 'package:cours_work/data/models/cart.dart';
import 'package:cours_work/data/services/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CartService {
  final Dio _dio = ApiClient.dio;

  Future<Map<String, dynamic>> addToCart({
    required int userId,
    required int dishId,
    int quantity = 1,
  }) async {
    try {
      final Response<Map<String, dynamic>> res = await _dio
          .post<Map<String, dynamic>>(
            '/home/cart/add',
            data: {'user_id': userId, 'dish_id': dishId, 'quantity': quantity},
            options: Options(
              headers: {'Cache-Control': 'no-cache', 'Pragma': 'no-cache'},
            ),
          );

      return res.data ?? {};
    } catch (e) {
      debugPrint('❌ addToCart error: $e');
      rethrow;
    }
  }

  Future<List<CartItem>> getCart(int userId) async {
    try {
      final Response<List<dynamic>> res = await _dio.get<List<dynamic>>(
        '/home/cart/$userId',
        options: Options(
          headers: {'Cache-Control': 'no-cache', 'Pragma': 'no-cache'},
        ),
      );

      final List<dynamic> data = res.data ?? [];

      return data
          .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('❌ getCart error: $e');
      return [];
    }
  }

  Future<bool> clearCart(int userId) async {
    try {
      final Response<Map<String, dynamic>> res = await _dio
          .delete<Map<String, dynamic>>(
            '/home/cart/$userId/clear',
            options: Options(
              headers: {'Cache-Control': 'no-cache', 'Pragma': 'no-cache'},
            ),
          );

      return res.statusCode != null && res.statusCode! < 300;
    } catch (e) {
      debugPrint('❌ clearCart error: $e');
      return false;
    }
  }

  Future<bool> checkout(int userId) async {
    try {
      final Response<Map<String, dynamic>> res = await _dio
          .post<Map<String, dynamic>>(
            '/home/cart/$userId/checkout',
            options: Options(
              headers: {'Cache-Control': 'no-cache', 'Pragma': 'no-cache'},
            ),
          );

      return res.statusCode != null && res.statusCode! < 300;
    } catch (e) {
      debugPrint('❌ checkout error: $e');
      return false;
    }
  }
}
