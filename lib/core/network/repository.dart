import 'dart:convert';

import 'package:four_you_ecommerce/core/constants/constants.dart';
import 'package:four_you_ecommerce/core/network/dio/dio_helper.dart';
import 'package:four_you_ecommerce/modules/authentication/models/signup_request_model.dart';
import 'package:four_you_ecommerce/modules/authentication/models/signup_response_model.dart';
import 'package:four_you_ecommerce/modules/home/models/product.dart';

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
      final response = await dioHelper.post('${Constants.baseUrl}auth/login',
          data: jsonEncode(request));
      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<String>> getCategories() async {
    try {
      final response =
          await dioHelper.get('${Constants.baseUrl}products/categories');
      return List<String>.from(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Product>> getProducts() async {
    try {
      final response = await dioHelper.get('${Constants.baseUrl}products');
      if (response.data is List) {
        return (response.data as List)
            .map((json) => Product.fromJson(json))
            .toList();
      } else {
        throw Exception('Unexpected response format: ${response.data}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Product>> getProductsByCategory(String category) async {
    try {
      final response = await dioHelper
          .get('${Constants.baseUrl}products/category/$category');
      if (response.data is List) {
        return (response.data as List)
            .map((json) => Product.fromJson(json))
            .toList();
      } else {
        throw Exception('Unexpected response format: ${response.data}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
