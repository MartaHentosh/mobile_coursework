import 'package:cours_work/data/models/restaurant.dart';
import 'package:cours_work/data/services/restaurants_service.dart';
import 'package:flutter/material.dart';

class RestaurantsRepository {
  final RestaurantsService _service = RestaurantsService();

  Future<List<Restaurant>> fetchRestaurants() async {
    try {
      return await _service.getAllRestaurants();
    } catch (e) {
      debugPrint('❌ fetchRestaurants error: $e');
      return [];
    }
  }

  Future<List<Restaurant>> fetchSorted(String sortBy) async {
    try {
      return await _service.getSortedRestaurants(sortBy);
    } catch (e) {
      debugPrint('❌ fetchSorted error: $e');
      return [];
    }
  }

  Future<String?> saveFiltered({
    required List<int> categoryIds,
    required List<int> textFilterIds,
  }) async {
    try {
      final response = await _service.saveFiltered(
        categoryIds: categoryIds,
        textFilterIds: textFilterIds,
      );

      final searchId = response['search_id'];
      if (searchId == null) {
        debugPrint('⚠️ saveFiltered не повернув search_id');
        return null;
      }

      return searchId.toString();
    } catch (e) {
      debugPrint('❌ saveFiltered error: $e');
      return null;
    }
  }

  Future<List<Restaurant>> fetchSavedFiltered({
    required String searchId,
  }) async {
    try {
      return await _service.getSavedFiltered(searchId: searchId);
    } catch (e) {
      debugPrint('❌ fetchSavedFiltered error: $e');
      return [];
    }
  }

  Future<Restaurant?> fetchRestaurantById(int id) async {
    try {
      final data = await _service.getRestaurantById(id);
      return Restaurant.fromJson(data);
    } catch (e) {
      debugPrint('❌ fetchRestaurantById error: $e');
      return null;
    }
  }
}
