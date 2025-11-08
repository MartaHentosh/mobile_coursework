import 'package:cours_work/core/theme.dart';
import 'package:cours_work/navigation/app_routes.dart';
import 'package:cours_work/navigation/route_generator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BlueBiteApp());
}

class BlueBiteApp extends StatelessWidget {
  const BlueBiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BlueBite',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      initialRoute: AppRoutes.login,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
