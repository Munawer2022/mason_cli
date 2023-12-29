import 'dart:io';
import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;

Future<void> run(HookContext context) async {
  final progress = context.logger.progress('Installing packages');

  // final generate = await MasonGenerator.fromBundle(MasonBundle(
  //     name: 'mason_mvvm',
  //     description: 'A new brick created with the Mason CLI',
  //     version: '0.1.0+1'));
  // await generate.generate(DirectoryGeneratorTarget(Directory(path.join(
  //     Directory.current.path,
  //     'lib',
  //     (context.vars['name'] as String).snakeCase))));

  void appendToFile(String content) {
    File file = File('main.dart');
    RandomAccessFile appendFile = file.openSync(mode: FileMode.append);
    appendFile.writeStringSync(content);
    appendFile.closeSync();
  }

  String additionalContent = '\nAdditional content to add';
  appendToFile(additionalContent);
  progress.complete();

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

  String sourcePath = 'second_view.dart';
  String destinationDirectory = 'data';
  moveFileToDirectory(sourcePath, destinationDirectory);
}
