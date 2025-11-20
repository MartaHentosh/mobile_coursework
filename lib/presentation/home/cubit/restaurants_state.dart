part of 'restaurants_cubit.dart';

abstract class RestaurantsState {}

class RestaurantsInitial extends RestaurantsState {}

class RestaurantsLoading extends RestaurantsState {}

class RestaurantsLoaded extends RestaurantsState {
  final List<Restaurant> restaurants;
  RestaurantsLoaded(this.restaurants);
}

class RestaurantsError extends RestaurantsState {
  final String message;
  RestaurantsError(this.message);
}
