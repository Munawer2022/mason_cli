import 'dart:io';
import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;

Future<void> run(HookContext context) async {
  final progress = context.logger.progress('Installing packages');
  final name = (context.vars['name'] as String? ?? "").trim().pascalCase;

  void appendAtEndOfProvidersList(String content) {
    File file = File('lib/main.dart');
    String fileContent = file.readAsStringSync();

    int runAppIndex = fileContent.indexOf('runApp(MultiProvider(providers: [');

    if (runAppIndex != -1) {
      int endProvidersIndex = fileContent.indexOf(']', runAppIndex);

      if (endProvidersIndex != -1) {
        String start = fileContent.substring(0, endProvidersIndex);
        String end = fileContent.substring(endProvidersIndex);

        String updatedContent = '$start$content\n$end';

        file.writeAsStringSync(updatedContent);
        print('Content appended at the end of providers list.');
      } else {
        print('End of providers list (]) not found after runApp');
      }
    } else {
      print('runApp(MultiProvider(providers: [ not found in the file.');
    }
  }

  void addImportAtTop(String importStatement) {
    File file = File('lib/main.dart');
    String fileContent = file.readAsStringSync();

    int importBlockIndex = fileContent.indexOf('import ');

    if (importBlockIndex != -1) {
      String updatedContent = '$importStatement\n$fileContent';

      file.writeAsStringSync(updatedContent);
      print('Import statement added at the top of the file.');
    } else {
      print('Failed to find the import block.');
    }
  }

  String importStatement =
      "import 'view_model/${name.snakeCase}_view_model.dart';";

  addImportAtTop(importStatement);

  String providerStatement =
      '\nChangeNotifierProvider(create: (_) => ${name}ViewModel()),';

  appendAtEndOfProvidersList(providerStatement);

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

  String sourcePath = '${name.snakeCase}_view_model.dart';
  String destinationDirectory = 'lib/view_model';
  moveFileToDirectory(sourcePath, destinationDirectory);
  String sourcePath2 = '${name.snakeCase}_view.dart';
  String destinationDirector2 = 'lib/view';
  moveFileToDirectory(sourcePath2, destinationDirector2);
  String sourcePath3 = '${name.snakeCase}_repository.dart';
  String destinationDirector3 = 'lib/repository';
  moveFileToDirectory(sourcePath3, destinationDirector3);
}
