import 'package:cours_work/data/models/cart.dart';
import 'package:cours_work/data/repositories/cart_repository.dart';
import 'package:cours_work/presentation/cart/state/cart_counter.dart';
import 'package:cours_work/presentation/cart/widgets/address_section.dart';
import 'package:cours_work/presentation/cart/widgets/cart_item_tile.dart';
import 'package:cours_work/presentation/cart/widgets/cart_summary_card.dart';
import 'package:cours_work/presentation/cart/widgets/delivery_section.dart';
import 'package:cours_work/presentation/cart/widgets/edit_address_dialog.dart';
import 'package:cours_work/presentation/cart/widgets/payment_section.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartRepository _cartRepo = CartRepository();

  // ХАРДКОД ЦІНИ ДОСТАВКИ
  static const double _fixedDeliveryFee = 40.0;

  List<CartItem> _cart = [];
  bool _loading = true;
  String _address = '';
  String _paymentMethod = 'card';
  DeliveryType _deliveryType = DeliveryType.courier;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.wait([_loadCart(), _loadLocalPrefs()]);
  }

  Future<void> _loadCart() async {
    const int userId = 1;
    final data = await _cartRepo.fetchCart(userId);
    if (mounted) {
      setState(() {
        _cart = data;
        _loading = false;
      });
    }
  }

  Future<void> _loadLocalPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        _address = prefs.getString('address') ?? 'вул. Кульпарківська 174';
        _paymentMethod = prefs.getString('payment') ?? 'card';
      });
    }
  }

  Future<void> _updateAddress() async {
    final newAddress = await showEditAddressDialog(context, _address);
    if (newAddress != null && mounted) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('address', newAddress);
      setState(() => _address = newAddress);
    }
  }

  Future<void> _changePayment(String? value) async {
    if (value == null) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('payment', value);
    setState(() => _paymentMethod = value);
  }

  Future<void> _checkout() async {
    const int userId = 1;
    final ok = await _cartRepo.checkout(userId);
    if (!mounted) return;

    if (ok) {
      cartCounter.reset();
      Navigator.pop(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Замовлення оформлено!')));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Помилка оформлення')));
    }
  }

  // Рахуємо суму за їжу
  double get _foodSum {
    return _cart.fold(0, (sum, item) => sum + (item.dishPrice * item.quantity));
  }

  // Якщо кур'єр — додаємо 40 грн, якщо ні — 0
  double get _currentDeliveryPrice {
    return _deliveryType == DeliveryType.courier ? _fixedDeliveryFee : 0.0;
  }

  // Фінальна сума
  double get _totalSum => _foodSum + _currentDeliveryPrice;

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        backgroundColor: Color(0xFF001C2A),
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF001C2A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF023859),
        iconTheme: const IconThemeData(color: Color(0xFFA7EBF2)),
        title: const Text('Кошик', style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ..._cart.map((item) => CartItemTile(item: item)),
          const SizedBox(height: 24),
          DeliverySection(
            selectedType: _deliveryType,
            deliveryFee: _fixedDeliveryFee,
            onTypeChanged: (type) => setState(() => _deliveryType = type),
          ),

          if (_deliveryType == DeliveryType.courier) ...[
            const SizedBox(height: 24),
            AddressSection(address: _address, onTap: _updateAddress),
          ],

          const SizedBox(height: 24),
          PaymentSection(
            selectedMethod: _paymentMethod,
            onChanged: _changePayment,
          ),
          const SizedBox(height: 32),
          CartSummaryCard(
            totalSum: _totalSum,
            bonus: _foodSum * 0.05,
            onCheckout: _checkout,
          ),
        ],
      ),
    );
  }
}
