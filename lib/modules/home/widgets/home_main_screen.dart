import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:four_you_ecommerce/core/constants/app_colors.dart';
import 'package:four_you_ecommerce/core/inputs/search_text_field.dart';
import 'package:four_you_ecommerce/main.dart';
import 'package:four_you_ecommerce/modules/cart/cubit/cart_cubit.dart';
import 'package:four_you_ecommerce/modules/home/cubit/home_cubit.dart';
import 'package:four_you_ecommerce/modules/home/widgets/product_card.dart';

class HomeMainScreen extends StatefulWidget {
  const HomeMainScreen(
      {super.key, required this.isSearch, required this.onSearch});
  final bool isSearch;
  final Function(bool) onSearch;
  @override
  State<HomeMainScreen> createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends State<HomeMainScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isSearch = false;
  @override
  void initState() {
    super.initState();
    isSearch = widget.isSearch;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = HomeCubit.get(context);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello, ${prefs!.getString('username')}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SearchTextField(
                    controller: searchController,
                    onChanged: (value) {
                      debugPrint("onchanged");
                      if (value == null || value.isEmpty) {
                        setState(() {
                          isSearch = false;
                        });
                      } else {
                        setState(() {
                          isSearch = true;
                        });
                        cubit.searchedProducts = cubit.products
                            .where((product) => product.title
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                            .toList();
                        widget.onSearch(isSearch).call();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    "Popular Categories",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  state is LoadingCategories
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : cubit.categories.isNotEmpty
                          ? SizedBox(
                              height: 80,
                              width: double.infinity,
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) => Column(
                                        children: [
                                          const CircleAvatar(
                                            backgroundColor: Colors.white,
                                            child: Icon(
                                              Icons.category,
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            cubit.categories[index],
                                            style: const TextStyle(
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        width: 16,
                                      ),
                                  itemCount: cubit.categories.length),
                            )
                          : const Center(
                              child: Text("No Categories",
                                  style: TextStyle(color: Colors.white))),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 18),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 18),
                      child: Text(
                        "Products",
                        style: TextStyle(
                            color: AppColors.textPrimaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    state is LoadingProducts
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          )
                        : Expanded(
                            child: GridView.builder(
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(8.0),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                childAspectRatio: 0.6,
                              ),
                              itemCount: cubit.products.length,
                              itemBuilder: (context, index) {
                                final product = cubit.products[index];
                                return ProductCard(
                                  product: product,
                                );
                              },
                            ),
                          )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
