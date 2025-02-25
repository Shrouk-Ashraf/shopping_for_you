import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:four_you_ecommerce/core/constants/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper {
  late Dio _client;

  DioHelper() {
    _client = Dio()
      ..interceptors.addAll([
        if (kDebugMode)
          PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            error: true,
          ),
      ])
      ..options.baseUrl = Constants.baseUrl
      ..options.headers.addAll({
        'Accept': 'application/json',
      });
  }

  Future<Response<T>> get<T>(
    String url, {
    Map<String, dynamic>? queryParams,
  }) {
    return _client.get(
      url,
      queryParameters: queryParams,
    );
  }

  Future<Response<T>> post<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParams,
  }) {
    return _client.post(
      url,
      data: data,
      queryParameters: queryParams,
    );
  }

  Future<Response<T>> put<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParams,
  }) {
    return _client.put(
      url,
      data: data,
      queryParameters: queryParams,
    );
  }

  Future<Response<T>> patch<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParams,
  }) {
    return _client.patch(
      url,
      data: data,
      queryParameters: queryParams,
    );
  }

  Future<Response<T>> delete<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParams,
  }) {
    return _client.delete(
      url,
      data: data,
      queryParameters: queryParams,
    );
  }
}
