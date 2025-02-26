part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginLoading extends AuthState {}

final class LoginFailed extends AuthState {
  final String? error;

  LoginFailed({required this.error});
}

final class LoginSuccess extends AuthState {}

final class SignUpLoading extends AuthState {}

final class SignUpFailed extends AuthState {
  final String? error;

  SignUpFailed({required this.error});
}

final class SignUpSuccess extends AuthState {}
