import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

import '/data/datasources/auth/login_data_sources.dart';
import '/domain/repositories/local/local_storage_base_api_service.dart';

class DioConfig {
  static Dio createDio({
    required LoginDataSources loginDataSources,
    required LocalStorageRepository localStorageRepository,
  }) {
    final dio = Dio();

    // Base configuration
    dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${loginDataSources.state.token}',
      },
      validateStatus: (status) => status != null && status < 500,
    );

    // Add interceptors in order
    dio.interceptors.addAll([
      TalkerDioLogger(
        settings: TalkerDioLoggerSettings(printRequestHeaders: true),
      ),
      InterceptorsWrapper(loginDataSources, localStorageRepository),
      // LoggingInterceptor(),
    ]);

    return dio;
  }
}

// Enhanced Authentication Interceptor
class InterceptorsWrapper extends Interceptor {
  final LoginDataSources _loginDataSources;
  final LocalStorageRepository _localStorageRepository;

  InterceptorsWrapper(this._loginDataSources, this._localStorageRepository);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _loginDataSources.state.token;
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // Token might be expired, clear it
      _loginDataSources.close();
      _localStorageRepository.removeUserData();
    }
    handler.next(err);
  }
}

// // Logging Interceptor (for debugging)
// class LoggingInterceptor extends Interceptor {
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     AppPrint.success('🌐 REQUEST[${options.method}] => PATH: ${options.uri}');
//     AppPrint.info('📤 Headers: ${options.headers}');
//     if (options.data != null) {
//       AppPrint.success('📦 Body: ${options.data}');
//     }
//     handler.next(options);
//   }

//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     AppPrint.success(
//       '✅ RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.uri}',
//     );
//     AppPrint.json('📥 Data: ${response.data}');
//     handler.next(response);
//   }

//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) {
//     AppPrint.error(
//       '❌ ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.uri}',
//     );
//     AppPrint.error('💥 Message: ${err.message}');
//     if (err.response != null) {
//       AppPrint.error('📛 Response: ${err.response?.data}');
//     }
//     handler.next(err);
//   }
