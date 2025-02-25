import 'dart:convert';

import 'package:four_you_ecommerce/core/constants/constants.dart';
import 'package:four_you_ecommerce/core/network/dio/dio_helper.dart';
import 'package:four_you_ecommerce/modules/authentication/models/signup_request_model.dart';
import 'package:four_you_ecommerce/modules/authentication/models/signup_response_model.dart';

class Repository {
  final DioHelper dioHelper;

  Repository({
    required this.dioHelper,
  });

  Future<SignUpResponseModel> addNewUser(
      {required SignUpRequestModel request}) async {
    try {
      Map<String, dynamic> data = request.toJson();
      final response = await dioHelper.post('${Constants.baseUrl}users',
          data: jsonEncode(data));
      return SignUpResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> login({required Map<String, dynamic> request}) async {
    try {
      final response = await dioHelper.post('${Constants.baseUrl}users',
          data: jsonEncode(request));
      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  }
}
