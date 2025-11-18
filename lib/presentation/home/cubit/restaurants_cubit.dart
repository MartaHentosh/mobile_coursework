import 'package:cours_work/data/models/restaurant.dart';
import 'package:cours_work/data/repositories/restaurants_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'restaurants_state.dart';

class RestaurantsCubit extends Cubit<RestaurantsState> {
  final RestaurantsRepository _repo;

  RestaurantsCubit(this._repo) : super(RestaurantsInitial());

  Future<void> loadRestaurants() async {
    if (state is RestaurantsLoading) return;
    emit(RestaurantsLoading());

    try {
      final data = await _repo.fetchRestaurants();
      if (data.isEmpty) {
        emit(RestaurantsError('Список ресторанів порожній'));
      } else {
        emit(RestaurantsLoaded(data));
      }
    } catch (e) {
      emit(RestaurantsError('Помилка при завантаженні: $e'));
    }
  }

  Future<void> sortRestaurants(String sortBy) async {
    emit(RestaurantsLoading());
    try {
      final sorted = await _repo.fetchSorted(sortBy);
      if (sorted.isEmpty) {
        emit(RestaurantsError('Порожній результат після сортування'));
      } else {
        emit(RestaurantsLoaded(sorted));
      }
    } catch (e) {
      emit(RestaurantsError('Помилка при сортуванні: $e'));
    }
  }

  Future<void> applyFilters({
    required List<int> categoryIds,
    required List<int> textFilterIds,
  }) async {
    if (categoryIds.isEmpty && textFilterIds.isEmpty) {
      debugPrint('⚠️ Пропущено saveFiltered — обидва списки порожні');
      await loadRestaurants();
      return;
    }

    emit(RestaurantsLoading());
    try {
      final searchId = await _repo.saveFiltered(
        categoryIds: categoryIds,
        textFilterIds: textFilterIds,
      );

      if (searchId == null || searchId.isEmpty) {
        emit(RestaurantsError('❌ Не вдалося отримати search_id'));
        return;
      }

      final filtered = await _repo.fetchSavedFiltered(searchId: searchId);

      if (filtered.isEmpty) {
        emit(RestaurantsError('Ресторани не знайдено за вибраними фільтрами'));
      } else {
        emit(RestaurantsLoaded(filtered));
      }
    } catch (e) {
      emit(RestaurantsError('Помилка при застосуванні фільтрів: $e'));
    }
  }
}
