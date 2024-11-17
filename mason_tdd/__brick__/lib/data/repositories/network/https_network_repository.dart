import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
{{#auth}}
import 'package:http_interceptor/http_interceptor.dart';
import '/domain/repositories/local/local_storage_base_api_service.dart';

import '/data/datasources/auth/login_data_sources.dart';
import '/domain/failures/network/network_failure.dart';
import 'interceptor.dart';
{{/auth}}
import '/domain/repositories/network/network_base_api_service.dart';

class HttpsNetworkRepository implements NetworkBaseApiService {
  {{#auth}}
  final LoginDataSources _loginDataSources;
  final LocalStorageRepository localStorageRepository;
  late Client _client;

  HttpsNetworkRepository(this._loginDataSources, this.localStorageRepository) {
    _client = InterceptedClient.build(interceptors: [
      CustomInterceptor(
          dataSources: _loginDataSources,
          localStorageRepository: localStorageRepository)
    ]);
  }
  {{/auth}}

  @override
  Future<Either<NetworkFailure, T>> get<T>(
      {required String url, Map<String, dynamic>? queryParams}) async {
    try {
      var uri = Uri.parse(url).replace(queryParameters: queryParams);

      var response = await _client.get(uri, headers: {
        {{#auth}}
        'Authorization': 'Bearer ${_loginDataSources.state.token}'
        {{/auth}}
      })
          .timeout(const Duration(seconds: 10))
          ;

      final failure = _handleStatusCode(response);
      if (failure != null) {
        return left(failure);
      }

      return right(jsonDecode(response.body));
    } on TimeoutException {
      return left(NetworkFailure(
          error: 'Please check your internet connection and try again.'));
    } on SocketException {
      return left(NetworkFailure(error: 'No Internet Connection'));
    }
  }

  @override
  Future<Either<NetworkFailure, T>> post<T>(
      {required String url,
      required Map<String, dynamic> body,
      Map<String, String>? headers}) async {
    try {
      var uri = Uri.parse(url);

      var response = await _client
          .post(uri,
              body: jsonEncode(body),
              headers: headers ??
                  <String, String>{'Content-Type': 'application/json'})
          .timeout(const Duration(seconds: 10));

      final failure = _handleStatusCode(response);
      if (failure != null) {
        return left(failure);
      }
      return right(jsonDecode(response.body));
    } on TimeoutException {
      return left(NetworkFailure(
          error: 'Please check your internet connection and try again.'));
    } on SocketException {
      return left(NetworkFailure(error: 'No Internet Connection'));
    }
  }

  @override
  Future<Either<NetworkFailure, T>> patch<T>(
      {required String url,
      required Map<String, dynamic> body,
      Map<String, String>? headers}) async {
    try {
      var uri = Uri.parse(url);

      var response = await _client
          .patch(uri,
              body: jsonEncode(body),
              headers: headers ??
                  {
                    {{#auth}}
                    'Authorization': 'Bearer ${_loginDataSources.state.token}'
                    {{/auth}}
                    })
          .timeout(const Duration(seconds: 10));
      final failure = _handleStatusCode(response);
      if (failure != null) {
        return left(failure);
      }
      return right(jsonDecode(response.body));
    } on TimeoutException {
      return left(NetworkFailure(
          error: 'Please check your internet connection and try again.'));
    } on SocketException {
      return left(NetworkFailure(error: 'No Internet Connection'));
    }
  }

  @override
  Future<Either<NetworkFailure, T>> put<T>(
      {required String url,
      Map<String, dynamic>? body,
      Map<String, String>? headers,
      bool isFormData = false}) async {
    try {
      var uri = Uri.parse(url);
      http.Response response;

      if (isFormData) {
        var request = http.MultipartRequest('PUT', uri);

        request.headers.addAll(headers ??
            {
              {{#auth}}
              'Authorization': 'Bearer ${_loginDataSources.state.token}',
              {{/auth}}
              'Content-Type': 'multipart/form-data'
            });

        body?.forEach((key, value) {
          if (value is List<int>) {
            request.files.add(http.MultipartFile.fromBytes(key, value));
          } else {
            if (value is Map) {
              request.fields[key] = jsonEncode(value);
            } else {
              request.fields[key] = value.toString();
            }
          }
        });

        var streamedResponse = await request.send();
        response = await http.Response.fromStream(streamedResponse);
      } else {
        response = await _client
            .put(uri,
                body: jsonEncode(body),
                headers: headers ??
                    {
                      {{#auth}}
                      'Authorization':
                          'Bearer ${_loginDataSources.state.token}',
                      {{/auth}}
                      'Content-Type': 'application/json'
                    })
            .timeout(const Duration(seconds: 10));
      }

      final failure = _handleStatusCode(response);
      if (failure != null) {
        return left(failure);
      }

      return right(jsonDecode(response.body));
    } on TimeoutException {
      return left(NetworkFailure(
          error: 'Please check your internet connection and try again.'));
    } on SocketException {
      return left(NetworkFailure(error: 'No Internet Connection'));
    } catch (e) {
      return left(NetworkFailure(error: 'Unexpected Error: $e'));
    }
  }

  @override
  Future<Either<NetworkFailure, T>> delete<T>(
      {required String url,
      Map<String, dynamic>? body,
      Map<String, String>? headers}) async {
    try {
      var uri = Uri.parse(url);

      var response = await _client
          .delete(uri,
              body: jsonEncode(body),
              headers: headers ??
                  {
                    {{#auth}}
                    'Authorization': 'Bearer ${_loginDataSources.state.token}'
                    {{/auth}}
                    })
          .timeout(const Duration(seconds: 10));

      final failure = _handleStatusCode(response);
      if (failure != null) {
        return left(failure);
      }
      return right(jsonDecode(response.body));
    } on TimeoutException {
      return left(NetworkFailure(
          error: 'Please check your internet connection and try again.'));
    } on SocketException {
      return left(NetworkFailure(error: 'No Internet Connection'));
    }
  }

  NetworkFailure? _handleStatusCode(http.Response code) {
    if (code.statusCode == 400 ||
        code.statusCode == 401 ||
        code.statusCode == 403 ||
        code.statusCode == 404 ||
        code.statusCode == 500) {
      final Map<String, dynamic> response = jsonDecode(code.body);
      return NetworkFailure(
          error: response['message'] ?? "Unknown error occurred");
    }
    return null;
  }
}
