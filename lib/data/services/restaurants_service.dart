import 'package:cours_work/data/models/restaurant.dart';
import 'package:cours_work/data/services/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantsService {
  final Dio _dio = ApiClient.dio;

  Future<List<Restaurant>> getAllRestaurants() async {
    try {
      final Response<List<dynamic>> res = await _dio.get<List<dynamic>>(
        '/home/restaurants',
        options: Options(
          headers: {'Cache-Control': 'no-cache', 'Pragma': 'no-cache'},
        ),
      );

      final data = res.data ?? [];
      return data
          .map((e) => Restaurant.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('❌ getAllRestaurants error: $e');
      return [];
    }
  }

  Future<List<Restaurant>> getSortedRestaurants(String sortBy) async {
    try {
      final Response<List<dynamic>> res = await _dio.get<List<dynamic>>(
        '/home/restaurants/sort-by',
        queryParameters: {'sort_by': sortBy},
        options: Options(
          headers: {'Cache-Control': 'no-cache', 'Pragma': 'no-cache'},
        ),
      );

      final data = res.data ?? [];
      return data
          .map((e) => Restaurant.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('❌ getSortedRestaurants error: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>> saveFiltered({
    required List<int> categoryIds,
    required List<int> textFilterIds,
  }) async {
    try {
      if (categoryIds.isEmpty && textFilterIds.isEmpty) {
        debugPrint('⚠️ Пропущено saveFiltered — обидва списки порожні');
        return {};
      }

      final Response<Map<String, dynamic>> res = await _dio
          .post<Map<String, dynamic>>(
        '/home/restaurants/save-filtered',
        data: {
          'category_ids': categoryIds,
          'text_filter_ids': textFilterIds,
        },
        options: Options(
          headers: {'Cache-Control': 'no-cache', 'Pragma': 'no-cache'},
        ),
      );

      debugPrint('✅ saveFiltered → ${res.data}');
      return res.data ?? {};
    } catch (e) {
      debugPrint('❌ saveFiltered error: $e');
      rethrow;
    }
  }

  Future<List<Restaurant>> getSavedFiltered({required String searchId}) async {
    try {
      final Response<List<dynamic>> res = await _dio.get(
        '/home/restaurants/sort-filtered',
        queryParameters: {'search_id': searchId},
      );
      final List<dynamic> data = res.data ?? [];
      return data
          .map((e) => Restaurant.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('❌ getSavedFiltered error: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>> getRestaurantById(int id) async {
    try {
      final Response<Map<String, dynamic>> res =
      await _dio.get<Map<String, dynamic>>(
        '/home/restaurants/$id',
        options: Options(
          headers: {'Cache-Control': 'no-cache', 'Pragma': 'no-cache'},
        ),
      );

      return res.data ?? {};
    } catch (e) {
      debugPrint('❌ getRestaurantById error: $e');
      rethrow;
    }
  }
}
