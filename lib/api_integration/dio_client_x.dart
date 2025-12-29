import 'package:dio/dio.dart';

import 'api_constants.dart';

class DioClientX {
  final Dio _dio = Dio();
  final String baseUrl = APIEndPoints.baseUrl;

  DioClientX();

  BaseOptions _dioOptions() {
    BaseOptions opts = BaseOptions();
    opts.baseUrl = baseUrl;
    opts.connectTimeout =
        const Duration(milliseconds: APIEndPoints.connectionTimeout);
    opts.receiveTimeout =
        const Duration(milliseconds: APIEndPoints.receiveTimeout);
    opts.sendTimeout = const Duration(milliseconds: APIEndPoints.sendTimeOut);
    return opts;
  }

  Dio provideDio() {
    _dio.options = _dioOptions();
    return _dio;
  }
}
