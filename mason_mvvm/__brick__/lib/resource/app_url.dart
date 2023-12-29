class AppUrl {
  static var baseUrl = 'https://reqres.in';
{{#auth}}
  static var login = '$baseUrl/login';
  static var signUp = '$baseUrl/signUp';
  static var forgotPassword = '$baseUrl/forgotPassword';
  {{/auth}}
  static var {{folder_name}} = '$baseUrl/{{folder_name}}';
}
