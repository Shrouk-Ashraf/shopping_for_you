import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:four_you_ecommerce/core/network/repository.dart';
import 'package:four_you_ecommerce/modules/home/models/product.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final Repository _repository;
  HomeCubit(this._repository) : super(HomeInitial());
  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  List<String> categories = <String>[];
  List<Product> products = <Product>[];
  List<Product> searchedProducts = <Product>[];
  void getCategories() async {
    emit(LoadingCategories());
    await Future.delayed(
        Duration(milliseconds: 300)); //to show the loading indicator
    try {
      final f = await _repository.getCategories();
      debugPrint("categories are $f");
      categories.clear();
      categories.addAll(f);
      emit(SuccessCategories());
    } on Exception catch (e) {
      emit(FailedCategories());
    }
  }

  void getProducts() async {
    emit(LoadingProducts());
    await Future.delayed(
        Duration(milliseconds: 300)); //to show the loading indicator
    try {
      final f = await _repository.getProducts();
      products.clear();
      products.addAll(f);
      emit(SuccessProducts());
    } on Exception catch (e) {
      emit(FailedProducts());
    }
  }

  void getProductsByCategory(String category) async {
    emit(LoadingProductsByCategory());
    try {
      final f = await _repository.getProductsByCategory(category);
      products.clear();
      products.addAll(f);
      emit(SuccessProductsByCategory());
    } on Exception catch (e) {
      emit(FailedProductsByCategory());
    }
  }
}
