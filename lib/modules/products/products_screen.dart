import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:four_you_ecommerce/core/constants/app_colors.dart';
import 'package:four_you_ecommerce/modules/cart/cubit/cart_cubit.dart';
import 'package:four_you_ecommerce/modules/home/cubit/home_cubit.dart';
import 'package:four_you_ecommerce/modules/home/widgets/product_card.dart';

class ProductsScreen extends StatefulWidget {
  final String category;
  const ProductsScreen({super.key, required this.category});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getProductsByCategory(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final cartCubit = CartCubit.get(context);
        return BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final cubit = HomeCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text(
                  "Products",
                  style: TextStyle(
                      color: AppColors.textPrimaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
              ),
              body: Container(
                width: double.infinity,
                height: double.infinity,
                color: AppColors.lightGrey,
                child: SafeArea(
                  child: RefreshIndicator(
                    onRefresh: ()async{
                      cubit.getProductsByCategory(widget.category);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state is LoadingProductsByCategory)
                          const Expanded(
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        if (state is SuccessProductsByCategory)
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
                                );
                              },
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
