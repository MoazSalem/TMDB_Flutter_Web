import 'dart:io';
import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final String? details;

  ApiException(this.message, {this.details});

  @override
  String toString() =>
      'AppException: $message${details != null ? " ($details)" : ""}';

  static ApiException fromDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException('Connection timeout', details: e.message);
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final statusMessage = e.response?.statusMessage;
        return ApiException(
          'Bad response from server',
          details: 'Status: $statusCode, Message: $statusMessage',
        );
      case DioExceptionType.cancel:
        return ApiException('Request was cancelled');
      case DioExceptionType.connectionError:
        return ApiException('Connection error', details: e.message);
      case DioExceptionType.unknown:
      default:
        if (e.error is SocketException) {
          return ApiException('No Internet connection');
        }
        return ApiException('Unexpected error', details: e.message);
    }
  }
}
