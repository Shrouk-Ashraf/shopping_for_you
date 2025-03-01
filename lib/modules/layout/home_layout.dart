import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:four_you_ecommerce/core/constants/app_colors.dart';
import 'package:four_you_ecommerce/core/di/di.dart';
import 'package:four_you_ecommerce/modules/cart/cubit/cart_cubit.dart';
import 'package:four_you_ecommerce/modules/home/cubit/home_cubit.dart';
import 'package:four_you_ecommerce/modules/layout/cubit/home_layout_cubit.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    return
        BlocProvider(
          create: (context) => di<HomeCubit>(),

      child: BlocBuilder<HomeLayoutCubit, HomeLayoutState>(
        builder: (context, state) {
          final cubit = HomeLayoutCubit.get(context);
          return Scaffold(
            bottomNavigationBar: NavigationBar(
              // elevation: 0,
              selectedIndex: cubit.currentIndex,
              onDestinationSelected: (index) {
                cubit.changeIndex(index);
              },
              backgroundColor: AppColors.darkerGrey,
              indicatorColor: AppColors.primaryColor.withOpacity(0.3),
              destinations: const [
                NavigationDestination(
                    icon: Icon(
                      Icons.home_rounded,
                      color: Colors.grey,
                    ),
                    selectedIcon: Icon(
                      Icons.home_rounded,
                      color: AppColors.primaryColor,
                    ),
                    label: "Home"),
                NavigationDestination(
                    icon: Icon(
                      Icons.category,
                      color: Colors.grey,
                    ),
                    selectedIcon: Icon(
                      Icons.category,
                      color: AppColors.primaryColor,
                    ),
                    label: "Categories"),
                NavigationDestination(
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.grey,
                    ),
                    selectedIcon: Icon(
                      Icons.shopping_cart,
                      color: AppColors.primaryColor,
                    ),
                    label: "Cart"),

              ],
            ),
            body: cubit.screens[cubit.currentIndex],
          );
        },
      ),
    );
  }
}
