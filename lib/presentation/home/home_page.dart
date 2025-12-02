import 'package:cours_work/presentation/home/cubit/restaurants_cubit.dart';
import 'package:cours_work/presentation/home/widgets/home_categories.dart';
import 'package:cours_work/presentation/home/widgets/home_filters/home_filters_bar.dart';
import 'package:cours_work/presentation/home/widgets/home_restaurants_list.dart';
import 'package:cours_work/presentation/home/widgets/home_search_bar.dart';
import 'package:cours_work/presentation/home/widgets/home_subscribe_brands.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? _selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    const categoryIcons = [
      'assets/images/pizza-slice.png',
      'assets/images/burger-alt.png',
      'assets/images/burrito.png',
      'assets/images/fork-spaghetti.png',
      'assets/images/sushi.png',
      'assets/images/avocado-toast.png',
      'assets/images/ceviche.png',
      'assets/images/candy-bar.png',
      'assets/images/bowl-chopsticks-noodles.png',
      'assets/images/croissant.png',
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF011C40),

      body: Stack(
        children: [
          Container(
            height: 170,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF023859), Color(0xFF26658C)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFA7EBF2),
                  blurRadius: 10,
                  spreadRadius: 0.8,
                  offset: Offset(0, 1),
                ),
                BoxShadow(
                  color: Color(0xFFA7EBF2),
                  blurRadius: 40,
                  spreadRadius: -10,
                  offset: Offset(0, 30),
                ),
              ],
            ),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: HomeSearchBar(),
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20)
                        .copyWith(bottom: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HomeCategories(
                          imageAssets: categoryIcons,
                          selectedIndex: _selectedCategoryId,
                          onCategorySelected: (categoryId) async {
                            setState(() {
                              _selectedCategoryId =
                              _selectedCategoryId == categoryId
                                  ? null
                                  : categoryId;
                            });

                            final cubit = context.read<RestaurantsCubit>();
                            if (_selectedCategoryId == null) {
                              await cubit.applyFilters(
                                categoryIds: [],
                                textFilterIds: [],
                              );
                            } else {
                              await cubit.applyFilters(
                                categoryIds: [_selectedCategoryId!],
                                textFilterIds: [],
                              );
                            }
                          },
                        ),

                        const SizedBox(height: 20),
                        const HomeFiltersBar(),
                        const SizedBox(height: 25),


                        const SizedBox(height: 25),
                        const HomeSubscribeBrands(),
                        const SizedBox(height: 25),

                        BlocBuilder<RestaurantsCubit, RestaurantsState>(
                          builder: (context, state) {
                            if (state is RestaurantsLoading) {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 50),
                                  child: CircularProgressIndicator(
                                    color: Color(0xFFA7EBF2),
                                  ),
                                ),
                              );
                            } else if (state is RestaurantsLoaded) {
                              return AnimatedSwitcher(
                                duration: const Duration(milliseconds: 250),
                                child: HomeRestaurantsList(
                                  key: ValueKey(state.restaurants.hashCode),
                                  restaurants: state.restaurants,
                                ),
                              );
                            } else if (state is RestaurantsError) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 50),
                                child: Text(
                                  'Помилка: ${state.message}',
                                  style: const TextStyle(color: Colors.red),
                                ),
                              );
                            } else {
                              return const Padding(
                                padding: EdgeInsets.only(top: 50),
                                child: Text(
                                  'Ресторани не знайдено',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
