import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import '../utility/constants/string_constants.dart';
import '../utility/result.dart';
import 'api_constants.dart';
import 'connectivity_service.dart';
import 'dio_exception.dart';

enum ContentType { urlEncoded, json, multipart }

class DioClient {
  final ConnectivityService connectivityService = ConnectivityService();

  DioClient() {
    _dio = Dio();
    _dio.options.sendTimeout =
    const Duration(milliseconds: APIEndPoints.sendTimeOut);
    _dio.options.connectTimeout =
    const Duration(milliseconds: APIEndPoints.connectionTimeout);
    _dio.options.receiveTimeout =
    const Duration(milliseconds: APIEndPoints.receiveTimeout);

    _baseUrl = APIEndPoints.baseUrl;
  }

  late Dio _dio;

  late String _baseUrl;

  // Changed return type to dynamic to handle both Map and List
  Future<Result<dynamic>> get(
      String path, {
        String? newBaseUrl,
        String? token,
        Map<String, dynamic>? query,
        Map<String, String>? newHeaders,
        ContentType contentType = ContentType.json,
      }) async {
    final hasConnection =
    await connectivityService.checkInternetConnection();

    if (!hasConnection) {
      return const Failure(kNoInternetConnection);
    }

    final url = (newBaseUrl ?? _baseUrl) + path;

    final headers = {
      'accept': '*/*',
      'Content-Type': contentType == ContentType.json
          ? 'application/json; charset=utf-8'
          : 'application/x-www-form-urlencoded',
    };

    try {
      final response = await _dio.get(
        url,
        queryParameters: query,
        options: Options(headers: newHeaders ?? headers),
      );

      if (response.statusCode != null && response.statusCode! < 300) {
        return Success(response.data); // No casting - returns whatever type it is
      } else {
        return Failure(handleError(response));
      }
    } on DioException catch (e) {
      if (e.error is SocketException) {
        return const Failure(kNoInternetConnection);
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return const Failure(kRequestTimeout);
      } else {
        return Failure(
          DioExceptions.fromDioError(e).toString(),
        );
      }
    } catch (e) {
      return Failure(e.toString());
    }
  }

}