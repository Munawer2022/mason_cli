import 'package:get_it/get_it.dart';
import 'config/network/network_repository.dart';
import 'data/repositories/{{folder_name}}/{{repo_file_name}}';
import 'domain/repositories/{{folder_name}}/{{base_api_service_file_name}}';
import 'features/{{folder_name}}/{{cubit_file_name}}';
import 'features/{{folder_name}}/{{navigator_file_name}}';
import 'features/{{folder_name}}/{{initial_params_file_name}}';
import 'config/navigation/app_navigator.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerSingleton<NetworkRepository>(NetworkRepository());
  getIt.registerSingleton<{{class_name}}BaseApiService>({{class_name}}Repository(getIt()));
  getIt.registerSingleton<AppNavigator>(AppNavigator());
  getIt.registerSingleton<{{class_name}}Navigator>({{class_name}}Navigator(getIt()));
  getIt.registerFactoryParam<{{class_name}}Cubit, {{class_name}}InitialParams, dynamic>(
      (params, _) => {{class_name}}Cubit(params, getIt(), getIt())..fetch{{class_name}}());
}
