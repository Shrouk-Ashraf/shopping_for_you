import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:four_you_ecommerce/core/constants/app_colors.dart';
import 'package:four_you_ecommerce/core/di/di.dart';
import 'package:four_you_ecommerce/modules/home/cubit/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<HomeCubit>(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cubit = HomeCubit.get(context);
          return Scaffold(
            bottomNavigationBar: NavigationBar(
              elevation: 0,
              selectedIndex: selectedIndex,
              onDestinationSelected: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              backgroundColor: Colors.white,
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
                      Icons.shopping_bag_outlined,
                      color: Colors.grey,
                    ),
                    selectedIcon: Icon(
                      Icons.shopping_bag_outlined,
                      color: AppColors.primaryColor,
                    ),
                    label: "Shop"),
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
                NavigationDestination(
                    icon: Icon(
                      Icons.person,
                      color: Colors.grey,
                    ),
                    selectedIcon: Icon(
                      Icons.person,
                      color: AppColors.primaryColor,
                    ),
                    label: "Profile"),
              ],
            ),
            body: cubit.screens[selectedIndex],
          );
        },
      ),
    );
  }
}
