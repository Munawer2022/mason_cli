import 'package:get_it/get_it.dart';
import '/domain/repositories/network/network_base_api_service.dart';
import 'data/repositories/network/https_network_repository.dart';
import 'config/navigation/app_navigator.dart';
import 'domain/repositories/local/local_storage_base_api_service.dart';
import 'data/repositories/local/insecure_local_storage_repository.dart';
import 'data/datasources/theme/theme_data_source.dart';
import 'domain/usecases/theme/get_theme_use_case.dart';
import 'domain/usecases/theme/update_theme_use_case.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'core/show/show/show.dart';
import '/data/datasources/internet_connectivity/internet_connectivity_checker_data_sources.dart';

{{#auth}}
/*
 ************************ Splash ************************
*/
import 'features/splash/splash_cubit.dart';
import 'features/splash/splash_initial_params.dart';
import 'features/splash/splash_navigator.dart';
/*
 ************************ login ************************
*/
import 'data/datasources/auth/login_data_sources.dart';
import 'domain/usecases/auth/login/login_use_cases.dart';
import 'features/auth/login/login_navigator.dart';
import 'features/auth/login/login_cubit.dart';
import 'features/auth/login/login_initial_params.dart';
import '/domain/usecases/local/check_for_existing_user_use_case.dart';

{{/auth}}
/*
************************ {{class_name}} ************************
*/
import 'features/{{folder_name}}/{{navigator_file_name}}';
import 'features/{{folder_name}}/{{cubit_file_name}}';
import 'features/{{folder_name}}/{{initial_params_file_name}}';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerSingleton<AppNavigator>(AppNavigator());
  {{#auth}}
  getIt.registerSingleton<LoginDataSources>(LoginDataSources());
  {{/auth}}
    getIt.registerSingleton<LocalStorageRepository>(
      InsecureLocalStorageRepository());
  getIt.registerSingleton<NetworkBaseApiService>(HttpsNetworkRepository(
    {{#auth}}
    getIt(),
    getIt()
    {{/auth}}
    ));
/*
************************ Theme ************************
*/

  getIt.registerSingleton<ThemeDataSources>(ThemeDataSources());
  getIt.registerSingleton<GetThemeUseCase>(
    GetThemeUseCase( getIt(), getIt()));
  getIt.registerSingleton<UpdateThemeUseCase>(
    UpdateThemeUseCase(getIt(), getIt()));
 getIt.registerSingleton<Connectivity>(Connectivity());
  getIt.registerSingleton<Show>(Show());

  getIt.registerSingleton<InternetConnectivityCheckerDataSources>(
      InternetConnectivityCheckerDataSources(getIt(), getIt()));
 {{#auth}}
/*
************************ Splash ************************
*/
  getIt.registerSingleton<SplashNavigator>(SplashNavigator(getIt()));
  getIt.registerFactoryParam<SplashCubit, SplashInitialParams, dynamic>(
      (params, _) => SplashCubit(params, getIt(), getIt(), getIt()));
/*
************************ login ************************
*/
  getIt.registerSingleton<CheckForExistingUserUseCase>(
      CheckForExistingUserUseCase(getIt(), getIt()));
  getIt.registerSingleton<LoginUseCases>(
      LoginUseCases(getIt(), getIt(), getIt()));
  getIt.registerSingleton<LoginNavigator>(LoginNavigator(getIt()));
  getIt.registerFactoryParam<LoginCubit, LoginInitialParams, dynamic>(
      (params, _) => LoginCubit(params, getIt(), getIt(), getIt()));
      {{/auth}}
/*
************************ {{class_name}} ************************
*/
  getIt.registerSingleton<{{class_name}}Navigator>({{class_name}}Navigator(getIt()));
  getIt.registerFactoryParam<{{class_name}}Cubit, {{class_name}}InitialParams, dynamic>(
      (params, _) => {{class_name}}Cubit(params, getIt()
      {{#isGet}}
       , getIt()
      {{/isGet}}
      {{#isPost}}
       , getIt()
       , getIt()
      {{/isPost}}
      )
      {{#isGet}}
      ..{{folder_name_camelCase}}()
      {{/isGet}}
      );
}
