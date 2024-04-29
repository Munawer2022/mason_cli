import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fpdart/fpdart.dart';

import '/domain/failure/network_failure.dart';
import 'package:http/http.dart' as http;

class NetworkRepository {
  Future<Either<NetworkFailure, dynamic>> get(String url) async {
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

  Future<Either<NetworkFailure, dynamic>> post(String url, dynamic data,
      {Map<String, String>? headers}) async {
    try {
      var uri = Uri.parse(url);
      var response = await http
          .post(uri, body: data, headers: headers)
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

  Future<Either<NetworkFailure, dynamic>> patch(String url, dynamic data,
      {Map<String, String>? headers}) async {
    try {
      var uri = Uri.parse(url);
      var response = await http
          .patch(uri,
              body: data,
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
        code.statusCode == 404 ||
        code.statusCode == 500) {
      return NetworkFailure(error: code.body);
    }
    return null;
  }
}
