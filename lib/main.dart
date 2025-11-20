import 'package:cours_work/core/theme.dart';
import 'package:cours_work/data/repositories/restaurants_repository.dart';
import 'package:cours_work/navigation/app_routes.dart';
import 'package:cours_work/navigation/route_generator.dart';
import 'package:cours_work/presentation/home/cubit/restaurants_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  runApp(const BlueBiteApp());
}

class BlueBiteApp extends StatelessWidget {
  const BlueBiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              RestaurantsCubit(RestaurantsRepository())..loadRestaurants(),
        ),
      ],
      child: MaterialApp(
        title: 'BlueBite',
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        initialRoute: AppRoutes.login,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
