import 'dart:convert';

import 'package:cours_work/data/repositories/cart_repository.dart';
import 'package:cours_work/data/repositories/profile_repository.dart';
import 'package:cours_work/data/services/local_storage.dart';
import 'package:cours_work/navigation/app_routes.dart';
import 'package:cours_work/presentation/cart/state/cart_counter.dart';
import 'package:flutter/material.dart';

class ProfileOrdersPage extends StatefulWidget {
  const ProfileOrdersPage({super.key});

  @override
  State<ProfileOrdersPage> createState() => _ProfileOrdersPageState();
}

class _ProfileOrdersPageState extends State<ProfileOrdersPage> {
  final ProfileRepository _repo = ProfileRepository();
  final CartRepository _cartRepo = CartRepository();

  bool loading = true;
  List<Map<String, dynamic>> orders = [];

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    final data = await _repo.getOrderHistory();
    setState(() {
      orders = List<Map<String, dynamic>>.from(data);
      loading = false;
    });
  }

  List<Map<String, dynamic>> safeParseItems(dynamic raw) {
    if (raw == null) return [];

    if (raw is List) {
      return raw.map<Map<String, dynamic>>((e) {
        if (e is Map) return Map<String, dynamic>.from(e);
        return <String, dynamic>{};
      }).toList();
    }

    if (raw is String) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is List) {
          return decoded.map<Map<String, dynamic>>((e) {
            if (e is Map) return Map<String, dynamic>.from(e);
            return <String, dynamic>{};
          }).toList();
        }
      } catch (_) {}
      return [];
    }

    return [];
  }

  Future<void> repeatOrder(List<Map<String, dynamic>> items) async {
    final userId = await LocalStorage.getUserId();
    if (userId == null) return;

    for (final item in items) {
      final dynamic rawDishId = item['dish_id'];
      final dynamic rawQty = item['quantity'];

      final int dishId = rawDishId is int
          ? rawDishId
          : int.parse(rawDishId.toString());

      final int quantity = rawQty is int
          ? rawQty
          : int.tryParse(rawQty.toString()) ?? 1;

      await _cartRepo.addDishToCart(
        userId: userId,
        dishId: dishId,
        quantity: quantity,
      );

      cartCounter.increment();
    }

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Страви додано до кошика!')));

    Navigator.pushNamed(context, AppRoutes.cart);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF001C2A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF023859),
        iconTheme: const IconThemeData(color: Color(0xFFA7EBF2)),
        title: const Text(
          'Історія замовлень',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              itemBuilder: (_, i) {
                final order = orders[i];
                final items = safeParseItems(order['items']);

                return Container(
                  margin: const EdgeInsets.only(bottom: 18),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF023859),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFA7EBF2).withValues(alpha: 0.25),
                        blurRadius: 25,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Замовлення #${order['id']}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),

                      Text(
                        "Сума: ${order['total']}₴",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      ),

                      const SizedBox(height: 12),

                      ...items.map((item) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            "• ${item['dish_name']} — ${item['quantity']
                            } × ${item['price']}₴",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        );
                      }),

                      const SizedBox(height: 16),

                      GestureDetector(
                        onTap: () => repeatOrder(items),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFFA7EBF2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Замовити ще раз',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
