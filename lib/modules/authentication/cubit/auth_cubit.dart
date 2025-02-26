import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:four_you_ecommerce/core/network/repository.dart';
import 'package:four_you_ecommerce/modules/authentication/models/signup_request_model.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final Repository _repository;
  AuthCubit(this._repository) : super(AuthInitial());
  static AuthCubit get(BuildContext context) => BlocProvider.of(context);

  int? signUpId;
  Future<void> addNewUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String userName,
    required String phoneNumber,
  }) async {
    emit(SignUpLoading());
    try {
      final f = await _repository.addNewUser(
        request: SignUpRequestModel(
          email: email,
          password: password,
          firstName: firstName,
          lastName: lastName,
          userName: userName,
          phoneNumber: phoneNumber,
        ),
      );
      signUpId = f.id;
      emit(SignUpSuccess());
    } on Exception catch (e) {
      emit(SignUpFailed(error: e.toString()));
    }
  }

  Future<void> login({
    required String username,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      final f = await _repository.login(
        request: {
          "username": username,
          "password": password,
        },
      );
      emit(LoginSuccess());
    } on Exception catch (e) {
      debugPrint("error");
      emit(LoginFailed(error: e.toString()));
    }
  }
}
