import 'package:flutter/material.dart';
import 'package:four_you_ecommerce/core/constants/app_colors.dart';
import 'package:four_you_ecommerce/modules/cart/cubit/cart_cubit.dart';
import 'package:four_you_ecommerce/modules/home/models/product.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    super.key,
    required this.cartProduct,
    required this.onRemove,
  });
  final VoidCallback onRemove;
  final Product cartProduct;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: AppColors.primaryColor)),
      leading: Image.network(
        cartProduct.image,
        height: 80,
        width: 80,
        fit: BoxFit.cover,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text(cartProduct.title)),
          IconButton(
            onPressed: onRemove,
            icon: const Icon(
              Icons.delete_forever,
              color: AppColors.error,
            ),
          ),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Quantity: ${cartProduct.quantity}"),
          Text(
            "${cartProduct.quantity * cartProduct.price} \$",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
