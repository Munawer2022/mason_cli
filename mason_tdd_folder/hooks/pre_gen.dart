import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) {
  // Detect Flutter, Dart, and Java versions
  final flutterVersion = _getFlutterVersion();
  final dartVersion = _getDartVersion();
  final javaVersion = _getJavaVersion();

  final stateManagement = context.vars['stateManagement'];
  context.vars['isBloc'] = stateManagement == 'Bloc';
  context.vars['isFlutterBloc'] = stateManagement == 'flutter_bloc';
  context.vars['isNoThing'] = stateManagement == 'flutter_bloc';

  final http = context.vars['http'];
  context.vars['isGet'] = http == 'get';
  context.vars['isPost'] = http == 'post';
  context.vars['isNoThing'] = http == 'noThing';
  // UserDetails
  var originalName = (context.vars["name"] as String? ?? "").trim();
  var stem = originalName.pascalCase;
  var pageName = "${stem}Page";
  final pageFileName = "${pageName.snakeCase}.dart";
  final navigatorFileName = "${originalName.snakeCase}_navigator.dart";
  final cubitFileName = "${originalName.snakeCase}_cubit.dart";
  final stateFileName = "${originalName.snakeCase}_state.dart";
  final initialParamsFileName = "${originalName.snakeCase}_initial_params.dart";
  //
  final widgetFileName = "${originalName.snakeCase}_widget.dart";
  final mockRepoFileName = "Mock_${originalName.snakeCase}_repository.dart";
  final repoFileName = "${originalName.snakeCase}_repository.dart";
  final baseApiServiceFileName =
      "${originalName.snakeCase}_base_api_service.dart";
  final mockModelFileName = "mock_${originalName.snakeCase}_model.dart";
  final modelFileName = "${originalName.snakeCase}_model.dart";
  final folderName = "${originalName.snakeCase}";
  final folderNameCamelCase = "${originalName.camelCase}";
  final failureName = "${originalName.snakeCase}_failure.dart";
  final useCasesName = "${originalName.snakeCase}_use_cases.dart";
  final dataSourcesName = "${originalName.snakeCase}_data_sources.dart";

  context.vars = {
    ...context.vars,
    "flutter_version": flutterVersion,
    "dart_version": dartVersion,
    "java_version": javaVersion,
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
    "folder_name_camelCase": folderNameCamelCase,
    "folder_name": folderName,
    "failure_name": failureName,
    "use_cases_name": useCasesName,
    "data_sources_name": dataSourcesName,
  };
}

String _getFlutterVersion() {
  try {
    final result = Process.runSync('flutter', ['--version'], runInShell: true);
    if (result.exitCode == 0) {
      final output = result.stdout.toString();
      final lines = output.split('\n');
      for (final line in lines) {
        if (line.contains('Flutter')) {
          final match = RegExp(r'Flutter\s+(\d+\.\d+\.\d+)').firstMatch(line);
          if (match != null) {
            return match.group(1) ?? 'Unknown';
          }
        }
      }
    }
  } catch (e) {
    // Ignore errors
  }
  return 'Unknown';
}

String _getDartVersion() {
  try {
    final result = Process.runSync('dart', ['--version'], runInShell: true);
    if (result.exitCode == 0) {
      final output = result.stdout.toString();
      final match = RegExp(r'Dart\s+(\d+\.\d+\.\d+)').firstMatch(output);
      if (match != null) {
        return match.group(1) ?? 'Unknown';
      }
    }
  } catch (e) {
    // Ignore errors
  }
  return 'Unknown';
}

String _getJavaVersion() {
  try {
    final result = Process.runSync('java', ['-version'], runInShell: true);
    if (result.exitCode == 0) {
      final output = result.stderr.toString(); // Java version goes to stderr
      final match = RegExp(r'"(\d+\.\d+\.\d+[^"]*)"').firstMatch(output);
      if (match != null) {
        return match.group(1) ?? 'Unknown';
      }
    }
  } catch (e) {
    // Ignore errors
  }
  return 'Unknown';
}
