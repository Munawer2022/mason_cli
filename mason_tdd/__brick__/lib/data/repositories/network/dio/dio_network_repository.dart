// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:fpdart/fpdart.dart';

// import '/data/datasources/auth/login_data_sources.dart';
// import '/domain/failures/network/network_failure.dart';
// import '/domain/repositories/local/local_storage_base_api_service.dart';
// import '/domain/repositories/network/network_base_api_service.dart';
// import 'dio_config.dart';

// class DioNetworkRepository implements NetworkBaseApiService {
//   final LoginDataSources _loginDataSources;
//   final LocalStorageRepository _localStorageRepository;
//   late final Dio _dio;

//   DioNetworkRepository(this._loginDataSources, this._localStorageRepository) {
//     _dio = DioConfig.createDio(
//       loginDataSources: _loginDataSources,
//       localStorageRepository: _localStorageRepository,
//     );
//   }

//   @override
//   Future<Either<NetworkFailure, T>> get<T>({
//     required String url,
//     Map<String, dynamic>? queryParams,
//     Map<String, String>? headers,
//   }) async {
//     try {
//       final response = await _dio.get(
//         url,
//         queryParameters: queryParams,
//         options: Options(headers: headers),
//       );

//       return right(response.data);
//     } on DioException catch (e) {
//       return left(_handleDioError(e));
//     } catch (e) {
//       return left(NetworkFailure(error: 'Unexpected error: $e'));
//     }
//   }

//   @override
//   Future<Either<NetworkFailure, T>> post<T>({
//     required String url,
//     required Map<String, dynamic> body,
//     Map<String, String>? headers,
//   }) async {
//     try {
//       final response = await _dio.post(
//         url,
//         data: body,
//         options: Options(headers: headers),
//       );

//       return right(response.data);
//     } on DioException catch (e) {
//       return left(_handleDioError(e));
//     } catch (e) {
//       return left(NetworkFailure(error: 'Unexpected error: $e'));
//     }
//   }

//   @override
//   Future<Either<NetworkFailure, T>> patch<T>({
//     required String url,
//     required Map<String, dynamic> body,
//     Map<String, String>? headers,
//   }) async {
//     try {
//       final response = await _dio.patch(
//         url,
//         data: body,
//         options: Options(headers: headers),
//       );

//       return right(response.data);
//     } on DioException catch (e) {
//       return left(_handleDioError(e));
//     } catch (e) {
//       return left(NetworkFailure(error: 'Unexpected error: $e'));
//     }
//   }

//   @override
//   Future<Either<NetworkFailure, T>> put<T>({
//     required String url,
//     Map<String, dynamic>? body,
//     Map<String, String>? headers,
//     bool isFormData = false,
//   }) async {
//     try {
//       dynamic data = body;

//       if (isFormData) {
//         data = await FormDataHelper.createFormData(data: body ?? {});
//       }

//       final response = await _dio.put(
//         url,
//         data: data,
//         options: Options(
//           headers: headers,
//           contentType: isFormData ? 'multipart/form-data' : 'application/json',
//         ),
//       );

//       return right(response.data);
//     } on DioException catch (e) {
//       return left(_handleDioError(e));
//     } catch (e) {
//       return left(NetworkFailure(error: 'Unexpected error: $e'));
//     }
//   }

//   @override
//   Future<Either<NetworkFailure, T>> delete<T>({
//     required String url,
//     Map<String, dynamic>? body,
//     Map<String, String>? headers,
//   }) async {
//     try {
//       final response = await _dio.delete(
//         url,
//         data: body,
//         options: Options(headers: headers),
//       );

//       return right(response.data);
//     } on DioException catch (e) {
//       return left(_handleDioError(e));
//     } catch (e) {
//       return left(NetworkFailure(error: 'Unexpected error: $e'));
//     }
//   }

//   // Pagination helper method
//   Future<Either<NetworkFailure, PaginatedResponse<T>>> getPaginated<T>({
//     required String url,
//     required int page,
//     required int limit,
//     Map<String, dynamic>? queryParams,
//     Map<String, String>? headers,
//     T Function(Map<String, dynamic>)? fromJson,
//   }) async {
//     try {
//       final params = PaginationHelper.createPaginationParams(
//         page: page,
//         limit: limit,
//         additionalParams: queryParams,
//       );

//       final response = await _dio.get(
//         url,
//         queryParameters: params,
//         options: Options(headers: headers),
//       );

//       if (fromJson != null) {
//         final paginatedResponse = PaginationHelper.parsePaginatedResponse<T>(
//           responseData: response.data,
//           fromJson: fromJson,
//         );
//         return right(paginatedResponse);
//       } else {
//         // Fallback for when fromJson is not provided
//         final data = response.data;
//         final items = data['data'] as List;
//         final pagination = data['pagination'] ?? {};

//         final paginatedResponse = PaginatedResponse<T>(
//           data: items.cast<T>(),
//           currentPage: pagination['currentPage'] ?? page,
//           totalPages: pagination['totalPages'] ?? 1,
//           totalItems: pagination['totalItems'] ?? items.length,
//           hasNextPage: pagination['hasNextPage'] ?? false,
//           hasPreviousPage: pagination['hasPreviousPage'] ?? false,
//         );

//         return right(paginatedResponse);
//       }
//     } on DioException catch (e) {
//       return left(_handleDioError(e));
//     } catch (e) {
//       return left(NetworkFailure(error: 'Unexpected error: $e'));
//     }
//   }

//   // File upload helper method
//   Future<Either<NetworkFailure, T>> uploadFile<T>({
//     required String url,
//     required File file,
//     String fieldName = 'file',
//     Map<String, dynamic>? additionalData,
//     Map<String, String>? headers,
//     ProgressCallback? onProgress,
//   }) async {
//     try {
//       final formData = await FormDataHelper.createFormData(
//         data: additionalData ?? {},
//         files: [file],
//         fileFieldName: fieldName,
//       );

//       final response = await _dio.post(
//         url,
//         data: formData,
//         options: Options(headers: headers, contentType: 'multipart/form-data'),
//         onSendProgress: onProgress,
//       );

//       return right(response.data);
//     } on DioException catch (e) {
//       return left(_handleDioError(e));
//     } catch (e) {
//       return left(NetworkFailure(error: 'Unexpected error: $e'));
//     }
//   }

//   // Multiple files upload helper method
//   Future<Either<NetworkFailure, T>> uploadMultipleFiles<T>({
//     required String url,
//     required List<File> files,
//     String fieldName = 'files',
//     Map<String, dynamic>? additionalData,
//     Map<String, String>? headers,
//     ProgressCallback? onProgress,
//   }) async {
//     try {
//       final formData = await FormDataHelper.createFormData(
//         data: additionalData ?? {},
//         files: files,
//         fileFieldName: fieldName,
//       );

//       final response = await _dio.post(
//         url,
//         data: formData,
//         options: Options(headers: headers, contentType: 'multipart/form-data'),
//         onSendProgress: onProgress,
//       );

//       return right(response.data);
//     } on DioException catch (e) {
//       return left(_handleDioError(e));
//     } catch (e) {
//       return left(NetworkFailure(error: 'Unexpected error: $e'));
//     }
//   }

//   // Download file helper method
//   Future<Either<NetworkFailure, File>> downloadFile({
//     required String url,
//     required String savePath,
//     Map<String, String>? headers,
//     ProgressCallback? onProgress,
//   }) async {
//     try {
//       final response = await _dio.download(
//         url,
//         savePath,
//         options: Options(headers: headers),
//         onReceiveProgress: onProgress,
//       );

//       if (response.statusCode == 200) {
//         return right(File(savePath));
//       } else {
//         return left(NetworkFailure(error: 'Download failed'));
//       }
//     } on DioException catch (e) {
//       return left(_handleDioError(e));
//     } catch (e) {
//       return left(NetworkFailure(error: 'Unexpected error: $e'));
//     }
//   }

//   // Stream download helper method
//   Future<Either<NetworkFailure, Stream<List<int>>>> downloadStream({
//     required String url,
//     Map<String, String>? headers,
//   }) async {
//     try {
//       final response = await _dio.get(
//         url,
//         options: Options(headers: headers, responseType: ResponseType.stream),
//       );

//       if (response.statusCode == 200) {
//         final stream = response.data.stream as Stream<List<int>>;
//         return right(stream);
//       } else {
//         return left(NetworkFailure(error: 'Download failed'));
//       }
//     } on DioException catch (e) {
//       return left(_handleDioError(e));
//     } catch (e) {
//       return left(NetworkFailure(error: 'Unexpected error: $e'));
//     }
//   }

//   // Cancel ongoing requests
//   void cancelRequests({String? tag}) {
//     if (tag != null) {
//       _dio.close(force: true);
//     } else {
//       _dio.close(force: true);
//     }
//   }

//   // Clear cache
//   void clearCache() {
//     final cacheInterceptor = _dio.interceptors
//         .whereType<CacheInterceptor>()
//         .firstOrNull;
//     cacheInterceptor?.clearCache();
//   }

//   NetworkFailure _handleDioError(DioException error) {
//     switch (error.type) {
//       case DioExceptionType.connectionTimeout:
//       case DioExceptionType.sendTimeout:
//       case DioExceptionType.receiveTimeout:
//         return NetworkFailure(
//           error: 'Connection timeout. Please check your internet connection.',
//         );

//       case DioExceptionType.badResponse:
//         final statusCode = error.response?.statusCode;
//         final responseData = error.response?.data;

//         if (statusCode == 401) {
//           return NetworkFailure(error: 'Unauthorized access');
//         } else if (statusCode == 403) {
//           return NetworkFailure(error: 'Access forbidden');
//         } else if (statusCode == 404) {
//           return NetworkFailure(error: 'Resource not found');
//         } else if (statusCode == 500) {
//           return NetworkFailure(error: 'Internal server error');
//         } else {
//           final message = responseData is Map
//               ? responseData['message'] ?? 'Unknown error'
//               : 'Request failed with status: $statusCode';
//           return NetworkFailure(error: message);
//         }

//       case DioExceptionType.cancel:
//         return NetworkFailure(error: 'Request was cancelled');

//       case DioExceptionType.unknown:
//         if (error.error is SocketException) {
//           return NetworkFailure(error: 'No internet connection');
//         }
//         return NetworkFailure(error: 'Unknown error occurred');

//       default:
//         return NetworkFailure(error: 'Network error occurred');
//     }
//   }
// }

// // Pagination response model
// class PaginatedResponse<T> {
//   final List<T> data;
//   final int currentPage;
//   final int totalPages;
//   final int totalItems;
//   final bool hasNextPage;
//   final bool hasPreviousPage;

//   PaginatedResponse({
//     required this.data,
//     required this.currentPage,
//     required this.totalPages,
//     required this.totalItems,
//     required this.hasNextPage,
//     required this.hasPreviousPage,
//   });
// }

// // Logging Interceptor
// class _LoggingInterceptor extends Interceptor {
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     log('🌐 REQUEST[${options.method}] => PATH: ${options.path}');
//     log('Headers: ${options.headers}');
//     if (options.data != null) {
//       log('Data: ${options.data}');
//     }
//     handler.next(options);
//   }

//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     log(
//       '✅ RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
//     );
//     log('Data: ${response.data}');
//     handler.next(response);
//   }

//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) {
//     log(
//       '❌ ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
//     );
//     log('Error: ${err.message}');
//     handler.next(err);
//   }
// }

// // Authentication Interceptor
// class _AuthInterceptor extends Interceptor {
//   final LoginDataSources _loginDataSources;
//   final LocalStorageRepository _localStorageRepository;

//   _AuthInterceptor(this._loginDataSources, this._localStorageRepository);

//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     final token = _loginDataSources.state.token;
//     if (token.isNotEmpty) {
//       options.headers['Authorization'] = 'Bearer $token';
//     }
//     handler.next(options);
//   }

//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) async {
//     if (err.response?.statusCode == 401) {
//       // Token expired, try to refresh
//       final refreshToken = _loginDataSources.state.refreshToken;
//       if (refreshToken.isNotEmpty) {
//         try {
//           final dio = Dio();
//           final refreshResponse = await dio.post(
//             AppUrl.refreshToken,
//             data: {'refreshToken': refreshToken},
//             options: Options(headers: {'Content-Type': 'application/json'}),
//           );

//           if (refreshResponse.statusCode == 200) {
//             final newTokens = LocalUserInfoStoreModel.fromJson(
//               refreshResponse.data,
//             );

//             await _localStorageRepository.setUserData(
//               localUserInfoStoreModel: newTokens,
//             );

//             _loginDataSources.setLoginDataSources(
//               localUserInfoStoreModel: newTokens,
//             );

//             // Retry the original request with new token
//             final newOptions = err.requestOptions;
//             newOptions.headers['Authorization'] = 'Bearer ${newTokens.token}';

//             final retryResponse = await dio.fetch(newOptions);
//             handler.resolve(retryResponse);
//             return;
//           }
//         } catch (e) {
//           log('Token refresh failed: $e');
//         }
//       }
//     }
//     handler.next(err);
//   }
// }

// // Error Interceptor
// class _ErrorInterceptor extends Interceptor {
//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) {
//     // Add any global error handling logic here
//     // For example, showing global error messages, logging to analytics, etc.

//     if (err.type == DioExceptionType.unknown && err.error is SocketException) {
//       // Handle no internet connection
//       log('No internet connection detected');
//     }

//     handler.next(err);
//   }
// }
