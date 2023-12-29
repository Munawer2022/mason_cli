import 'dart:io';
import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;

Future<void> run(HookContext context) async {
  final progress = context.logger.progress('Installing packages');
  final name = (context.vars['name'] as String? ?? "").trim().pascalCase;

  // void appendAtEndOfProvidersList(String content) {
  //   File file = File('lib/main.dart');
  //   String fileContent = file.readAsStringSync();

  //   // Find the position of runApp(MultiProvider(providers: [
  //   int runAppIndex = fileContent.indexOf('runApp(MultiProvider(providers: [');

  //   if (runAppIndex != -1) {
  //     int endProvidersIndex = fileContent.indexOf(']', runAppIndex);

  //     if (endProvidersIndex != -1) {
  //       String start = fileContent.substring(0, endProvidersIndex);
  //       String end = fileContent.substring(endProvidersIndex);

  //       String updatedContent = '$start\n$content\n$end';

  //       file.writeAsStringSync(updatedContent);
  //       print('Content appended at the end of providers list.');
  //     } else {
  //       print('End of providers list (]) not found after runApp');
  //     }
  //   } else {
  //     print('runApp(MultiProvider(providers: [ not found in the file.');
  //   }
  // }
  void addImportAndProvider(String importStatement, String providerStatement) {
    File file = File('lib/main.dart');
    String fileContent = file.readAsStringSync();

    int importBlockIndex = fileContent.indexOf('import ');

    if (importBlockIndex != -1) {
      // Find the end of the import block
      int endOfImportBlockIndex = fileContent.indexOf(';', importBlockIndex);
      if (endOfImportBlockIndex != -1) {
        // Insert new import at the end of existing imports
        String updatedContent =
            '${fileContent.substring(0, endOfImportBlockIndex + 1)}\n$importStatement\n${fileContent.substring(endOfImportBlockIndex + 1)}';

        // Find the start of runApp(MultiProvider(providers: [
        int runAppIndex =
            fileContent.indexOf('runApp(MultiProvider(providers: [');
        if (runAppIndex != -1) {
          int endProvidersIndex = fileContent.indexOf(']', runAppIndex);

          if (endProvidersIndex != -1) {
            // Append the provider statement after the existing providers
            updatedContent =
                '${updatedContent.substring(0, endProvidersIndex)}$providerStatement\n${updatedContent.substring(endProvidersIndex)}';

            file.writeAsStringSync(updatedContent);
            print('Import and provider added successfully.');
            return;
          }
        }
      }
    }

    print('Failed to add import or provider.');
  }

  String importStatement = "import 'view_model/hello_view_model.dart';";

  String providerStatement =
      '\nChangeNotifierProvider(create: (_) => ${name}ViewModel()),';

  // appendAtEndOfProvidersList(additionalContent);
  addImportAndProvider(importStatement, providerStatement);

//

  void moveFileToDirectory(String sourcePath, String destinationDirectory) {
    File sourceFile = File(sourcePath);

    if (sourceFile.existsSync()) {
      Directory(destinationDirectory).createSync(recursive: true);
      String destinationPath =
          '$destinationDirectory/${sourceFile.path.split('/').last}';

      sourceFile.copy(destinationPath).then((_) {
        sourceFile
            .delete()
            .then((_) => print('File moved successfully.'))
            .catchError((error) => print('Error deleting source file: $error'));
      }).catchError((error) => print('Error copying file: $error'));
    } else {
      print('Source file does not exist.');
    }
  }

  String sourcePath = '${name.snakeCase}_view.dart';
  String destinationDirectory = 'lib/data';
  moveFileToDirectory(sourcePath, destinationDirectory);
}
