import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class AppUrl {
  static final _base = dotenv.env['BASE_URL'];
  // static const _base = 'http://192.168.18.68:3001';
  // static const _base = 'http://192.168.100.31:3001';
  static final socketBaseUrl = _base;
  static final _baseUrl = '$_base/api/v1';

  static var refreshToken = '$_baseUrl/refreshToken';
  static var login = '$_baseUrl/login';
  static var signUp = '$_baseUrl/signUp';
  static var forgotPassword = '$_baseUrl/forgotPassword';

  static var {{folder_name_camelCase}} = '$_baseUrl/{{folder_name_camelCase}}';

  // static String endpoint(String userId) => '$_baseUrl/$path';
}
