import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:four_you_ecommerce/core/constants/app_colors.dart';
import 'package:four_you_ecommerce/core/helpers/toasts.dart';
import 'package:four_you_ecommerce/core/inputs/search_text_field.dart';
import 'package:four_you_ecommerce/main.dart';
import 'package:four_you_ecommerce/modules/cart/cubit/cart_cubit.dart';
import 'package:four_you_ecommerce/modules/home/cubit/home_cubit.dart';
import 'package:four_you_ecommerce/modules/home/models/product.dart';
import 'package:four_you_ecommerce/modules/home/widgets/home_main_screen.dart';
import 'package:four_you_ecommerce/modules/home/widgets/product_card.dart';
import 'package:four_you_ecommerce/modules/home/widgets/search_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearch = false;
  bool isAddedToCart = false;
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getCategories();
    context.read<HomeCubit>().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      final cubit = HomeCubit.get(context);

      return Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.primaryColor,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 24,
            ),
            child: isSearch == true
                ? SearchScreen(
                    cubit: cubit,
                    isSearch: isSearch,
                    onSearch: (value) {
                      setState(() {
                        isSearch = value;
                      });
                    },
                  )
                : HomeMainScreen(
                    isSearch: isSearch,
                    onSearch: (value) {
                      setState(() {
                        isSearch = value;
                      });
                    },
                  ),
          ),
        ),
      );
    });
  }
}
