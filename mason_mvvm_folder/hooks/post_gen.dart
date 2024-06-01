import 'dart:io';
import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;

Future<void> run(HookContext context) async {
  // final progress = context.logger.progress('Installing packages');
  final name = (context.vars['name'] as String? ?? "").trim().pascalCase;
  final isPost = context.vars['isPost'] as bool? ?? false;
  final isGet = context.vars['isGet'] as bool? ?? false;

  void appendAtEndOfProvidersList(String content) {
    File file =
        File('lib/view_model/injection/multi_provider_list_injection.dart');
    String fileContent = file.readAsStringSync();

    int runAppIndex = fileContent.indexOf(
        'List<ChangeNotifierProvider> multiProvidersListInjection = [');

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

  void addImportAtTop(String importStatement, String whereToImport) {
    File file = File(whereToImport);
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

  String importStatement;
  if (isPost || isGet) {
    importStatement = '''
/*
 ************************ $name ************************
*/
import '/view_model/${name.snakeCase}/${name.snakeCase}_view_model.dart';
''';
  } else {
    importStatement = "";
  }

  addImportAtTop(importStatement,
      'lib/view_model/injection/multi_provider_list_injection.dart');

  String providerStatement;
  if (isPost || isGet) {
    providerStatement = '''
/*
 ************************ $name ************************
*/
  ChangeNotifierProvider<${name}ViewModel>(
    create: (_) => getIt()
  ),
''';
  } else {
    providerStatement = "";
  }

  appendAtEndOfProvidersList(providerStatement);

//

  // void moveFileToDirectory(String sourcePath, String destinationDirectory) {
  //   File sourceFile = File(sourcePath);

  //   if (sourceFile.existsSync()) {
  //     Directory(destinationDirectory).createSync(recursive: true);
  //     String destinationPath =
  //         '$destinationDirectory/${sourceFile.path.split('/').last}';

  //     sourceFile.copy(destinationPath).then((_) {
  //       sourceFile
  //           .delete()
  //           .then((_) => print('File moved successfully.'))
  //           .catchError((error) => print('Error deleting source file: $error'));
  //     }).catchError((error) => print('Error copying file: $error'));
  //   } else {
  //     print('Source file does not exist.');
  //   }
  // }
  void moveFileToDirectory(String sourcePath, String destinationDirectory) {
    Directory sourceDir = Directory(sourcePath);

    if (sourceDir.existsSync()) {
      Directory destinationDir = Directory(destinationDirectory);
      if (!destinationDir.existsSync()) {
        destinationDir.createSync(recursive: true);
      }

      String destinationPath =
          '${destinationDir.path}/${sourceDir.path.split(Platform.pathSeparator).last}';

      try {
        sourceDir.renameSync(destinationPath);
        print('Folder moved successfully.');
      } catch (e) {
        print('Error moving folder: $e');
      }
    } else {
      print('Source folder does not exist.');
    }
  }

  String sourcePath = '${name.snakeCase}_view_model';
  String destinationDirectory = 'lib/view_model';
  moveFileToDirectory(sourcePath, destinationDirectory);
  String sourcePath2 = name.snakeCase;
  String destinationDirector2 = 'lib/view';
  moveFileToDirectory(sourcePath2, destinationDirector2);
  String sourcePath3 = '${name.snakeCase}_repo';
  String destinationDirector3 = 'lib/repository';
  moveFileToDirectory(sourcePath3, destinationDirector3);

  String sourcePath4 = '${name.snakeCase}_model';
  String destinationDirector4 = 'lib/model';
  moveFileToDirectory(sourcePath4, destinationDirector4);

//

  void appUrl(String content) {
    File file = File('lib/resource/app_url.dart');
    String fileContent = file.readAsStringSync();

    int runAppIndex = fileContent.indexOf('class AppUrl {');

    if (runAppIndex != -1) {
      int endProvidersIndex = fileContent.indexOf('}', runAppIndex);

      if (endProvidersIndex != -1) {
        String start = fileContent.substring(0, endProvidersIndex);
        String end = fileContent.substring(endProvidersIndex);

        String updatedContent = '$start$content\n$end';

        file.writeAsStringSync(updatedContent);
        print('Content appended at the end of providers list.');
      } else {
        print('End of providers list (}) not found after runApp');
      }
    } else {
      print('runApp(MultiProvider(providers: { not found in the file.');
    }
  }

  String nameUrl;
  if (isPost || isGet) {
    nameUrl = "static var ${name.snakeCase} = 'baseUrl/${name.snakeCase}';";
  } else {
    nameUrl = '';
  }

  appUrl(nameUrl);
  void typeDef(String content) {
    File file = File('lib/utils/typedef_models.dart');
    String fileContent = file.readAsStringSync();

    int runAppIndex = fileContent.indexOf('');

    if (runAppIndex != -1) {
      int endProvidersIndex = fileContent.indexOf('', runAppIndex);

      if (endProvidersIndex != -1) {
        String start = fileContent.substring(0, endProvidersIndex);
        String end = fileContent.substring(endProvidersIndex);

        String updatedContent = '$start$content\n$end';

        file.writeAsStringSync(updatedContent);
        print('Content appended at the end of providers list.');
      } else {
        print('End of providers list (}) not found after runApp');
      }
    } else {
      print('runApp(MultiProvider(providers: { not found in the file.');
    }
  }

  String typeDefVar;
  if (isPost || isGet) {
    typeDefVar = """
/*
************************ $name ************************
*/
typedef Typedef$name = ${name}Model;
""";
  } else {
    typeDefVar = '';
  }

  typeDef(typeDefVar);

  String typeDefAddImportAtTopVar;
  if (isPost || isGet) {
    typeDefAddImportAtTopVar = '''
/*
 ************************ $name ************************
*/
import '/model/${name.snakeCase}/${name.snakeCase}_model.dart';
''';
  } else {
    typeDefAddImportAtTopVar = "";
  }

  addImportAtTop(typeDefAddImportAtTopVar, 'lib/utils/typedef_models.dart');

// ************************  ************************************************************************************************

  void routeName(String content) {
    File file = File('lib/utils/routes/routes_name.dart');
    String fileContent = file.readAsStringSync();

    int runAppIndex = fileContent.indexOf('class RoutesName {');

    if (runAppIndex != -1) {
      int endProvidersIndex = fileContent.indexOf('}', runAppIndex);

      if (endProvidersIndex != -1) {
        String start = fileContent.substring(0, endProvidersIndex);
        String end = fileContent.substring(endProvidersIndex);

        String updatedContent = '$start$content\n$end';

        file.writeAsStringSync(updatedContent);
        print('Content appended at the end of providers list.');
      } else {
        print('End of providers list (}) not found after runApp');
      }
    } else {
      print('class RoutesName { not found in the file.');
    }
  }

  String routeText =
      "static const String ${name.snakeCase} = '${name.snakeCase}';";

  routeName(routeText);

//
  void addRouteCase(String caseContent) {
    File file = File('lib/utils/routes/routes.dart');
    String fileContent = file.readAsStringSync();

    int switchIndex = fileContent.indexOf('switch (settings.name) {');

    if (switchIndex != -1) {
      int defaultIndex = fileContent.indexOf('default:', switchIndex);

      if (defaultIndex != -1) {
        String start = fileContent.substring(0, defaultIndex);
        String end = fileContent.substring(defaultIndex);

        String updatedContent = '$start\n$caseContent\n$end';

        file.writeAsStringSync(updatedContent);
        print('Case statement added successfully.');
      } else {
        print('Default case not found after the switch statement.');
      }
    } else {
      print('Switch statement not found in the file.');
    }
  }

  String route =
      "case RoutesName.${name.snakeCase}:\nreturn pageRoute.getPageRoute(const ${name}View());";

  addRouteCase(route);
  String import =
      "import '/view/${name.snakeCase}/${name.snakeCase}_view.dart';";

  addImportAtTop(import, 'lib/utils/routes/routes.dart');
}
