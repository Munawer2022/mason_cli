import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

import '/core/utils/app_url.dart';
import '/data/datasources/auth/login_data_sources.dart';
import '/data/models/local/local_user_info_store_model.dart';
import '/domain/repositories/local/local_storage_base_api_service.dart';

class DioConfig {
  static Dio createDio({
    required LoginDataSources loginDataSources,
    required LocalStorageRepository localStorageRepository,
  }) {
    final dio = Dio();

    // Base configuration
    dio.options = BaseOptions(
      // connectTimeout: const Duration(seconds: 30),
      // receiveTimeout: const Duration(seconds: 30),
      // sendTimeout: const Duration(seconds: 30),
      headers: {'Content-Type': 'application/json'},
      // validateStatus: (status) => status != null && status < 500,
    );

    // Add interceptors in order
    dio.interceptors.addAll([
      InterceptorsWrapper(loginDataSources, localStorageRepository),
      TalkerDioLogger(
        settings: TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printErrorHeaders: false,
          printErrorMessage: false,
        ),
      ),
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
    final token = _loginDataSources.state.accessToken;
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      try {
        final retriedResponse = await _handleUnauthorized(
          _loginDataSources,
          _localStorageRepository,
          err.requestOptions,
        );
        if (retriedResponse != null) {
          return handler.resolve(retriedResponse);
        }
      } catch (e) {
        log('Token refresh failed: $e');
        // Clear user data on refresh failure
        // _localStorageRepository.removeUserData();
      }
    }
    return handler.next(err);
  }
}

Future<Response<dynamic>?> _handleUnauthorized(
  LoginDataSources loginDataSources,
  LocalStorageRepository localStorageRepository,
  RequestOptions requestOptions,
) async {
  final refreshToken = loginDataSources.state.refreshToken;
  if (refreshToken.isEmpty) {
    log('No refresh token available');
    return null;
  }

  try {
    final refreshResponse = await Dio().post(
      AppUrl.refreshToken,
      data: {'refreshToken': refreshToken},
      options: Options(headers: {'Content-Type': 'application/json'}),
    );

    log('Refresh Token Response: ${refreshResponse.data}');

    if (refreshResponse.statusCode == 200) {
      final Map<String, dynamic> newTokensJson = refreshResponse.data;

      final LocalUserInfoStoreModel newUserData =
          LocalUserInfoStoreModel.fromJson(newTokensJson);

      // Update local storage
      await localStorageRepository
          .setUserData(localUserInfoStoreModel: newUserData)
          .then(
            (value) => value.fold(
              (l) => log('Failed to save user data: $l'),
              (r) => loginDataSources.setLoginDataSources(
                localUserInfoStoreModel: newUserData,
              ),
            ),
          );

      final newAccessToken = newUserData.accessToken;
      if (newAccessToken.isNotEmpty) {
        // Update the original request with new token
        requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

        // Retry the original request with the new token
        final dio = Dio();
        final retriedResponse = await dio.fetch(requestOptions);
        log('Retried Response: ${retriedResponse.data}');
        return retriedResponse;
      }
    } else {
      log('Failed to refresh token: ${refreshResponse.data}');
    }
  } catch (e) {
    log('Token refresh error: $e');
  }

  return null;
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
