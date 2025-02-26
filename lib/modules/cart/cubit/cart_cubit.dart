import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:four_you_ecommerce/modules/home/models/product.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  static CartCubit get(BuildContext context) => BlocProvider.of(context);

  List<Product> cartProducts = [];

  void getCartData() async {
    await Hive.openBox<Product>('cartBox');
    var cartBox = Hive.box<Product>('cartBox');
    cartProducts = cartBox.values.toList();
    debugPrint("Cart products is $cartProducts");
  }

  void addToCart(Product product) async {
    var cartBox = Hive.box<Product>('cartBox');
    await cartBox.put(product.id, product); // Using product ID as the key
    debugPrint("added");
    getCartData();
    emit(AddedToCart());
  }

  void removeFromCart(Product product) async {
    var cartBox = Hive.box<Product>('cartBox');
    var key = cartBox.keys.firstWhere(
      (k) => cartBox.get(k)!.id == product.id,
      orElse: () => null, // Handle case where product is not found
    );

    if (key != null) {
      await cartBox.delete(key);
    } else {}

    getCartData();
    emit(RemovedFromCart());
  }
}
