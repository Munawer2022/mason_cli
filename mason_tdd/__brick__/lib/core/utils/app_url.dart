abstract class AppUrl {
  static const _baseUrl = 'https://reqres.in';
  static var refreshToken = '$_baseUrl/refreshToken';
  {{#auth}}
  static var login = '$_baseUrl/login';
  static var signUp = '$_baseUrl/signUp';
  static var forgotPassword = '$_baseUrl/forgotPassword';
  {{/auth}}

  static var {{folder_name_camelCase}} = '$_baseUrl/{{folder_name_camelCase}}';
}
