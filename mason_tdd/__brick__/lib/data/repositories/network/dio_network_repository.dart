// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';

// import 'package:fpdart/fpdart.dart';
// import 'package:dio/dio.dart';

// import '/domain/failures/network/network_failure.dart';
// import '/data/datasources/auth/login_data_sources.dart';
// import '/domain/repositories/network/network_base_api_service.dart';

// class DioNetworkRepository implements NetworkBaseApiService {
//   final LoginDataSources _loginDataSources;
//   final Dio _dio;

//   DioNetworkRepository(this._loginDataSources) : _dio = Dio();

//   @override
//   Future<Either<NetworkFailure, T>> get<T>({required String url}) async {
//     try {
//       final response = await _dio.get(
//         url,
//         options: Options(
//           headers: {'Authorization': 'Bearer ${_loginDataSources.state.token}'},
//           receiveTimeout: const Duration(seconds: 10),
//         ),
//       );
//       final failure = _handleStatusCode(response);
//       if (failure != null) {
//         return left(failure);
//       }
//       return right(response.data);
//     } on DioException catch (e) {
//       return left(_handleDioError(e));
//     }
//   }

//   @override
//   Future<Either<NetworkFailure, T>> post<T>(
//       {required String url,
//       required Map<String, dynamic> body,
//       Map<String, String>? headers}) async {
//     try {
//       final response = await _dio.post(
//         url,
//         data: body,
//         options: Options(
//           headers: headers,
//           receiveTimeout: const Duration(seconds: 10),
//         ),
//       );
//       final failure = _handleStatusCode(response);
//       if (failure != null) {
//         return left(failure);
//       }
//       return right(response.data);
//     } on DioException catch (e) {
//       return left(_handleDioError(e));
//     }
//   }

//   @override
//   Future<Either<NetworkFailure, T>> patch<T>(
//       {required String url,
//       required Map<String, dynamic> body,
//       Map<String, String>? headers}) async {
//     try {
//       final response = await _dio.patch(
//         url,
//         data: body,
//         options: Options(
//           headers: headers ??
//               {'Authorization': 'Bearer ${_loginDataSources.state.token}'},
//           receiveTimeout: const Duration(seconds: 10),
//         ),
//       );
//       final failure = _handleStatusCode(response);
//       if (failure != null) {
//         return left(failure);
//       }
//       return right(response.data);
//     } on DioException catch (e) {
//       return left(_handleDioError(e));
//     }
//   }

//   NetworkFailure? _handleStatusCode(Response response) {
//     if (response.statusCode == 400 ||
//         response.statusCode == 401 ||
//         response.statusCode == 403 ||
//         response.statusCode == 404 ||
//         response.statusCode == 500) {
//       final Map<String, dynamic> responseData = response.data;
//       return NetworkFailure(error: responseData['message'] ?? "Error");
//     }
//     return null;
//   }

//   NetworkFailure _handleDioError(DioException error) {
//     if (error.type == DioExceptionType.receiveTimeout ||
//         error.type == DioExceptionType.connectionTimeout) {
//       return NetworkFailure(
//           error: 'Please check your internet connection and try again.');
//     } else if (error.type == DioExceptionType.unknown &&
//         error.error is SocketException) {
//       return NetworkFailure(error: 'No Internet Connection');
//     } else {
//       return NetworkFailure(error: 'Unexpected error occurred.');
//     }
//   }
// }
