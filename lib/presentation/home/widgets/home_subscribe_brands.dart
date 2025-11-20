import 'package:flutter/material.dart';

class HomeSubscribeBrands extends StatelessWidget {
  const HomeSubscribeBrands({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_PremiumCard(), _BrandsCard()],
      ),
    );
  }
}

class _PremiumCard extends StatelessWidget {
  const _PremiumCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 120,
      decoration: BoxDecoration(
        color: const Color(0xFF011C40),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFA7EBF2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            const Positioned(
              left: 0,
              top: 0,
              right: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Оформляй Преміум\nдля свого акаунту',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Та заощаджуй на доставці',
                    style: TextStyle(
                      color: Color(0xFFA7EBF2),
                      fontSize: 10.5,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 4,
              bottom: 4,
              child: Image.asset(
                'assets/images/user-group-crown.png',
                width: 30,
                height: 30,
                color: const Color(0xFFA7EBF2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BrandsCard extends StatelessWidget {
  const _BrandsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 120,
      decoration: BoxDecoration(
        color: const Color(0xFF011C40),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFA7EBF2)),
      ),
      child: const Padding(
        padding:  EdgeInsets.all(12),
        child: Stack(
          children: [
             Positioned(
              left: 0,
              top: 0,
              right: 24,
              child: Text(
                'Найкращі бренди',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
             Positioned(
              top: 0,
              right: 0,
              child: Icon(
                Icons.chevron_right,
                size: 18,
                color: Color(0xFFA7EBF2),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Row(
                children: [
                  _BrandLogo(path: 'assets/images/macdonald.png'),
                   SizedBox(width: 6),
                  _BrandLogo(path: 'assets/images/iq_pizza.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BrandLogo extends StatelessWidget {
  final String path;

  const _BrandLogo({required this.path});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(path, fit: BoxFit.contain),
      ),
    );
  }
}
