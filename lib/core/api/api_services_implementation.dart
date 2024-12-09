import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tasky/core/api/api_services.dart';
import 'package:tasky/core/api/app_interceptors.dart';
import 'package:tasky/core/api/end_points.dart';
import 'package:tasky/core/utils/app_constants.dart';

class ApiServicesImplementation extends ApiServices{
  late final Dio _dio;
  final AppInterceptors appInterceptors;

  ApiServicesImplementation(this.appInterceptors) {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: EndPoints.baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppConstants.accessToken}',
          'Accept': 'application/json',
        });
    _dio = Dio(baseOptions);
    _dio.interceptors.add(appInterceptors);
    _dio.interceptors.add(prettyDioLogger());
  }

  prettyDioLogger() => PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
      enabled: kDebugMode,
      filter: (options, args) {
        // don't print requests with uris containing '/posts'
        if (options.path.contains('/posts')) {
          return false;
        }
        // don't print responses with unit8 list data
        return !args.isResponse || !args.hasUint8ListData;
      });

  @override
  Future<Response> get({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    Response data = await _dio.get(endPoint, queryParameters: queryParameters);
    return data;
  }

  @override
  Future<Response> post(
      {required String endPoint,
      Map<String, dynamic>? queryParameters,
      String? token,
      required dynamic data}) async {
    return await _dio.post(endPoint,
        queryParameters: queryParameters, data: data);
  }
  @override
  Future<Response> put(
      {required String endPoint,
      Map<String, dynamic>? queryParameters,
      String? token,
      required dynamic data}) async {
    return await _dio.put(endPoint,
        queryParameters: queryParameters, data: data);
  }

  @override
  Future<Response> delete({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    String? token,
    dynamic data,
  }) async {
    return await _dio.delete(
      endPoint,
      queryParameters: queryParameters,
      data: data,
    );
  }
}
