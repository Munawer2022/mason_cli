import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fpdart/fpdart.dart';

import '/domain/failure/network_failure.dart';
import 'package:http/http.dart' as http;

class NetworkRepository {
  Future<Either<NetworkFailure, dynamic>> get({required String url}) async {
    try {
      var uri = Uri.parse(url);
      var response = await http.get(uri, headers: {
        // 'Authorization': 'Bearer $token'
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

  Future<Either<NetworkFailure, dynamic>> post(
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

  Future<Either<NetworkFailure, dynamic>> patch(
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
      return NetworkFailure(error: response['message']);
    }
    return null;
  }
}
