import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:http/http.dart' as http;
import '/core/app_url.dart';
import '/data/models/local/local_user_info_store_model.dart';
import '/domain/failures/network/network_failure.dart';
import '/domain/repositories/local/local_storage_base_api_service.dart';
import '/data/datasources/auth/login_data_sources.dart';

class CustomInterceptor implements InterceptorContract {
  final LoginDataSources dataSources;
  final LocalStorageRepository localStorageRepository;

  CustomInterceptor(
      {required this.dataSources, required this.localStorageRepository});

  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async =>
      request;

  @override
  Future<BaseResponse> interceptResponse(
      {required BaseResponse response}) async {
    log('----- User Info -----');
    log('AccessToken: ${dataSources.state.token}');
    log('RefreshToken: ${dataSources.state.token}');

    log('----- Response -----');
    log('Code: ${response.statusCode}');
    if (response is Response) {
      log('Body: ${(response).body}');
    }
    if (response.statusCode == 401) {
      if (response is Response) {
        final Map<String, dynamic> responses = jsonDecode(response.body);
        NetworkFailure(error: responses['message']);
      }
      final refreshToken = dataSources.state.token;
      if (refreshToken.isNotEmpty) {
        final refreshResponse = await http.post(Uri.parse(AppUrl.refreshToken),
            body: jsonEncode({'refreshToken': refreshToken}),
            headers: {'Content-Type': 'application/json'});
        log('----- Response -----');
        log('Code: ${refreshResponse.statusCode}');
        log('Body: ${(refreshResponse).body}');

        if (refreshResponse.statusCode == 200) {
          final Map<String, dynamic> newTokensJson =
              jsonDecode(refreshResponse.body);
          log('----- Response -----');
          log('Code: $newTokensJson');

          final LocalUserInfoStoreModel localUserInfoStoreModel =
              LocalUserInfoStoreModel.fromJson(newTokensJson);

          await localStorageRepository
              .setUserData(localUserInfoStoreModel: localUserInfoStoreModel)
              .then((value) => value
                      .fold((l) => left(NetworkFailure(error: l.error)),
                          (tokenRight) {
                    dataSources.setLoginDataSources(
                        localUserInfoStoreModel: localUserInfoStoreModel);
                    return right(localUserInfoStoreModel);
                  }));

          // Retry the original request with the new token
          final newAccessToken = dataSources.state.token;
          if (newAccessToken.isNotEmpty) {
            final originalRequest = response.request;

            final newRequest =
                http.Request(originalRequest!.method, originalRequest.url);

            newRequest.headers.addAll(originalRequest.headers);
            newRequest.headers['Authorization'] = 'Bearer $newAccessToken';

            // Add the original request body if it was a POST/PUT request
            if (originalRequest is http.Request &&
                originalRequest.bodyBytes.isNotEmpty) {
              newRequest.bodyBytes = originalRequest.bodyBytes;
            }

            final retriedResponse =
                await http.Response.fromStream(await newRequest.send());
            return retriedResponse;
          }
        } else {
          NetworkFailure(error: 'Failed to refresh token');
        }
      }
    }
    return response;
  }

  @override
  FutureOr<bool> shouldInterceptRequest() {
    return true;
  }

  @override
  FutureOr<bool> shouldInterceptResponse() {
    return true;
  }
}
