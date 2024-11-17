import 'dart:io';
import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final progress = context.logger.progress('Installing packages');

  // Read pubspec.yaml file
  final pubspec = File('pubspec.yaml');
  final lines = pubspec.readAsLinesSync();

  // Function to check if a package is already in pubspec.yaml
  bool isPackageInPubspec(String package) {
    return lines.any((line) => line.contains(package));
  }

  // List of packages to add to dependencies
  final dependencies = [
    'flutter_bloc',
    'get_it',
    'flutter_screenutil',
    'http',
    'http_interceptor',
    'shared_preferences',
    'equatable',
    'fpdart',
    'shimmer',
    'connectivity_plus'
  ];

  // Add dependencies if not already present
  for (var package in dependencies) {
    if (!isPackageInPubspec(package)) {
      await Process.runSync('flutter', ['pub', 'add', package],
          runInShell: true);
    }
  }

  final dev_dependencies = [
    // 'bloc_test',
    // 'mockito',
    // 'mocktail',
    'device_preview',
  ];

  // Add dev_dependencies if not already present
  for (var package in dev_dependencies) {
    if (!isPackageInPubspec(package)) {
      await Process.runSync('flutter', ['pub', 'add', package, '--dev'],
          runInShell: true);
    }
  }

  // Run flutter pub get after adding all packages
  await Process.runSync('flutter', ['pub', 'get'], runInShell: true);

  progress.complete();
}
