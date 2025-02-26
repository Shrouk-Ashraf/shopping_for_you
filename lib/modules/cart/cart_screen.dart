import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:four_you_ecommerce/core/di/di.dart';
import 'package:four_you_ecommerce/modules/cart/cubit/cart_cubit.dart';
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
    return BlocConsumer(
        builder: (context, state) {
          return ValueListenableBuilder(
            valueListenable: Hive.box<Product>('cartBox').listenable(),
            builder: (context, Box<Product> box, _) {
              List<Product> products = box.values.toList();
              return SizedBox();
            },
          );
        },
        listener: (context, state) {});
  }
}
