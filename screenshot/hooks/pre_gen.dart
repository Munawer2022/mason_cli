import 'package:mason/mason.dart';

void run(HookContext context) {
  // UserDetails
  var stem = (context.vars["name"] as String? ?? "").trim().pascalCase;
  var pageName = "${stem}Page";
  final screenshotFileName = "${stem.snakeCase}_screenshot";

  final screenshotscreen = "${pageName.snakeCase}_screenshot_screen.dart";

  context.vars = {
    ...context.vars,
    "screenshot_file_name": screenshotFileName,
    "class_name": stem,
    "screenshot_screen": screenshotscreen,
  };
}
