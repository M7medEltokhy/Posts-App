import 'package:dio/dio.dart';
import 'package:posts_app/core/network/api_error.dart';

class ApiExceptions {
  static ApiError handleError(DioException error) {
    print('❌ DioException type: ${error.type}');
    print('❌ Status code: ${error.response?.statusCode}');
    print('❌ Response data: ${error.response?.data}');
    print('❌ Message: ${error.message}');
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    if (statusCode == 302) {
      return ApiError(
        message: 'This Email Already Exists',
        statusCode: statusCode,
      );
    }

    if (statusCode != 200 &&
        statusCode != 201 &&
        data is Map<String, dynamic>) {
      return ApiError(
        message: data['message'] ?? 'Something went wrong',
        statusCode: statusCode,
      );
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(message: 'Connection timeout with API server');
      case DioExceptionType.sendTimeout:
        return ApiError(message: 'Send timeout with API server');
      case DioExceptionType.receiveTimeout:
        return ApiError(
          message: 'Receive timeout in connection with API server',
        );
      case DioExceptionType.badResponse:
        return ApiError(message: 'Something went wrong');
      case DioExceptionType.badCertificate:
        return ApiError(message: 'Bad certificate');
      case DioExceptionType.cancel:
        return ApiError(message: 'Request to API server was cancelled');
      case DioExceptionType.connectionError:
        return ApiError(message: 'No internet connection');
      case DioExceptionType.unknown:
        return ApiError(message: 'Something went wrong');
    }
  }
}
