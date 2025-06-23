import 'package:mason/mason.dart';

void run(HookContext context) {
  // UserDetails
  var stem = (context.vars["name"] as String? ?? "").trim().pascalCase;
  var pageName = "${stem}Page";
  final pdfFileName = "${stem.snakeCase}_pdf";
  final pageFileName = "${pageName.snakeCase}.dart";
  final pdfscreen = "${pageName.snakeCase}_pdf_screen.dart";
  final pdfdownloardscreen = "${pageName.snakeCase}_pdf_downloard_screen.dart";

  context.vars = {
    ...context.vars,
    "pdf_file_name": pdfFileName,
    "page_file_name": pageFileName,
    "class_name": stem,
    "pdf_screen": pdfscreen,
    "pdf_downloard_screen": pdfdownloardscreen,
  };
}
