import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    required this.selectedIndex, required this.onTap, super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: Color(0xFF023859),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFA7EBF2),
            blurRadius: 25,
            spreadRadius: -5,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 45,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildIcon(Icons.home_outlined, 0),
                const SizedBox(width: 80),
                _buildIcon(Icons.person_outline, 2),
              ],
            ),
          ),

          Positioned(
            top: -28,
            child: GestureDetector(
              onTap: () => onTap(1),
              child: Container(
                height: 72,
                width: 72,
                decoration: BoxDecoration(
                  color: const Color(0xFF023859),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFA7EBF2).withValues(alpha: 0.9),
                      blurRadius: 30,
                      spreadRadius: -5,
                      offset: const Offset(0, 10),
                    ),
                  ],
                  border: Border.all(
                    color: const Color(0xFFA7EBF2),
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(IconData icon, int index) {
    final bool active = selectedIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Icon(
        icon,
        color: active ? Colors.white : const Color(0xFF011C40),
        size: 35,
      ),
    );
  }
}
