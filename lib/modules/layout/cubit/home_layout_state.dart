part of 'home_layout_cubit.dart';

@immutable
sealed class HomeLayoutState {}

final class HomeInitial extends HomeLayoutState {}
final class ChangeState extends HomeLayoutState {}
