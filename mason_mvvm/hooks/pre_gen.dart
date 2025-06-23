import 'package:mason/mason.dart';

void run(HookContext context) {
  final stateManagement = context.vars['stateManagement'];
  context.vars['isProvider'] = stateManagement == 'provider';
  context.vars['isFlutterBloc'] = stateManagement == 'flutter_bloc';
  context.vars['isBloc'] = stateManagement == 'Bloc';

  final http = context.vars['http'];
  context.vars['isGet'] = http == 'get';
  context.vars['isPost'] = http == 'post';
  context.vars['isNoThing'] = http == 'noThing';

  var stem = (context.vars["name"] as String? ?? "").trim().pascalCase;
  var pageName = "${stem}Page";
  final widgetFileName = "${stem.snakeCase}_widget.dart";
  final pageFileName = "${pageName.snakeCase}.dart";
  final cubitFileName = "${stem.snakeCase}_cubit.dart";
  final repoFileName = "${stem.snakeCase}_repository.dart";
  final baseApiServiceFileName = "${stem.snakeCase}_base_api_service.dart";
  final modelFileName = "${stem.snakeCase}_model.dart";
  final navigatorFileName = "${stem.snakeCase}_navigator.dart";
  final main = "main.dart";
  final folderName = "${stem.snakeCase}";
  final splashServices = "splash_services.dart";
  final splashscreen = "splash_view.dart";
  final tokenmodel = "token_model.dart";
  final tokenviewmodel = "token_view_model.dart";
  final button = "app_button.dart";
  final networkApiService = "NetworkApiService.dart";
  final apiResponse = "api_response.dart";
  final routes = "routes.dart";
  final utils = "utils.dart";
  final authRepository = "auth_repository.dart";
  final screenName = "${stem.snakeCase}_view.dart";
  final screenViewModel = "${stem.snakeCase}_view_model.dart";
  final loginview = "login_view.dart";
  final authViewModel = "auth_view_model.dart";
  final signupview = "signup_view.dart";
  final routesName = "routes_name.dart";
  final appNavigator = "app_navigator.dart";
  final textformfield = "app_text_form_field.dart";
  final appCheck = "platform_app_check.dart";
  final scaffoldCheck = "platform_scaffold_check.dart";
  final theme = "app_theme.dart";
  final loginViewModel = "login_view_model.dart";
  final signUpViewModel = "signup_view_model.dart";
  final loginRepository = "login_repository.dart";
  final signUpRepository = "signup_repository.dart";
  final forgotPasswordRepository = "forgot_password_repository.dart";
  final forgotPasswordViewModel = "forgot_password_view_model.dart";
  final forgotPasswordView = "forgot_password_view.dart";
  final stateFileName = "${stem.snakeCase}_state.dart";

  context.vars = {
    ...context.vars,
    "page_file_name": pageFileName,
    "class_name": stem,
    "navigator_file_name": navigatorFileName,
    "cubit_file_name": cubitFileName,
    "widget_file_name": widgetFileName,
    "repo_file_name": repoFileName,
    "base_api_service_file_name": baseApiServiceFileName,
    "model_file_name": modelFileName,
    "folder_name": folderName,
    "main": main,
    "splash_services": splashServices,
    "splash_screen": splashscreen,
    "token_model": tokenmodel,
    "token_view_model": tokenviewmodel,
    "button": button,
    "NetworkApiService": networkApiService,
    "api_response": apiResponse,
    "routes": routes,
    "utils": utils,
    "auth_repository": authRepository,
    "screen_name": screenName,
    "screen_view_model": screenViewModel,
    "login_view": loginview,
    "auth_view_view_model": authViewModel,
    "signup_view": signupview,
    "routes_name": routesName,
    "app_navigator": appNavigator,
    "text_form_field": textformfield,
    "app_check": appCheck,
    "scaffold_check": scaffoldCheck,
    "theme": theme,
    "login_view_model": loginViewModel,
    "signup_view_model": signUpViewModel,
    "login_repository": loginRepository,
    "signup_repository": signUpRepository,
    "forgot_password_repository": forgotPasswordRepository,
    "forgot_password_view_model": forgotPasswordViewModel,
    "forgot_password_view": forgotPasswordView,
    "state_file_name": stateFileName,
  };
}
