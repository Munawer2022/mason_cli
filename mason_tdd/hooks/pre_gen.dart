import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) {
  // Detect Flutter, Dart, and Java versions
  final flutterVersion = _getFlutterVersion();
  final dartVersion = _getDartVersion();
  final javaVersion = _getJavaVersion();

  final dio = context.vars['dio'];
  context.vars['isGet'] = dio == 'get';
  context.vars['isPost'] = dio == 'post';
  context.vars['isNone'] = dio == 'none';

  // UserDetails
  var stem = (context.vars["name"] as String? ?? "").trim().pascalCase;
  var pageName = "${stem}Page";
  final pageFileName = "${pageName.snakeCase}.dart";
  final navigatorFileName = "${stem.snakeCase}_navigator.dart";
  final cubitFileName = "${stem.snakeCase}_cubit.dart";
  final stateFileName = "${stem.snakeCase}_state.dart";
  final initialParamsFileName = "${stem.snakeCase}_initial_params.dart";
  final modelFileName = "${stem.snakeCase}_model.dart";
  final folderName = "${stem.snakeCase}";
  final folderNameCamelCase = "${stem.camelCase}";
  final main = "main.dart";

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
    "model_file_name": modelFileName,
    "folder_name": folderName,
    "folder_name_camelCase": folderNameCamelCase,
    "main": main,
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
      // Older Dart SDKs print the version to stderr, newer ones to stdout.
      final output = '${result.stdout}${result.stderr}';
      final match =
          RegExp(r'Dart(?:\s+SDK)?(?:\s+version:?)?\s+(\d+\.\d+\.\d+)')
              .firstMatch(output);
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
