import 'package:fpdart/fpdart.dart';

import '../../failure/network/network_failure.dart';

abstract class NetworkBaseApiService {
  Future<Either<NetworkFailure, T>> get<T>({required String url});

  Future<Either<NetworkFailure, T>> post<T>(
      {required String url,
      required Map<String, dynamic> body,
      Map<String, String>? headers});

  Future<Either<NetworkFailure, T>> patch<T>(
      {required String url,
      required Map<String, dynamic> body,
      Map<String, String>? headers});
}
