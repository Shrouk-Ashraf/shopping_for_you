part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class LoadingCategories extends HomeState {}

final class SuccessCategories extends HomeState {}

final class FailedCategories extends HomeState {}

final class LoadingProducts extends HomeState {}

final class SuccessProducts extends HomeState {}

final class FailedProducts extends HomeState {}

final class LoadingProductsByCategory extends HomeState {}

final class SuccessProductsByCategory extends HomeState {}

final class FailedProductsByCategory extends HomeState {}
