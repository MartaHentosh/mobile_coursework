class Dish {
  final int id;
  final String name;
  final String description;
  final double price;
  final double weight;
  final String imageUrl;

  Dish({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.weight,
    required this.imageUrl,
  });

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      id: (json['id'] ?? 0) as int,
      name: (json['name'] ?? '') as String,
      description: (json['description'] ?? '') as String,
      price: (json['price'] is num)
          ? (json['price'] as num).toDouble()
          : double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      weight: (json['weight'] is num)
          ? (json['weight'] as num).toDouble()
          : double.tryParse(json['weight']?.toString() ?? '0') ?? 0.0,
      imageUrl: (json['image_url'] ?? '') as String,
    );
  }
}

class Restaurant {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final double rating;
  final int deliveryTime;
  final double deliveryFee;
  final double minOrder;
  final double distance;
  final List<Dish> dishes;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.minOrder,
    required this.distance,
    this.dishes = const [],
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: (json['id'] ?? 0) as int,
      name: (json['name'] ?? '') as String,
      description: (json['description'] ?? '') as String,
      imageUrl: (json['image_url'] ?? '') as String,
      rating: (json['rating'] is num)
          ? (json['rating'] as num).toDouble()
          : double.tryParse(json['rating']?.toString() ?? '0') ?? 0.0,
      deliveryTime: (json['delivery_time'] ?? 0) as int,
      deliveryFee: (json['delivery_fee'] is num)
          ? (json['delivery_fee'] as num).toDouble()
          : double.tryParse(json['delivery_fee']?.toString() ?? '0') ?? 0.0,
      minOrder: (json['min_order'] is num)
          ? (json['min_order'] as num).toDouble()
          : double.tryParse(json['min_order']?.toString() ?? '0') ?? 0.0,
      distance: (json['distance'] is num)
          ? (json['distance'] as num).toDouble()
          : double.tryParse(json['distance']?.toString() ?? '0') ?? 0.0,

      dishes:
          (json['dishes'] as List<dynamic>?)
              ?.map((e) => Dish.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
