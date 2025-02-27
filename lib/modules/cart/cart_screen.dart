import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:four_you_ecommerce/core/constants/app_colors.dart';
import 'package:four_you_ecommerce/core/di/di.dart';
import 'package:four_you_ecommerce/core/helpers/show_success_dialog.dart';
import 'package:four_you_ecommerce/core/helpers/toasts.dart';
import 'package:four_you_ecommerce/modules/cart/cubit/cart_cubit.dart';
import 'package:four_you_ecommerce/modules/cart/widgets/cart_card.dart';
import 'package:four_you_ecommerce/modules/home/models/product.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(builder: (context, state) {
      final cubit = CartCubit.get(context);
      return Container(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      "Cart",
                      style: TextStyle(
                          color: AppColors.textPrimaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                    state is CartLoading
                        ? const Expanded(
                            child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          ))
                        : Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 24, horizontal: 18),
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) => CartCard(
                                        cartProduct: cubit.cartProducts[index],
                                        onRemove: () {
                                          cubit.removeFromCart(
                                              cubit.cartProducts[index]);
                                        },
                                      ),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        height: 12,
                                      ),
                                  itemCount: cubit.cartProducts.length),
                            ),
                          )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 18),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    showSuccessDialog(context, "Your Cart is Submitted");
                  },
                  icon: const Icon(Icons.check_circle_outline_rounded),
                  label: Text(
                      "Checkout ${cubit.cartProducts.fold(0.0, (total, product) => total + (product.price * product.quantity)).toStringAsFixed(2)}"),
                ),
              ),
            ],
          ),
        ),
      );
    }, listener: (context, state) {
      if (state is RemovedFromCart) {
        Toasts.showSuccessToast(
            context, "Product is Removed from cart Successfully");
      }
    });
  }
}
