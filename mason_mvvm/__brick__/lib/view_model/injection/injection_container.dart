import 'package:get_it/get_it.dart';
import '/resource/app_navigator.dart';
import '/data/network/http_network.dart';
import '/data/network/network_base_api_services.dart';
{{#auth}}
import '/view_model/local/local_user_info_store_view_model.dart';
import '../{{#auth}}local{{/auth}}/insecure_local_storage.dart';
/*
 ************************ Splash ************************
*/
import '/view_model/splash/splash_view_model.dart';
/*
 ************************ Auth ************************
*/
import '/repository/auth/forgot_password/forgot_password_base_api_service.dart';
import '/repository/auth/login/login_base_api_service.dart';
import '/repository/auth/sign_up/sign_up_base_api_service.dart';
import '/repository/auth/sign_up/sign_up_repository.dart';
import '/view_model/auth/login/login_view_model.dart';
import '/view_model/auth/sign_up/sign_up_view_model.dart';
import '/repository/auth/forgot_password/forgot_password_repository.dart';
import '/repository/auth/login/login_repository.dart';
import '/view_model/auth/forgot_password/forgot_password_view_model.dart';
{{/auth}}
{{#isGet}}
/*
 ************************ {{class_name}} ************************
*/
import '/repository/{{folder_name}}/{{folder_name}}_base_api_service.dart';
import '/repository/{{folder_name}}/{{folder_name}}_repository.dart';
import '/view_model/{{folder_name}}/{{folder_name}}_view_model.dart';
{{/isGet}}
{{#isPost}}
/*
 ************************ {{class_name}} ************************
*/
import '/repository/{{folder_name}}/{{folder_name}}_base_api_service.dart';
import '/repository/{{folder_name}}/{{folder_name}}_repository.dart';
import '/view_model/{{folder_name}}/{{folder_name}}_view_model.dart';
{{/isPost}}

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerSingleton<AppNavigator>(AppNavigator());
  {{#auth}}
  getIt.registerSingleton<InsecureLocalStorage>(InsecureLocalStorage());
  getIt.registerSingleton<LocalUserInfoStoreViewModel>(
      LocalUserInfoStoreViewModel());
  {{/auth}}
  getIt.registerSingleton<NetworkBaseApiServices>(HttpNetwork(
    {{#auth}}
    getIt()
    {{/auth}}
    ));
{{#auth}}
/*
************************ Splash ************************
*/
  getIt.registerSingleton<SplashViewModel>(
      SplashViewModel(getIt(), getIt(), getIt()));

/*
************************ Login ************************
*/
  getIt.registerSingleton<LoginBaseApiServices>(LoginRepository(getIt()));
  getIt.registerSingleton<LoginViewModel>(
      LoginViewModel(getIt(), getIt(), getIt(), getIt()));

/*
************************ SignUp ************************
*/
  getIt.registerSingleton<SignUpBaseApiServices>(SignUpRepository(getIt()));
  getIt.registerSingleton<SignUpViewModel>(
      SignUpViewModel(getIt(), getIt(), getIt(), getIt()));
/*
************************ ForgotPassword ************************
*/
  getIt.registerSingleton<ForgotPasswordBaseApiServices>(
      ForgotPasswordRepository(getIt()));
  getIt.registerSingleton<ForgotPasswordViewModel>(
      ForgotPasswordViewModel(getIt(), getIt(), getIt(), getIt()));
{{/auth}}
{{#isGet}}
/*
************************ Test ************************
*/
  getIt.registerSingleton<{{class_name}}BaseApiServices>({{class_name}}Repository(getIt()));
  getIt.registerSingleton<{{class_name}}ViewModel>(
      {{class_name}}ViewModel(getIt())
      {{#isGet}}
      ..{{folder_name}}()
      {{/isGet}}
      );
{{/isGet}}
{{#isPost}}
/*
************************ Test ************************
*/
  getIt.registerSingleton<{{class_name}}BaseApiServices>({{class_name}}Repository(getIt()));
  getIt.registerSingleton<{{class_name}}ViewModel>(
      {{class_name}}ViewModel(getIt())
      {{#isGet}}
      ..{{folder_name}}()
      {{/isGet}}
      );
{{/isPost}}
}
