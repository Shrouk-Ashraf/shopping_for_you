import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:four_you_ecommerce/core/constants/app_colors.dart';
import 'package:four_you_ecommerce/core/helpers/toasts.dart';
import 'package:four_you_ecommerce/modules/cart/cubit/cart_cubit.dart';
import 'package:four_you_ecommerce/modules/home/models/product.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 1;

  void increment() {
    setState(() {
      quantity++;
    });
  }

  void decrement() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    quantity = widget.product.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is AddedToCart) {
          Toasts.showSuccessToast(
              context, "Product is Added to cart Successfully");
        }
      },
      builder: (context, state) {
        return BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            final cubit = CartCubit.get(context);
            return Scaffold(
              appBar: AppBar(),
              body: Container(
                width: double.infinity,
                height: double.infinity,
                color: AppColors.lightGrey,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 18),
                    child: Column(
                      children: [
                        Image.network(
                          widget.product.image,
                          height: 170,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: AppColors.secondaryColor,
                              size: 24,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              widget.product.rating.rate.toString(),
                              style: const TextStyle(
                                  color: AppColors.textPrimaryColor,
                                  fontWeight: FontWeight.normal),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              "(${widget.product.rating.count.toString()})",
                              style: const TextStyle(
                                  color: AppColors.textPrimaryColor,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Price: ",
                              style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${widget.product.price.toString()} \$",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: AppColors.textPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Text(
                          widget.product.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: AppColors.textPrimaryColor),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Flexible(
                          child: Text.rich(TextSpan(children: [
                            const TextSpan(
                              text: "Description: ",
                              style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: widget.product.description,
                              style: const TextStyle(
                                  color: AppColors.textSecondaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            )
                          ])),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              bottomNavigationBar:Container(
                  color: Colors.white12,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          _quantityButton(Icons.remove, decrement),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              '$quantity',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          _quantityButton(Icons.add, increment),
                        ],
                      ),
                      ElevatedButton.icon(
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
                          setState(() {
                            debugPrint(
                                "is in cart ${cubit.cartProducts.contains(widget.product)}");
                            cubit.addToCart(widget.product, quantity);
                          });
                        },
                        icon: const Icon(Icons.shopping_bag_outlined,color: Colors.white,),
                        label: const Text("Add to Cart"),
                      ),
                    ],
                  )),
            );
          },
        );
      },
    );
  }

  Widget _quantityButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon),
      style: IconButton.styleFrom(
        backgroundColor: Colors.grey,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
      ),
    );
  }
}
