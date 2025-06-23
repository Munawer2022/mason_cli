import 'package:mason/mason.dart';

void run(HookContext context) {
  // UserDetails
  var stem = (context.vars["name"] as String? ?? "").trim().pascalCase;
  var pageName = "${stem}Page";
  final pageFileName = "${pageName.snakeCase}.dart";
  final modelFileName = "${stem.snakeCase}_model.dart";
  final dbFileName = "${stem.snakeCase}_db.dart";
  final folderName = "${stem.snakeCase}_sqlite";
  final datainsertscreen = "${stem.snakeCase}_data_insert_screen.dart";
  final datareadscreen = "${stem.snakeCase}_data_read_screen.dart";

  context.vars = {
    ...context.vars,
    "page_file_name": pageFileName,
    "class_name": stem,
    "model_file_name": modelFileName,
    "folder_name": folderName,
    "db_file_name": dbFileName,
    "data_insert_screen": datainsertscreen,
    "data_read_screen": datareadscreen,
  };
}
