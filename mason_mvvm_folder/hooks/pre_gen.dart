import 'package:mason/mason.dart';

void run(HookContext context) {
  var stem = (context.vars["name"] as String? ?? "").trim().pascalCase;
  var pageName = "${stem}Page";
  final widgetFileName = "${stem.snakeCase}_widget.dart";
  final pageFileName = "${pageName.snakeCase}.dart";
  final repoFileName = "${stem.snakeCase}_repository.dart";
  final modelFileName = "${stem.snakeCase}_model.dart";
  final folderName = "${stem.snakeCase}";
  final screenName = "${stem.snakeCase}_view.dart";
  final screenViewModel = "${stem.snakeCase}_view_model.dart";
  context.vars = {
    ...context.vars,
    "page_file_name": pageFileName,
    "class_name": stem,
    "widget_file_name": widgetFileName,
    "repo_file_name": repoFileName,
    "model_file_name": modelFileName,
    "folder_name": folderName,
    "screen_name": screenName,
    "screen_view_model": screenViewModel,
  };
}
