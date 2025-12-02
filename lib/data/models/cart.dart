class CartItem {
  final int cartItemId;
  final int dishId;
  final String dishName;
  final double dishPrice;
  final int quantity;

  CartItem({
    required this.cartItemId,
    required this.dishId,
    required this.dishName,
    required this.dishPrice,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      cartItemId: json['cart_item_id'] as int,
      dishId: json['dish_id'] as int,
      dishName: json['dish_name'] as String,
      dishPrice: (json['dish_price'] as num).toDouble(),
      quantity: json['quantity'] as int,
    );
  }
}
