import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:four_you_ecommerce/modules/cart/cart_screen.dart';
import 'package:four_you_ecommerce/modules/categories/categories_screen.dart';
import 'package:four_you_ecommerce/modules/home/home_screen.dart';
import 'package:meta/meta.dart';

part 'home_layout_state.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutState> {
  HomeLayoutCubit() : super(HomeInitial());
  static HomeLayoutCubit get(BuildContext context) => BlocProvider.of(context);

  final screens = [
    HomeScreen(),
    CategoriesScreen(),
    CartScreen(),
    Container(color: Colors.black),
  ];
}
