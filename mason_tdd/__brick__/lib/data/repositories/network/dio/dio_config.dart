import 'dart:developer';

import 'package:dio/dio.dart';

import '/data/datasources/auth/login_data_sources.dart';
import '/domain/repositories/local/local_storage_base_api_service.dart';

class DioConfig {
  static Dio createDio({
    required LoginDataSources loginDataSources,
    required LocalStorageRepository localStorageRepository,
    String? baseUrl,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    bool enableRetry = true,
  }) {
    final dio = Dio();

    // Base configuration
    dio.options = BaseOptions(
      baseUrl: baseUrl ?? '',
      connectTimeout: connectTimeout ?? const Duration(seconds: 30),
      receiveTimeout: receiveTimeout ?? const Duration(seconds: 30),
      sendTimeout: sendTimeout ?? const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      validateStatus: (status) => status != null && status < 500,
    );

    // Add interceptors in order
    dio.interceptors.addAll([
      AuthInterceptor(loginDataSources, localStorageRepository),
      if (enableRetry) RetryInterceptor(dio),
      LoggingInterceptor(),
    ]);

    return dio;
  }
}

// Enhanced Authentication Interceptor
class AuthInterceptor extends Interceptor {
  final LoginDataSources _loginDataSources;
  final LocalStorageRepository _localStorageRepository;

  AuthInterceptor(this._loginDataSources, this._localStorageRepository);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _loginDataSources.state.token;
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
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

// Retry Interceptor for failed requests
class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;
  final Duration retryDelay;

  RetryInterceptor(
    this.dio, {
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 1),
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (_shouldRetry(err) && err.requestOptions.extra['retryCount'] == null) {
      _retry(err.requestOptions, handler);
    } else {
      handler.next(err);
    }
  }

  bool _shouldRetry(DioException error) {
    return error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        (error.response?.statusCode != null &&
            error.response!.statusCode! >= 500);
  }

  void _retry(
    RequestOptions requestOptions,
    ErrorInterceptorHandler handler,
  ) async {
    final retryCount = (requestOptions.extra['retryCount'] as int?) ?? 0;

    if (retryCount >= maxRetries) {
      handler.next(
        DioException(
          requestOptions: requestOptions,
          error: 'Max retries exceeded',
          type: DioExceptionType.unknown,
        ),
      );
      return;
    }

    requestOptions.extra['retryCount'] = retryCount + 1;

    // Add exponential backoff
    await Future.delayed(
      Duration(milliseconds: retryDelay.inMilliseconds * (retryCount + 1)),
    );

    try {
      final response = await dio.fetch(requestOptions);
      handler.resolve(response);
    } on DioException catch (e) {
      if (retryCount + 1 >= maxRetries) {
        handler.next(e);
      } else {
        _retry(requestOptions, handler);
      }
    }
  }
}

// Enhanced Logging Interceptor
class LoggingInterceptor extends Interceptor {
  final bool logRequestBody;
  final bool logResponseBody;
  final int maxLogLength;

  LoggingInterceptor({
    this.logRequestBody = false,
    this.logResponseBody = false,
    this.maxLogLength = 1000,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final method = options.method.toUpperCase();
    final url = options.uri.toString();

    log('🌐 REQUEST[$method] => $url');

    if (logRequestBody && options.data != null) {
      final body = options.data.toString();
      final truncatedBody = body.length > maxLogLength
          ? '${body.substring(0, maxLogLength)}...'
          : body;
      log('📤 Request Body: $truncatedBody');
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final statusCode = response.statusCode;
    final url = response.requestOptions.uri.toString();

    log('✅ RESPONSE[$statusCode] => $url');

    if (logResponseBody && response.data != null) {
      final body = response.data.toString();
      final truncatedBody = body.length > maxLogLength
          ? '${body.substring(0, maxLogLength)}...'
          : body;
      log('📥 Response Body: $truncatedBody');
    }

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final method = err.requestOptions.method.toUpperCase();
    final url = err.requestOptions.uri.toString();
    final statusCode = err.response?.statusCode;

    log('❌ ERROR[$statusCode] $method => $url');
    log('💥 Error: ${err.message}');

    if (err.response?.data != null) {
      final errorBody = err.response!.data.toString();
      final truncatedError = errorBody.length > maxLogLength
          ? '${errorBody.substring(0, maxLogLength)}...'
          : errorBody;
      log('📥 Error Response: $truncatedError');
    }

    handler.next(err);
  }
}
