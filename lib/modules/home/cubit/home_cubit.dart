import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  final screens = [
    Container(color: Colors.green),
    Container(color: Colors.amber),
    Container(color: Colors.blue),
    Container(color: Colors.black),
  ];
}
