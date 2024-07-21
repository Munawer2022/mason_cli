import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fpdart/fpdart.dart';

import '/domain/failures/network/network_failure.dart';
import 'package:http/http.dart' as http;
{{#auth}}
import '/data/datasources/auth/login_data_sources.dart';
{{/auth}}
import '/domain/repositories/network/network_base_api_service.dart';

class HttpsNetworkRepository implements NetworkBaseApiService{
  {{#auth}}
  final LoginDataSources _loginDataSources;
  HttpsNetworkRepository(this._loginDataSources);
  {{/auth}}
  @override
  Future<Either<NetworkFailure, T>> get<T>({required String url}) async {
    try {
      var uri = Uri.parse(url);
      var response = await http.get(uri, headers: {
        // 'Authorization': 'Bearer $token'
        {{#auth}}
        {{#isBloc}}
        'Authorization': 'Bearer ${_loginDataSources.state.mockLoginSuccessModel.token}'
        {{/isBloc}}
        {{#isFlutterBloc}}
        'Authorization': 'Bearer ${_loginDataSources.state.token}'
        {{/isFlutterBloc}}
        {{#isProvider}}
        'Authorization': 'Bearer ${_loginDataSources.mockLoginSuccessModel.token}'
        {{/isProvider}}
        {{/auth}}
      }).timeout(const Duration(seconds: 10));
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
      var response = await http
          .post(uri, body: body, headers: headers)
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
      var response = await http
          .patch(uri,
              body: body,
              headers: headers ??
                  {
                    // 'Authorization': 'Bearer $token'
                   {{#auth}}
        {{#isBloc}}
        'Authorization': 'Bearer ${_loginDataSources.state.mockLoginSuccessModel.token}'
        {{/isBloc}}
        {{#isFlutterBloc}}
        'Authorization': 'Bearer ${_loginDataSources.state.token}'
        {{/isFlutterBloc}}
        {{#isProvider}}
        'Authorization': 'Bearer ${_loginDataSources.mockLoginSuccessModel.token}'
        {{/isProvider}}
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
      return NetworkFailure(error: response['message'] ?? "Error");
    }
    return null;
  }
}
