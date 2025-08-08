// import 'dart:developer';
// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:fpdart/fpdart.dart';

// import '/core/utils/app_url.dart';
// import '/data/datasources/auth/login_data_sources.dart';
// import '/data/models/local/local_user_info_store_model.dart';
// import '/domain/repositories/local/local_storage_base_api_service.dart';

// class DioConfig {
//   static Dio createDio({
//     required LoginDataSources loginDataSources,
//     required LocalStorageRepository localStorageRepository,
//     String? baseUrl,
//     Duration? connectTimeout,
//     Duration? receiveTimeout,
//     Duration? sendTimeout,
//   }) {
//     final dio = Dio();

//     // Base configuration
//     dio.options = BaseOptions(
//       baseUrl: baseUrl ?? AppUrl.baseUrl,
//       connectTimeout: connectTimeout ?? const Duration(seconds: 30),
//       receiveTimeout: receiveTimeout ?? const Duration(seconds: 30),
//       sendTimeout: sendTimeout ?? const Duration(seconds: 30),
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//       },
//     );

//     // Add interceptors
//     dio.interceptors.addAll([
//       LoggingInterceptor(),
//       AuthInterceptor(loginDataSources, localStorageRepository),
//       ErrorInterceptor(),
//       RetryInterceptor(),
//       CacheInterceptor(),
//     ]);

//     return dio;
//   }
// }

// // Enhanced Logging Interceptor
// class LoggingInterceptor extends Interceptor {
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     final timestamp = DateTime.now().toIso8601String();
//     log('🌐 [$timestamp] REQUEST[${options.method}] => ${options.uri}');
//     log('Headers: ${options.headers}');
//     if (options.data != null) {
//       log('Data: ${options.data}');
//     }
//     if (options.queryParameters.isNotEmpty) {
//       log('Query Parameters: ${options.queryParameters}');
//     }
//     handler.next(options);
//   }

//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     final timestamp = DateTime.now().toIso8601String();
//     log(
//       '✅ [$timestamp] RESPONSE[${response.statusCode}] => ${response.requestOptions.uri}',
//     );
//     log('Response Data: ${response.data}');
//     handler.next(response);
//   }

//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) {
//     final timestamp = DateTime.now().toIso8601String();
//     log(
//       '❌ [$timestamp] ERROR[${err.response?.statusCode}] => ${err.requestOptions.uri}',
//     );
//     log('Error Type: ${err.type}');
//     log('Error Message: ${err.message}');
//     if (err.response?.data != null) {
//       log('Error Data: ${err.response?.data}');
//     }
//     handler.next(err);
//   }
// }

// // Enhanced Authentication Interceptor
// class AuthInterceptor extends Interceptor {
//   final LoginDataSources _loginDataSources;
//   final LocalStorageRepository _localStorageRepository;

//   AuthInterceptor(this._loginDataSources, this._localStorageRepository);

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
//           // Clear tokens and redirect to login
//           await _localStorageRepository.clearUserData();
//         }
//       }
//     }
//     handler.next(err);
//   }
// }

// // Error Interceptor for global error handling
// class ErrorInterceptor extends Interceptor {
//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) {
//     // Add any global error handling logic here
//     // For example, showing global error messages, logging to analytics, etc.

//     if (err.type == DioExceptionType.unknown && err.error is SocketException) {
//       // Handle no internet connection
//       log('No internet connection detected');
//     }

//     // Log to analytics or crash reporting service
//     _logErrorToAnalytics(err);

//     handler.next(err);
//   }

//   void _logErrorToAnalytics(DioException error) {
//     // Implement analytics logging here
//     // Example: Firebase Analytics, Sentry, etc.
//     log('Analytics: Network error logged - ${error.type}');
//   }
// }

// // Retry Interceptor for automatic retries
// class RetryInterceptor extends Interceptor {
//   final int maxRetries;
//   final Duration retryDelay;

//   RetryInterceptor({
//     this.maxRetries = 3,
//     this.retryDelay = const Duration(seconds: 1),
//   });

//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) async {
//     if (_shouldRetry(err) && err.requestOptions.extra['retryCount'] == null) {
//       err.requestOptions.extra['retryCount'] = 0;
//     }

//     final retryCount = err.requestOptions.extra['retryCount'] ?? 0;

//     if (_shouldRetry(err) && retryCount < maxRetries) {
//       err.requestOptions.extra['retryCount'] = retryCount + 1;

//       log(
//         '🔄 Retrying request (${retryCount + 1}/$maxRetries): ${err.requestOptions.uri}',
//       );

//       await Future.delayed(retryDelay * (retryCount + 1));

//       try {
//         final dio = Dio();
//         final response = await dio.fetch(err.requestOptions);
//         handler.resolve(response);
//         return;
//       } catch (e) {
//         log('Retry failed: $e');
//       }
//     }

//     handler.next(err);
//   }

//   bool _shouldRetry(DioException error) {
//     return error.type == DioExceptionType.connectionTimeout ||
//         error.type == DioExceptionType.receiveTimeout ||
//         error.type == DioExceptionType.sendTimeout ||
//         (error.type == DioExceptionType.unknown &&
//             error.error is SocketException) ||
//         (error.response?.statusCode ?? 0) >= 500;
//   }
// }

// // Cache Interceptor for response caching
// class CacheInterceptor extends Interceptor {
//   final Map<String, _CacheEntry> _cache = {};
//   final Duration defaultCacheDuration;

//   CacheInterceptor({this.defaultCacheDuration = const Duration(minutes: 5)});

//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     if (options.method == 'GET' && _shouldCache(options)) {
//       final cacheKey = _generateCacheKey(options);
//       final cachedEntry = _cache[cacheKey];

//       if (cachedEntry != null && !cachedEntry.isExpired) {
//         log('📦 Serving cached response for: ${options.uri}');
//         handler.resolve(cachedEntry.response);
//         return;
//       }
//     }

//     handler.next(options);
//   }

//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     if (response.requestOptions.method == 'GET' &&
//         _shouldCache(response.requestOptions) &&
//         response.statusCode == 200) {
//       final cacheKey = _generateCacheKey(response.requestOptions);
//       _cache[cacheKey] = _CacheEntry(
//         response: response,
//         timestamp: DateTime.now(),
//         duration: defaultCacheDuration,
//       );
//       log('📦 Cached response for: ${response.requestOptions.uri}');
//     }

//     handler.next(response);
//   }

//   bool _shouldCache(RequestOptions options) {
//     // Add logic to determine which requests should be cached
//     // For example, cache user profile, settings, etc.
//     return options.path.contains('/profile') ||
//         options.path.contains('/settings') ||
//         options.path.contains('/config');
//   }

//   String _generateCacheKey(RequestOptions options) {
//     return '${options.method}_${options.path}_${options.queryParameters.hashCode}';
//   }

//   void clearCache() {
//     _cache.clear();
//     log('🗑️ Cache cleared');
//   }

//   void removeExpiredEntries() {
//     _cache.removeWhere((key, entry) => entry.isExpired);
//   }
// }

// class _CacheEntry {
//   final Response response;
//   final DateTime timestamp;
//   final Duration duration;

//   _CacheEntry({
//     required this.response,
//     required this.timestamp,
//     required this.duration,
//   });

//   bool get isExpired => DateTime.now().difference(timestamp) > duration;
// }

// // Form Data Helper
// class FormDataHelper {
//   static Future<FormData> createFormData({
//     required Map<String, dynamic> data,
//     List<File>? files,
//     String fileFieldName = 'files',
//   }) async {
//     final formData = FormData();

//     // Add regular fields
//     for (final entry in data.entries) {
//       if (entry.value != null) {
//         formData.fields.add(MapEntry(entry.key, entry.value.toString()));
//       }
//     }

//     // Add files
//     if (files != null) {
//       for (int i = 0; i < files.length; i++) {
//         final file = files[i];
//         if (await file.exists()) {
//           formData.files.add(
//             MapEntry(
//               '$fileFieldName[$i]',
//               await MultipartFile.fromFile(
//                 file.path,
//                 filename: file.path.split('/').last,
//               ),
//             ),
//           );
//         }
//       }
//     }

//     return formData;
//   }

//   static FormData createFormDataWithBytes({
//     required Map<String, dynamic> data,
//     Map<String, List<int>>? fileBytes,
//     Map<String, String>? fileNames,
//   }) {
//     final formData = FormData();

//     // Add regular fields
//     for (final entry in data.entries) {
//       if (entry.value != null) {
//         formData.fields.add(MapEntry(entry.key, entry.value.toString()));
//       }
//     }

//     // Add file bytes
//     if (fileBytes != null) {
//       for (final entry in fileBytes.entries) {
//         final fileName = fileNames?[entry.key] ?? '${entry.key}.bin';
//         formData.files.add(
//           MapEntry(
//             entry.key,
//             MultipartFile.fromBytes(entry.value, filename: fileName),
//           ),
//         );
//       }
//     }

//     return formData;
//   }
// }
