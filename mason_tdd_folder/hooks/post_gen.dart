import 'dart:io';
import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;

Future<void> run(HookContext context) async {
  // final progress = context.logger.progress('Installing packages');
  final name = (context.vars['name'] as String? ?? "").trim().pascalCase;
  final isPost = context.vars['isPost'] as bool? ?? false;
  final isGet = context.vars['isGet'] as bool? ?? false;

  void appendAtEndOfProvidersList(String content) {
    File file = File('lib/injection_container.dart');
    String fileContent = file.readAsStringSync();

    int runAppIndex = fileContent.indexOf('Future<void> init() async {');

    if (runAppIndex != -1) {
      int endProvidersIndex = fileContent.indexOf('}', runAppIndex);

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
      print('Future<void> init() async { not found in the file.');
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
  importStatement = '''
/*
************************ ${name} ************************
*/
import 'features/${name.snakeCase}/${name.snakeCase}_cubit.dart';
import 'features/${name.snakeCase}/${name.snakeCase}_navigator.dart';
import 'features/${name.snakeCase}/${name.snakeCase}_initial_params.dart';
import 'data/repositories/${name.snakeCase}/${name.snakeCase}_repository.dart';
import 'domain/repositories/${name.snakeCase}/${name.snakeCase}_base_api_service.dart';
''';
  addImportAtTop(importStatement, 'lib/injection_container.dart');

  String providerStatement;
  providerStatement = '''
/*
************************ ${name} ************************
*/
  getIt.registerSingleton<${name}BaseApiService>(${name}Repository(getIt()));
  // getIt.registerSingleton<${name}BaseApiService>(Mock${name}Repository());
  getIt.registerSingleton<${name}Navigator>(${name}Navigator(getIt()));
  getIt.registerFactoryParam<${name}Cubit, ${name}InitialParams, dynamic>(
      (params, _) => ${name}Cubit(params, getIt()
      ${isGet ? ', getIt()' : ''}
      ${isPost ? ', getIt()' : ''}
      )
      ${isGet ? '..${name.snakeCase}()' : ''}
      );
''';
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

  String sourcePath = name.snakeCase;
  String destinationDirectory = 'lib/features';
  moveFileToDirectory(sourcePath, destinationDirectory);
  //
  String sourcePath4 = '${name.snakeCase}_entitie';
  String destinationDirector4 = 'lib/domain/entities';
  moveFileToDirectory(sourcePath4, destinationDirector4);

  String sourcePath2 = '${name.snakeCase}_failure';
  String destinationDirector2 = 'lib/domain/failures';
  moveFileToDirectory(sourcePath2, destinationDirector2);
  //
  String sourcePath3 = '${name.snakeCase}_base_api_service';
  String destinationDirector3 = 'lib/domain/repositories';
  moveFileToDirectory(sourcePath3, destinationDirector3);
  //
  String sourcePath6 = '${name.snakeCase}_usecase';
  String destinationDirector6 = 'lib/domain/usecases';
  moveFileToDirectory(sourcePath6, destinationDirector6);

  String sourcePath5 = '${name.snakeCase}_repositorie';
  String destinationDirector5 = 'lib/data/repositories';
  moveFileToDirectory(sourcePath5, destinationDirector5);
  //
  String sourcePath7 = '${name.snakeCase}_datasource';
  String destinationDirector7 = 'lib/data/datasources';
  moveFileToDirectory(sourcePath7, destinationDirector7);
  //
  String sourcePath8 = '${name.snakeCase}_model';
  String destinationDirector8 = 'lib/data/models';
  moveFileToDirectory(sourcePath8, destinationDirector8);

  //test
  String testSource = "${name.snakeCase}_test";
  String testDestinationDirectory = 'test/features';
  moveFileToDirectory(testSource, testDestinationDirectory);
  //
  String testSource1 = '${name.snakeCase}_entitie_test';
  String testDestinationDirectory4 = 'test/domain/entities';
  moveFileToDirectory(testSource1, testDestinationDirectory4);

  String testSource2 = '${name.snakeCase}_failure_test';
  String testDestinationDirectory2 = 'test/domain/failures';
  moveFileToDirectory(testSource2, testDestinationDirectory2);
  //
  String testSource3 = '${name.snakeCase}_base_api_service_test';
  String testDestinationDirectory3 = 'test/domain/repositories';
  moveFileToDirectory(testSource3, testDestinationDirectory3);
  //
  String testSource6 = '${name.snakeCase}_usecase_test';
  String testDestinationDirectory6 = 'test/domain/usecases';
  moveFileToDirectory(testSource6, testDestinationDirectory6);

  String testSource5 = '${name.snakeCase}_repositorie_test';
  String testDestinationDirectory5 = 'test/data/repositories';
  moveFileToDirectory(testSource5, testDestinationDirectory5);
  //
  String testSource7 = '${name.snakeCase}_datasource_test';
  String testDestinationDirectory7 = 'test/data/datasources';
  moveFileToDirectory(testSource7, testDestinationDirectory7);
  //
  String testSource8 = '${name.snakeCase}_model_test';
  String testDestinationDirectory8 = 'test/data/models';
  moveFileToDirectory(testSource8, testDestinationDirectory8);

//

  void appUrl(String content) {
    File file = File('lib/core/app_url.dart');
    String fileContent = file.readAsStringSync();

    int runAppIndex = fileContent.indexOf('abstract class AppUrl {');

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

//

  // void routeName(String content) {
  //   File file = File('lib/utils/routes/routes_name.dart');
  //   String fileContent = file.readAsStringSync();

  //   int runAppIndex = fileContent.indexOf('class RoutesName {');

  //   if (runAppIndex != -1) {
  //     int endProvidersIndex = fileContent.indexOf('}', runAppIndex);

  //     if (endProvidersIndex != -1) {
  //       String start = fileContent.substring(0, endProvidersIndex);
  //       String end = fileContent.substring(endProvidersIndex);

  //       String updatedContent = '$start$content\n$end';

  //       file.writeAsStringSync(updatedContent);
  //       print('Content appended at the end of providers list.');
  //     } else {
  //       print('End of providers list (}) not found after runApp');
  //     }
  //   } else {
  //     print('class RoutesName { not found in the file.');
  //   }
  // }

  // String routeText =
  //     "static const String ${name.snakeCase} = '${name.snakeCase}';";

  // routeName(routeText);

//

  // void addRouteCase(String caseContent) {
  //   File file = File('lib/utils/routes/routes.dart');
  //   String fileContent = file.readAsStringSync();

  //   int switchIndex = fileContent.indexOf('switch (settings.name) {');

  //   if (switchIndex != -1) {
  //     int defaultIndex = fileContent.indexOf('default:', switchIndex);

  //     if (defaultIndex != -1) {
  //       String start = fileContent.substring(0, defaultIndex);
  //       String end = fileContent.substring(defaultIndex);

  //       String updatedContent = '$start\n$caseContent\n$end';

  //       file.writeAsStringSync(updatedContent);
  //       print('Case statement added successfully.');
  //     } else {
  //       print('Default case not found after the switch statement.');
  //     }
  //   } else {
  //     print('Switch statement not found in the file.');
  //   }
  // }

  // String route =
  //     "case RoutesName.${name.snakeCase}:\nreturn pageRoute.getPageRoute(const ${name}View());";

  // addRouteCase(route);
  // String import = "import '/view/${name.snakeCase}_view.dart';";

  // addImportAtTop(import, 'lib/utils/routes/routes.dart');
}
