part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {}

final class RemovedFromCart extends CartState {}

final class AddedToCart extends CartState {}
