import 'package:cours_work/data/models/restaurant.dart';
import 'package:cours_work/data/repositories/cart_repository.dart';
import 'package:cours_work/data/repositories/restaurants_repository.dart';
import 'package:cours_work/data/services/local_storage.dart';
import 'package:cours_work/navigation/app_routes.dart';
import 'package:cours_work/presentation/cart/state/cart_counter.dart';
import 'package:flutter/material.dart';

class RestaurantDetailsPage extends StatefulWidget {
  final int restaurantId;

  const RestaurantDetailsPage({required this.restaurantId, super.key});

  @override
  State<RestaurantDetailsPage> createState() => _RestaurantDetailsPageState();
}

class _RestaurantDetailsPageState extends State<RestaurantDetailsPage> {
  final RestaurantsRepository _restaurantsRepo = RestaurantsRepository();
  final CartRepository _cartRepo = CartRepository();

  Restaurant? restaurant;
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadRestaurant();
  }

  Future<void> _loadRestaurant() async {
    try {
      final data = await _restaurantsRepo.fetchRestaurantById(
        widget.restaurantId,
      );
      if (!mounted) return;

      setState(() {
        restaurant = data;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  Future<void> _handleAddDish(int dishId, String dishName) async {
    final int? userId = await LocalStorage.getUserId();

    if (userId == null) {
      debugPrint('❌ userId is NULL — можливо юзер не залогінений');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Помилка: користувач не авторизований')),
      );
      return;
    }

    try {
      await _cartRepo.addDishToCart(userId: userId, dishId: dishId);

      if (!mounted) return;

      cartCounter.increment();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('$dishName — додано в кошик')));
    } catch (e) {
      if (!mounted) return;

      debugPrint('Error adding to cart: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Помилка додавання в кошик')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFF001C2A),
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    if (error != null || restaurant == null) {
      return const Scaffold(
        backgroundColor: Color(0xFF001C2A),
        body: Center(
          child: Text(
            'Помилка завантаження ресторану',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF001C2A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF023859),
        iconTheme: const IconThemeData(color: Color(0xFFA7EBF2)),
        title: Text(
          restaurant!.name,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          ValueListenableBuilder(
            valueListenable: cartCounter.count,
            builder: (_, value, __) {
              return Stack(
                alignment: Alignment.topRight,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.cart);
                    },
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Color(0xFFA7EBF2),
                    ),
                  ),
                  if (value > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.redAccent,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          value.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: restaurant!.imageUrl.startsWith('http')
                ? Image.network(
                    restaurant!.imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    restaurant!.imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
          ),

          const SizedBox(height: 20),

          Text(
            restaurant!.description,
            style: const TextStyle(color: Colors.white70, fontSize: 15),
          ),

          const SizedBox(height: 24),

          const Text(
            'Страви',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 12),

          ...restaurant!.dishes.map(
            (d) => Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF023859),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: d.imageUrl.startsWith('http')
                        ? Image.network(
                            d.imageUrl,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            d.imageUrl,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                  ),
                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          d.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          d.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${d.price.toStringAsFixed(0)
                          }₴ · ${d.weight.toStringAsFixed(0)} г',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),

                  IconButton(
                    onPressed: () => _handleAddDish(d.id, d.name),
                    icon: const Icon(
                      Icons.add_circle_outline,
                      color: Color(0xFFA7EBF2),
                      size: 26,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
