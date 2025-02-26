import 'package:flutter/material.dart';
import 'package:four_you_ecommerce/core/constants/app_colors.dart';
import 'package:four_you_ecommerce/modules/home/models/product.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.isAddedToCart,
    required this.onAddedToCart,
  });

  final Product product;
  final bool isAddedToCart;
  final VoidCallback onAddedToCart;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  List<Product> cartProducts = [];

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.darkerGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Image.network(
                  widget.product.image,
                  height: 170,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.warning,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Text(
                        widget.product.rating.rate.toString(),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 12,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppColors.textPrimaryColor),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  widget.product.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: AppColors.textSecondaryColor, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${widget.product.price.toString()} \$",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.onAddedToCart.call();
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 16),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Text(
                          softWrap: true,
                          widget.isAddedToCart ? "Remove" : "Add",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
