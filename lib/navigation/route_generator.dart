import 'package:cours_work/core/app_colors.dart';
import 'package:cours_work/navigation/app_routes.dart';
import 'package:cours_work/presentation/auth/login_page.dart';
import 'package:cours_work/presentation/auth/register_page.dart';
import 'package:cours_work/presentation/cart/cart_page.dart';
import 'package:cours_work/presentation/cart/success_page.dart';
import 'package:cours_work/presentation/navigation/navigation_root.dart';
import 'package:cours_work/presentation/profile/pages/admin_users_page.dart';
import 'package:cours_work/presentation/profile/pages/profile_orders_page.dart';
import 'package:cours_work/presentation/profile/profile_page.dart';
import 'package:cours_work/presentation/restaurant_details/restaurant_details_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
      case AppRoutes.login:
        return _fadeRoute(const LoginPage(), settings);

      case AppRoutes.register:
        return _fadeRoute(const RegisterPage(), settings);

      case AppRoutes.root:
        return _slideRoute(const NavigationRoot(), settings);

      case AppRoutes.home:
        return _slideRoute(const NavigationRoot(), settings);

      case AppRoutes.restaurantDetails:
        final restaurantId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => RestaurantDetailsPage(restaurantId: restaurantId),
        );

      case AppRoutes.cart:
        return _slideRoute(const CartPage(), settings);

      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());

      case AppRoutes.profileOrders:
        return MaterialPageRoute(builder: (_) => const ProfileOrdersPage());

      case AppRoutes.success:
        return MaterialPageRoute(builder: (_) => const OrderSuccessPage());

      case AppRoutes.adminUsers:
        return MaterialPageRoute(builder: (_) => const AdminUsersPage());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _fadeRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  static Route<dynamic> _slideRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animation);
        return SlideTransition(position: offsetAnimation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Text(
            '404 — Page not found',
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
        ),
      ),
    );
  }
}
