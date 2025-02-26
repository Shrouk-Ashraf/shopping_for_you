import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:four_you_ecommerce/core/constants/app_colors.dart';
import 'package:four_you_ecommerce/core/helpers/toasts.dart';
import 'package:four_you_ecommerce/core/inputs/search_text_field.dart';
import 'package:four_you_ecommerce/main.dart';
import 'package:four_you_ecommerce/modules/cart/cubit/cart_cubit.dart';
import 'package:four_you_ecommerce/modules/home/cubit/home_cubit.dart';
import 'package:four_you_ecommerce/modules/home/models/product.dart';
import 'package:four_you_ecommerce/modules/home/widgets/product_card.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearch = false;
  final TextEditingController searchController = TextEditingController();
  bool isAddedToCart = false;
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getCategories();
    context.read<HomeCubit>().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is AddedToCart) {
          Toasts.showSuccessToast(
              context, "This Product added to the cart, Successfully");
        } else if (state is RemovedFromCart) {
          Toasts.showSuccessToast(
              context, "This Product removed from the cart, Successfully");
        }
      },
      builder: (context, state) {
        return BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            final cartCubit = CartCubit.get(context);
            return BlocConsumer<HomeCubit, HomeState>(
                listener: (context, state) {},
                builder: (context, state) {
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
                            ? searchScreen(cubit, cartCubit)
                            : mainScreen(cubit, cartCubit),
                      ),
                    ),
                  );
                });
          },
        );
      },
    );
  }

  Widget mainScreen(HomeCubit cubit, CartCubit cartCubit) {
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
              if (cubit.categories.isNotEmpty)
                SizedBox(
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
                                style: const TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 16,
                          ),
                      itemCount: cubit.categories.length),
                ),
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
                Expanded(
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
                        isAddedToCart: cartCubit.cartProducts.contains(product),
                        onAddedToCart: () {
                          setState(() {
                            debugPrint(
                                "is in cart ${cartCubit.cartProducts.contains(product)}");
                            if (cartCubit.cartProducts.contains(product)) {
                              cartCubit.removeFromCart(product);
                            } else {
                              cartCubit.addToCart(product);
                            }
                            isAddedToCart =
                                cartCubit.cartProducts.contains(product);
                          });
                        },
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
  }

  Widget searchScreen(HomeCubit cubit, CartCubit cartCubit) {
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
                  }
                },
              ),
            ],
          ),
        ),
        cubit.searchedProducts.isNotEmpty
            ? Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.6,
                  ),
                  itemCount: cubit.searchedProducts.length,
                  itemBuilder: (context, index) {
                    final product = cubit.searchedProducts[index];
                    return ProductCard(
                      product: product,
                      isAddedToCart: isAddedToCart,
                      onAddedToCart: () {
                        setState(() {
                          if (cartCubit.cartProducts.contains(product)) {
                            cartCubit.removeFromCart(product);
                          } else {
                            cartCubit.addToCart(product);
                          }
                          isAddedToCart =
                              cartCubit.cartProducts.contains(product);
                        });
                      },
                    );
                  },
                ),
              )
            : const Center(
                child: const CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              ),
      ],
    );
  }
}
