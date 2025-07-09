import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final progress = context.logger.progress('🧱 Setting up feature folder');

  // Display detected versions
  final flutterVersion = context.vars['flutter_version'] ?? 'Unknown';
  final dartVersion = context.vars['dart_version'] ?? 'Unknown';
  final javaVersion = context.vars['java_version'] ?? 'Unknown';

  context.logger.info('📋 Detected Versions:');
  context.logger.info('   Flutter: $flutterVersion');
  context.logger.info('   Dart: $dartVersion');
  context.logger.info('   Java: $javaVersion');

  final name = (context.vars['name'] as String? ?? "").trim().pascalCase;
  final isPost = context.vars['isPost'] as bool? ?? false;
  final isGet = context.vars['isGet'] as bool? ?? false;

  context.logger.info('🎯 Generating feature: $name');

  void appendAtEndOfProvidersList(String content) {
    File file = File('lib/injection_container.dart');
    if (!file.existsSync()) {
      context.logger.warn(
          '⚠️  injection_container.dart not found. Skipping dependency injection setup.');
      return;
    }

    String fileContent = file.readAsStringSync();

    int runAppIndex = fileContent.indexOf('Future<void> init() async {');

    if (runAppIndex != -1) {
      int endProvidersIndex = fileContent.indexOf('}', runAppIndex);

      if (endProvidersIndex != -1) {
        String start = fileContent.substring(0, endProvidersIndex);
        String end = fileContent.substring(endProvidersIndex);

        String updatedContent = '$start$content\n$end';

        file.writeAsStringSync(updatedContent);
        context.logger.success('✅ Added $name to dependency injection');
      } else {
        context.logger.warn('⚠️  Could not find end of init() function');
      }
    } else {
      context.logger.warn(
          '⚠️  Could not find init() function in injection_container.dart');
    }
  }

  void addImportAtTop(String importStatement, String whereToImport) {
    File file = File(whereToImport);
    if (!file.existsSync()) {
      context.logger
          .warn('⚠️  $whereToImport not found. Skipping import setup.');
      return;
    }

    String fileContent = file.readAsStringSync();

    int importBlockIndex = fileContent.indexOf('import ');

    if (importBlockIndex != -1) {
      String updatedContent = '$importStatement\n$fileContent';

      file.writeAsStringSync(updatedContent);
      context.logger.success('✅ Added imports for $name');
    } else {
      context.logger.warn('⚠️  Could not find import block in $whereToImport');
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
''';
  addImportAtTop(importStatement, 'lib/injection_container.dart');

  String providerStatement;
  providerStatement = '''
/*
************************ ${name} ************************
*/
  getIt.registerSingleton<${name}Navigator>(${name}Navigator(getIt()));
  getIt.registerFactoryParam<${name}Cubit, ${name}InitialParams, dynamic>(
      (params, _) => ${name}Cubit(params, getIt()
      ${isGet ? ', getIt()' : ''}
      ${isPost ? ', getIt(), getIt()' : ''}
      )
      ${isGet ? '..${name.camelCase}()' : ''}
      );
''';
  appendAtEndOfProvidersList(providerStatement);

  void moveFileToDirectory(String sourcePath, String destinationDirectory) {
    Directory sourceDir = Directory(sourcePath);

    if (sourceDir.existsSync()) {
      Directory destinationDir = Directory(destinationDirectory);
      if (!destinationDir.existsSync()) {
        destinationDir.createSync(recursive: true);
      }

      String sourceName = sourceDir.path.split(Platform.pathSeparator).last;
      String cleanedSourceName = sourceName.split('_').first;

      String destinationPath = '${destinationDir.path}/$cleanedSourceName';

      try {
        sourceDir.renameSync(destinationPath);
        context.logger.success('✅ Moved $sourceName to $destinationDirectory');
      } catch (e) {
        context.logger.warn('⚠️  Error moving $sourceName: $e');
      }
    } else {
      context.logger.warn('⚠️  Source folder $sourcePath does not exist');
    }
  }

  // Move feature files to their proper locations
  context.logger.info('📁 Organizing feature files...');

  String sourcePath = name.snakeCase;
  String destinationDirectory = 'lib/features';
  moveFileToDirectory(sourcePath, destinationDirectory);

  String sourcePath4 = '${name.snakeCase}_entitie';
  String destinationDirector4 = 'lib/domain/entities';
  moveFileToDirectory(sourcePath4, destinationDirector4);

  String sourcePath2 = '${name.snakeCase}_failure';
  String destinationDirector2 = 'lib/domain/failures';
  moveFileToDirectory(sourcePath2, destinationDirector2);

  String sourcePath3 = '${name.snakeCase}_base_api_service';
  String destinationDirector3 = 'lib/domain/repositories';
  moveFileToDirectory(sourcePath3, destinationDirector3);

  String sourcePath6 = '${name.snakeCase}_usecase';
  String destinationDirector6 = 'lib/domain/usecases';
  moveFileToDirectory(sourcePath6, destinationDirector6);

  String sourcePath5 = '${name.snakeCase}_repositorie';
  String destinationDirector5 = 'lib/data/repositories';
  moveFileToDirectory(sourcePath5, destinationDirector5);

  String sourcePath7 = '${name.snakeCase}_datasource';
  String destinationDirector7 = 'lib/data/datasources';
  moveFileToDirectory(sourcePath7, destinationDirector7);

  String sourcePath8 = '${name.snakeCase}_model';
  String destinationDirector8 = 'lib/data/models';
  moveFileToDirectory(sourcePath8, destinationDirector8);

  // Move test files
  context.logger.info('🧪 Organizing test files...');

  String testSource = "${name.snakeCase}_test";
  String testDestinationDirectory = 'test/features';
  moveFileToDirectory(testSource, testDestinationDirectory);

  String testSource1 = '${name.snakeCase}_entitie_test';
  String testDestinationDirectory4 = 'test/domain/entities';
  moveFileToDirectory(testSource1, testDestinationDirectory4);

  String testSource2 = '${name.snakeCase}_failure_test';
  String testDestinationDirectory2 = 'test/domain/failures';
  moveFileToDirectory(testSource2, testDestinationDirectory2);

  String testSource3 = '${name.snakeCase}_base_api_service_test';
  String testDestinationDirectory3 = 'test/domain/repositories';
  moveFileToDirectory(testSource3, testDestinationDirectory3);

  String testSource6 = '${name.snakeCase}_usecase_test';
  String testDestinationDirectory6 = 'test/domain/usecases';
  moveFileToDirectory(testSource6, testDestinationDirectory6);

  String testSource5 = '${name.snakeCase}_repositorie_test';
  String testDestinationDirectory5 = 'test/data/repositories';
  moveFileToDirectory(testSource5, testDestinationDirectory5);

  String testSource7 = '${name.snakeCase}_datasource_test';
  String testDestinationDirectory7 = 'test/data/datasources';
  moveFileToDirectory(testSource7, testDestinationDirectory7);

  String testSource8 = '${name.snakeCase}_model_test';
  String testDestinationDirectory8 = 'test/data/models';
  moveFileToDirectory(testSource8, testDestinationDirectory8);

  void appUrl(String content) {
    File file = File('lib/core/utils/app_url.dart');
    if (!file.existsSync()) {
      context.logger.warn('⚠️  app_url.dart not found. Skipping URL setup.');
      return;
    }

    String fileContent = file.readAsStringSync();

    int runAppIndex = fileContent.indexOf('abstract class AppUrl {');

    if (runAppIndex != -1) {
      int endProvidersIndex = fileContent.indexOf('}', runAppIndex);

      if (endProvidersIndex != -1) {
        String start = fileContent.substring(0, endProvidersIndex);
        String end = fileContent.substring(endProvidersIndex);

        String updatedContent = '$start$content\n$end';

        file.writeAsStringSync(updatedContent);
        context.logger.success('✅ Added $name URLs to app_url.dart');
      } else {
        context.logger.warn('⚠️  Could not find end of AppUrl class');
      }
    } else {
      context.logger.warn('⚠️  Could not find AppUrl class in app_url.dart');
    }
  }

  // Add API URLs if needed
  if (isGet || isPost) {
    context.logger.info('🌐 Setting up API URLs...');
    String urlContent = '''
  // ${name} URLs
  static const String ${name.camelCase}Url = '/${name.snakeCase}';
''';
    appUrl(urlContent);
  }

  // Display completion message
  context.logger.info('');
  context.logger.info('🎉 Feature "$name" generated successfully!');
  context.logger.info('');
  context.logger.info('📋 Generated files:');
  context.logger.info('   📂 lib/features/${name.snakeCase}/');
  context.logger.info('   📂 lib/domain/entities/${name.snakeCase}/');
  context.logger.info('   📂 lib/domain/failures/${name.snakeCase}/');
  context.logger.info('   📂 lib/domain/repositories/${name.snakeCase}/');
  context.logger.info('   📂 lib/domain/usecases/${name.snakeCase}/');
  context.logger.info('   📂 lib/data/repositories/${name.snakeCase}/');
  context.logger.info('   📂 lib/data/datasources/${name.snakeCase}/');
  context.logger.info('   📂 lib/data/models/${name.snakeCase}/');
  context.logger.info('   📂 test/features/${name.snakeCase}/');
  context.logger.info('');
  context.logger.info('🔧 Next steps:');
  context.logger.info('   1. Review the generated files');
  context.logger.info('   2. Implement your business logic');
  context.logger.info('   3. Add your API endpoints');
  context.logger.info('   4. Write your tests');
  context.logger.info('   5. Integrate with your navigation');
  context.logger.info('');
  context.logger.info('🧪 To test your feature:');
  context.logger.info('   flutter test test/features/${name.snakeCase}/');
  context.logger.info('');

  progress.complete();
}
