import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:four_you_ecommerce/core/network/repository.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final Repository repository;
  LoginCubit(this.repository) : super(LoginInitial());
  static LoginCubit get(BuildContext context) => BlocProvider.of(context);
  void addNewUser() {
    final f = repository.login();
  }
}
