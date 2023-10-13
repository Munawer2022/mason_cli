import 'package:mason/mason.dart';

void run(HookContext context) {
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
  final splashscreen = "splash_screen.dart";
  final tokenmodel = "token_model.dart";
  final elevatedButton = "elevated_button.dart";
  final networkApiService = "NetworkApiService.dart";
  final apiResponse = "api_response.dart";
  final routes = "routes.dart";
  final utils = "utils.dart";

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
    "elevated_button": elevatedButton,
    "NetworkApiService": networkApiService,
    "api_response": apiResponse,
    "routes": routes,
      "utils": utils,
  };
}
