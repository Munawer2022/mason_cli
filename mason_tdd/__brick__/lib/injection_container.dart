import 'package:get_it/get_it.dart';
import 'config/network/network_repository.dart';
import 'config/navigation/app_navigator.dart';
{{#auth}}
/*
 ************************ login ************************
*/
import 'domain/repositories/auth/login/login_base_api_service.dart';
import 'data/repositories/auth/login/login_repository.dart';
import 'data/repositories/{{folder_name}}/Mock_{{repo_file_name}}';
import 'features/auth/login/login_navigator.dart';
import 'features/auth/login/login_cubit.dart';
import 'features/auth/login/login_initial_params.dart';
{{/auth}}
/*
************************ {{folder_name}} ************************
*/
import 'domain/repositories/{{folder_name}}/{{base_api_service_file_name}}';
import 'data/repositories/{{folder_name}}/{{repo_file_name}}';
import 'features/{{folder_name}}/{{navigator_file_name}}';
import 'features/{{folder_name}}/{{cubit_file_name}}';
import 'features/{{folder_name}}/{{initial_params_file_name}}';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerSingleton<NetworkRepository>(NetworkRepository());
  getIt.registerSingleton<AppNavigator>(AppNavigator());
/*
  ************************  ************************
*/
   {{#auth}}
/*
************************ login ************************
*/
  getIt.registerSingleton<LoginBaseApiService>(LoginRepository(getIt()));
  // getIt.registerSingleton<LoginBaseApiService>(MockLoginRepository());
  getIt.registerSingleton<LoginNavigator>(LoginNavigator(getIt()));
  getIt.registerFactoryParam<LoginCubit, LoginInitialParams, dynamic>(
      (params, _) => LoginCubit(params, getIt(), getIt()));
      {{/auth}}
/*
************************ {{folder_name}} ************************
*/
  getIt.registerSingleton<{{class_name}}BaseApiService>({{class_name}}Repository(getIt()));
  // getIt.registerSingleton<{{class_name}}BaseApiService>(Mock{{class_name}}Repository());
  getIt.registerSingleton<{{class_name}}Navigator>({{class_name}}Navigator(getIt()));
  getIt.registerFactoryParam<{{class_name}}Cubit, {{class_name}}InitialParams, dynamic>(
      (params, _) => {{class_name}}Cubit(params, getIt(), getIt())
      {{#isGet}}
      ..{{folder_name}}()
      {{/isGet}}
      );
}
