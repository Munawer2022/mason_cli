import 'package:mason/mason.dart';

void run(HookContext context) {
  final stateManagement = context.vars['stateManagement'];
  context.vars['isBloc'] = stateManagement == 'Bloc';
  context.vars['isFlutterBloc'] = stateManagement == 'flutter_bloc';

  final http = context.vars['http'];
  context.vars['isGet'] = http == 'get';
  context.vars['isPost'] = http == 'post';
  // UserDetails
  var stem = (context.vars["name"] as String? ?? "").trim().pascalCase;
  var pageName = "${stem}Page";
  final pageFileName = "${pageName.snakeCase}.dart";
  final navigatorFileName = "${stem.snakeCase}_navigator.dart";
  final cubitFileName = "${stem.snakeCase}_cubit.dart";
  final stateFileName = "${stem.snakeCase}_state.dart";
  final initialParamsFileName = "${stem.snakeCase}_initial_params.dart";
  //
  final widgetFileName = "${stem.snakeCase}_widget.dart";
  final mockRepoFileName = "Mock_${stem.snakeCase}_repository.dart";
  final repoFileName = "${stem.snakeCase}_repository.dart";
  final baseApiServiceFileName = "${stem.snakeCase}_base_api_service.dart";
  final mockModelFileName = "mock_${stem.snakeCase}_model.dart";
  final modelFileName = "${stem.snakeCase}_model.dart";
  final folderName = "${stem.snakeCase}";
  final failureName = "${stem.snakeCase}_failure.dart";
  final useCasesName = "${stem.snakeCase}_use_cases.dart";
  final dataSourcesName = "${stem.snakeCase}_data_sources.dart";

  context.vars = {
    ...context.vars,
    "page_file_name": pageFileName,
    "class_name": stem,
    "navigator_file_name": navigatorFileName,
    "initial_params_file_name": initialParamsFileName,
    "state_file_name": stateFileName,
    "cubit_file_name": cubitFileName,
    "widget_file_name": widgetFileName,
    "mock_repo_file_name": mockRepoFileName,
    "repo_file_name": repoFileName,
    "base_api_service_file_name": baseApiServiceFileName,
    "mock_model_file_name": mockModelFileName,
    "model_file_name": modelFileName,
    "folder_name": folderName,
    "failure_name": failureName,
    "use_cases_name": useCasesName,
    "data_sources_name": dataSourcesName,
  };
}
