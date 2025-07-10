import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final progress = context.logger.progress('🚀 Setting up Flutter TDD project');

  // Display detected versions
  final flutterVersion = context.vars['flutter_version'] ?? 'Unknown';
  final dartVersion = context.vars['dart_version'] ?? 'Unknown';
  final javaVersion = context.vars['java_version'] ?? 'Unknown';

  context.logger.info('📋 Detected Versions:');
  context.logger.info('   Flutter: $flutterVersion');
  context.logger.info('   Dart: $dartVersion');
  context.logger.info('   Java: $javaVersion');

  // Check if pubspec.yaml exists
  final pubspec = File('pubspec.yaml');
  if (!pubspec.existsSync()) {
    context.logger.err(
        '❌ pubspec.yaml not found. Please run this brick in a Flutter project directory.');
    return;
  }

  final lines = pubspec.readAsLinesSync();

  // Function to check if a package is already in pubspec.yaml
  bool isPackageInPubspec(String package) {
    return lines.any((line) => line.contains(package));
  }

  // Function to add package with feedback
  Future<void> addPackage(String package, {bool isDev = false}) async {
    if (!isPackageInPubspec(package)) {
      context.logger.info('📦 Adding $package...');
      final result = await Process.runSync('flutter',
          isDev ? ['pub', 'add', package, '--dev'] : ['pub', 'add', package],
          runInShell: true);

      if (result.exitCode == 0) {
        context.logger.success('✅ Added $package');
      } else {
        context.logger.warn('⚠️  Failed to add $package: ${result.stderr}');
      }
    } else {
      context.logger.info('ℹ️  $package already exists');
    }
  }

  // Core dependencies
  context.logger.info('🔧 Installing core dependencies...');
  final dependencies = [
    'flutter_bloc',
    'get_it',
    'flutter_screenutil',
    'http',
    'http_interceptor',
    'shared_preferences',
    // 'equatable',
    'fpdart',
    'shimmer',
    'connectivity_plus',
    'cached_network_image'
  ];

  for (var package in dependencies) {
    await addPackage(package);
  }

  // Development dependencies
  context.logger.info('🔧 Installing development dependencies...');
  final devDependencies = [
    'device_preview',
    // 'bloc_test',
    // 'mockito',
    // 'mocktail',
    // 'build_runner',
  ];

  for (var package in devDependencies) {
    await addPackage(package, isDev: true);
  }

  // Run flutter pub get
  context.logger.info('🔄 Running flutter pub get...');
  final getResult =
      await Process.runSync('flutter', ['pub', 'get'], runInShell: true);

  if (getResult.exitCode == 0) {
    context.logger.success('✅ Dependencies installed successfully');
  } else {
    context.logger.err('❌ Failed to install dependencies: ${getResult.stderr}');
  }

  // Generate build runner files if needed
  context.logger.info('🔨 Generating build runner files...');
  final buildResult = await Process.runSync(
      'flutter', ['packages', 'pub', 'run', 'build_runner', 'build'],
      runInShell: true);

  if (buildResult.exitCode == 0) {
    context.logger.success('✅ Build runner completed');
  } else {
    context.logger.warn(
        '⚠️  Build runner failed (this is normal if no generated files are needed)');
  }

  // Display next steps
  context.logger.info('');
  context.logger.info('🎉 Project setup complete!');
  context.logger.info('');
  context.logger.info('📋 Next steps:');
  context.logger.info('   1. Review the generated architecture');
  context.logger.info('   2. Configure your API endpoints in config/');
  context.logger.info(
      '   3. Set up your dependency injection in injection_container.dart');
  context.logger.info('   4. Start building your features!');
  context.logger.info('');
  context.logger.info('🧪 To run tests:');
  context.logger.info('   flutter test');
  context.logger.info('');
  context.logger.info('🚀 To run the app:');
  context.logger.info('   flutter run');
  context.logger.info('');

  progress.complete();
}
