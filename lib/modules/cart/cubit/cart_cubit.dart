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
    emit(CartLoading());
    await Hive.openBox<Product>('cartBox');
    var cartBox = Hive.box<Product>('cartBox');
    cartProducts = cartBox.values.toList();
    emit(CartLoaded());
  }

  void addToCart(Product product, int quantity) async {
    var cartBox = Hive.box<Product>('cartBox');
    await cartBox.put(product.id, product); // Using product ID as the key

    if (cartBox.containsKey(product.id)) {
      // If product already exists, update quantity
      final existingProduct = cartBox.get(product.id)!;
      existingProduct.quantity = quantity;
      existingProduct.save(); // Save changes to Hive
    } else {
      // If new, add product with quantity
      product.quantity = quantity;
      cartBox.put(product.id, product);
    }
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

  Future<void> checkout()async{
    var cartBox = Hive.box<Product>('cartBox');
    cartBox.clear().then((val){getCartData();});
    emit(CheckoutSuccess());

  }
}
