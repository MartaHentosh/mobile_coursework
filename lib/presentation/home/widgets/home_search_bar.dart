import 'package:flutter/material.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0xFF011C40),
          borderRadius: BorderRadius.circular(18),
        ),
        child: TextField(
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF011C40),
            hintText: 'Пошук...',
            hintStyle: TextStyle(
              color: Colors.white.withValues(alpha: 0.45),
              fontSize: 16,
            ),
            suffixIcon: const Padding(
              padding:  EdgeInsets.only(right: 8),
              child: Icon(
                Icons.search_rounded,
                color:  Color(0xFFA7EBF2),
                size: 30,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 16,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
