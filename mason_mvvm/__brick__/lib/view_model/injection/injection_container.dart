import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import '/resource/navigation/app_navigator.dart';
import '/utils/show/show_error/show_errors.dart';
import '/view_model/internet_connectivity_checker_view_model.dart';
import '/data/network/http_network.dart';
import '/data/network/network_base_api_services.dart';
import '/view_model/theme/get_theme.dart';
import '/view_model/theme/theme_view_model.dart';
import '/view_model/theme/update_theme.dart';
{{#auth}}
import '/view_model/local/local_user_info_store_view_model.dart';
import '/view_model/local/insecure_local_storage.dart';
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
{{#isNoThing}}
/*
 ************************ {{class_name}} ************************
*/
import '/view_model/{{folder_name}}/{{folder_name}}_view_model.dart';
{{/isNoThing}}

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
{{#isGet}}
  getIt.registerSingleton<Connectivity>(Connectivity());
  getIt.registerSingleton<ShowError>(ShowError());

  getIt.registerSingleton<InternetConnectivityCheckerViewModel>(
      InternetConnectivityCheckerViewModel(getIt(), getIt()));
  getIt.registerSingleton<ThemeViewModel>(ThemeViewModel());
  getIt.registerSingleton<UpdateTheme>(UpdateTheme(getIt(), getIt()));
  getIt.registerSingleton<GetTheme>(GetTheme(getIt(), getIt()));
/*
************************ {{class_name}} ************************
*/
  getIt.registerSingleton<{{class_name}}BaseApiServices>({{class_name}}Repository(getIt()));
  getIt.registerSingleton<{{class_name}}ViewModel>(
      {{class_name}}ViewModel(getIt())
      );
{{/isGet}}
{{#isPost}}
/*
************************ {{class_name}} ************************
*/
  getIt.registerSingleton<{{class_name}}BaseApiServices>({{class_name}}Repository(getIt()));
  getIt.registerSingleton<{{class_name}}ViewModel>(
      {{class_name}}ViewModel(getIt())
      );
{{/isPost}}
{{#isNoThing}}
/*
************************ {{class_name}} ************************
*/
  getIt.registerSingleton<{{class_name}}ViewModel>(
      {{class_name}}ViewModel());
{{/isNoThing}}
{{#auth}}
/*
************************ Splash ************************
*/
  getIt.registerSingleton<SplashViewModel>(
      SplashViewModel(getIt(), getIt(), getIt(), getIt()
      {{#isGet}}
      , getIt()
      {{/isGet}}
      ));

/*
************************ Login ************************
*/
  getIt.registerSingleton<LoginBaseApiServices>(LoginRepository(getIt()));
  getIt.registerSingleton<LoginViewModel>(
      LoginViewModel(getIt(), getIt(), getIt(), getIt()
      {{#isGet}}
      , getIt()
      {{/isGet}}
      ));

/*
************************ SignUp ************************
*/
  getIt.registerSingleton<SignUpBaseApiServices>(SignUpRepository(getIt()));
  getIt.registerSingleton<SignUpViewModel>(
      SignUpViewModel(getIt(), getIt(), getIt(), getIt()
      {{#isGet}}
      , getIt()
      {{/isGet}}
      ));
/*
************************ ForgotPassword ************************
*/
  getIt.registerSingleton<ForgotPasswordBaseApiServices>(
      ForgotPasswordRepository(getIt()));
  getIt.registerSingleton<ForgotPasswordViewModel>(
      ForgotPasswordViewModel(getIt(), getIt(), getIt(), getIt()));
{{/auth}}
}
