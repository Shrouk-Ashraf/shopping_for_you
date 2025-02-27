import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:four_you_ecommerce/core/constants/app_colors.dart';
import 'package:four_you_ecommerce/modules/home/cubit/home_cubit.dart';
import 'package:four_you_ecommerce/modules/products/products_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    super.initState();

    context.read<HomeCubit>().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = HomeCubit.get(context);
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: AppColors.lightGrey,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 24,
              ),
              child: Column(
                children: [
                  const Text(
                    "Categories",
                    style: TextStyle(
                        color: AppColors.textPrimaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                  if (state is LoadingCategories)
                    const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  if (state is SuccessCategories)
                    cubit.categories.isNotEmpty
                        ? Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 24, horizontal: 24),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BlocProvider.value(
                                                  value: cubit,
                                                  child: ProductsScreen(
                                                      category: cubit
                                                          .categories[index]),
                                                ))).then((val) {
                                      cubit.getCategories();
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    margin: const EdgeInsets.only(top: 24),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(18),
                                        color: Colors.white,
                                        border: Border.all(color: Colors.blue)),
                                    child: Text(cubit.categories[index]),
                                  ),
                                ),
                                itemCount: cubit.categories.length,
                              ),
                            ),
                          )
                        : const Center(
                            child: Text("There is no categories"),
                          ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
