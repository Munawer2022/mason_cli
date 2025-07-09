import 'package:fpdart/fpdart.dart';

import '/domain/failures/network/network_failure.dart';

abstract class NetworkBaseApiService {
  Future<Either<NetworkFailure, T>> get<T>({
    required String url,
    Map<String, dynamic>? queryParams,
  });

  Future<Either<NetworkFailure, T>> post<T>({
    required String url,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
    // Map<String, dynamic>? queryParams,
    // bool isFormData = false
  });

  Future<Either<NetworkFailure, T>> patch<T>({
    required String url,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
    // bool isFormData = false
  });
  Future<Either<NetworkFailure, T>> put<T>({
    required String url,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    // Map<String, dynamic>? queryParams,
    // Map<String, File>? files
    // bool isFormData = false
  });
  Future<Either<NetworkFailure, T>> delete<T>({
    required String url,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  });
}
