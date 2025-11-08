import 'package:cours_work/core/app_colors.dart';
import 'package:cours_work/data/services/local_storage.dart';
import 'package:cours_work/navigation/app_routes.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: AppColors.glow, size: 80),
            const SizedBox(height: 20),
            const Text(
              'Ви успішно увійшли!',
              style: TextStyle(color: AppColors.glow, fontSize: 24),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                await LocalStorage.saveToken("");
                Navigator.pushReplacementNamed(context, AppRoutes.login);
              },
              child: null,
            ),
          ],
        ),
      ),
    );
  }
}
