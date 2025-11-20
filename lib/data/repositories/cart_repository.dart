import 'package:cours_work/data/services/cart_service.dart';

class CartRepository {
  final CartService _service = CartService();

  Future<bool> addDishToCart({
    required int userId,
    required int dishId,
    int quantity = 1,
  }) async {
    return await _service.addToCart(
      userId: userId,
      dishId: dishId,
      quantity: quantity,
    );
  }
}
